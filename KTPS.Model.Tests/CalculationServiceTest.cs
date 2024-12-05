using KTPS.Model.Repositories.GroupMembers;
using KTPS.Model.Repositories.Guests;
using KTPS.Model.Services.Calculation;
using KTPS.Model.Services.Items;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace KTPS.Model.Tests.Services.Calculations
{
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
            var result = await _calculationService!.CalculateGroupExpensesAsync(1);
            Assert.AreEqual("Group has no items", result.Message);
        }
    }
}
