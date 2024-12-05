using KTPS.Model.Entities.Groups;
using KTPS.Model.Entities.Guests;
using KTPS.Model.Entities.Items;
using KTPS.Model.Repositories.GroupMembers;
using KTPS.Model.Repositories.Guests;
using KTPS.Model.Services.Calculation;
using KTPS.Model.Services.Items;
using Moq;

namespace KTPS.Model.Test.Services;

[TestClass]
public class CalculationServiceTest
{
    private ICalculationService? _calculationService;

    private Mock<IItemsService> _itemsServiceMock = new Mock<IItemsService>();
    private Mock<IItemMembersService> _itemsMembersMock = new Mock<IItemMembersService>();
    private Mock<IGuestsRepository> _guestsRepositoryMock = new Mock<IGuestsRepository>();
    private Mock<IGroupMembersRepository> _groupMembersRepositoryMock = new Mock<IGroupMembersRepository>();

    [TestInitialize]
    public void Setup()
    {
        _calculationService = new CalculationService(
            _itemsServiceMock.Object,
            _itemsMembersMock.Object,
            _groupMembersRepositoryMock.Object,
            _guestsRepositoryMock.Object);
    }

    [TestMethod]
    public async Task CalculateGroupExpenses_GroupHasNoItems_ShouldReturnError()
    {
        _itemsServiceMock.Setup(x => x.GetGroupItemsAsync(It.IsAny<int>()))
                         .ReturnsAsync((List<ItemBasic>?)null);

        var result = await _calculationService!.CalculateGroupExpensesAsync(1);
        Assert.IsFalse(result.Success);
        Assert.AreEqual("Group has no items", result.Message);
    }

    [TestMethod]
    public async Task CalculateGroupExpenses_NoGuestsOrGroups_ShouldReturnEmptyResult()
    {
        var groupId = 1;

        var items = new List<ItemBasic>
        {
            new() { Id = 1, Name = "Item 1", Price = 100, Quantity = 1, GroupId = groupId },
            new() { Id = 2, Name = "Item 2", Price = 200, Quantity = 2, GroupId = groupId }
        };

        _itemsServiceMock.Setup(x => x.GetGroupItemsAsync(groupId))
                         .ReturnsAsync(items);

        _guestsRepositoryMock.Setup(x => x.GetByGroupID(groupId))
                             .ReturnsAsync(new List<Guest>());

        _groupMembersRepositoryMock.Setup(x => x.GetByGroupIDAsync(groupId))
                                   .ReturnsAsync(new List<GroupMember>());

        var result = await _calculationService!.CalculateGroupExpensesAsync(groupId);

        Assert.IsTrue(result.Success);
        Assert.AreEqual(300, result.Data.TotalAmount);
        Assert.AreEqual(3, result.Data.TotalItems);
        Assert.IsFalse(result.Data.GuestCalculations.Any());
        Assert.IsFalse(result.Data.UserCalculations.Any());
    }

    [TestMethod]
    public async Task CalculateGroupExpenses_ItemsWithNoMembers_ShouldSkipCalculations()
    {
        var groupId = 1;

        var items = new List<ItemBasic>
        {
            new() { Id = 1, Name = "Item 1", Price = 100, Quantity = 1, GroupId = groupId },
            new() { Id = 2, Name = "Item 2", Price = 200, Quantity = 2, GroupId = groupId }
        };

        _itemsServiceMock.Setup(x => x.GetGroupItemsAsync(groupId))
                         .ReturnsAsync(items);

        _itemsMembersMock.Setup(x => x.GetMembersAsync(It.IsAny<int>()))
                         .ReturnsAsync(new List<ItemMemberBasic>());

        _guestsRepositoryMock.Setup(x => x.GetByGroupID(groupId))
                             .ReturnsAsync(new List<Guest>());

        _groupMembersRepositoryMock.Setup(x => x.GetByGroupIDAsync(groupId))
                                   .ReturnsAsync(new List<GroupMember>());

        var result = await _calculationService!.CalculateGroupExpensesAsync(groupId);

        Assert.IsTrue(result.Success);
        Assert.AreEqual(300, result.Data.TotalAmount);
        Assert.AreEqual(0, result.Data.GuestCalculations.Count);
        Assert.AreEqual(0, result.Data.UserCalculations.Count);
    }

    [TestMethod]
    public async Task CalculateGroupExpenses_ItemsWithMembers_ShouldDistributeCosts()
    {
        var groupId = 1;

        var items = new List<ItemBasic>
        {
            new() { Id = 1, Name = "Item 1", Price = 100, Quantity = 1, GroupId = groupId },
            new() { Id = 2, Name = "Item 2", Price = 200, Quantity = 2, GroupId = groupId }
        };

        var itemMembers = new List<ItemMemberBasic>
        {
            new() { ItemId = 1, UserId = 1 },
            new() { ItemId = 2, UserId = 1 },
            new() { ItemId = 2, UserId = 2 }
        };

        var users = new List<GroupMember>
        {
            new() { Id = 1, Username = "User 1" },
            new() { Id = 2, Username = "User 2" }
        };

        _itemsServiceMock.Setup(x => x.GetGroupItemsAsync(groupId))
                         .ReturnsAsync(items);

        _itemsMembersMock.Setup(x => x.GetMembersAsync(It.IsAny<int>()))
                         .ReturnsAsync(itemMembers);

        _guestsRepositoryMock.Setup(x => x.GetByGroupID(groupId))
                             .ReturnsAsync(new List<Guest>());

        _groupMembersRepositoryMock.Setup(x => x.GetByGroupIDAsync(groupId))
                                   .ReturnsAsync(users);

        var result = await _calculationService!.CalculateGroupExpensesAsync(groupId);

        Assert.IsTrue(result.Success);
        Assert.AreEqual(300, result.Data.TotalAmount);
        Assert.AreEqual(3, result.Data.TotalItems);
        Assert.AreEqual(2, result.Data.UserCalculations.Count);
    }

    [TestMethod]
    public async Task CalculateGroupExpenses_GuestsAndUsers_ShouldCombineResults()
    {
        var groupId = 1;

        var items = new List<ItemBasic>
        {
            new() { Id = 1, Name = "Item 1", Price = 100, Quantity = 1, GroupId = groupId }
        };

        var itemMembers = new List<ItemMemberBasic>
        {
            new() { ItemId = 1, UserId = 1 },
            new() { ItemId = 1, GuestId = 1 }
        };

        var users = new List<GroupMember>
        {
            new() { Id = 1, Username = "User 1" }
        };

        var guests = new List<Guest>
        {
            new() { Id = 1, Name = "Guest 1" }
        };

        _itemsServiceMock.Setup(x => x.GetGroupItemsAsync(groupId))
                         .ReturnsAsync(items);

        _itemsMembersMock.Setup(x => x.GetMembersAsync(It.IsAny<int>()))
                         .ReturnsAsync(itemMembers);

        _guestsRepositoryMock.Setup(x => x.GetByGroupID(groupId))
                             .ReturnsAsync(guests);

        _groupMembersRepositoryMock.Setup(x => x.GetByGroupIDAsync(groupId))
                                   .ReturnsAsync(users);

        var result = await _calculationService!.CalculateGroupExpensesAsync(groupId);

        Assert.IsTrue(result.Success);
        Assert.AreEqual(100, result.Data.TotalAmount);
        Assert.AreEqual(1, result.Data.GuestCalculations.Count);
        Assert.AreEqual(1, result.Data.UserCalculations.Count);
    }
}
