using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Repositories.Items;
using KTPS.Model.Services.Groups;
using System;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Items;

public class ItemsService : IItemsService
{
    private readonly IGroupsService _groupsService;
    private readonly IItemMembersService _itemMembersService;
    private readonly IItemsRepository _itemsRepository;

    public ItemsService(
        IGroupsService groupsService,
        IItemMembersService itemMembersService,
        IItemsRepository itemsRepository
        )
    {
        _groupsService = groupsService;
        _itemMembersService = itemMembersService;
        _itemsRepository = itemsRepository;
    }

    public async Task<ServerResult> CreateItemAsync(CreateItemRequest request)
    {
        try
        {
            var group = await _groupsService.GetGroupBasicAsync(request.GroupId);
            if (group is null)
                return new() { Success = false, Message = "Group does not exist!" };

            var id = await _itemsRepository.InsertAsync(new()
            {
                GroupId = request.GroupId,
                Name = request.Name,
                Quantity = request.Quantity,
                Price = request.Price
            });

            foreach (var guestId in request.GuestIds)
                await _itemMembersService.AddItemMemberAsync(new() { ItemId = id, GuestId = guestId });

            foreach (var userId in request.UserIds)
                await _itemMembersService.AddItemMemberAsync(new() { ItemId = id, UserId = userId });

            return new() { Success = true };
        }
        catch (Exception)
        {
            return new() { Success = false, Message = "Technical error!" };
        }
    }
}