using KTPS.Model.Entities;
using KTPS.Model.Entities.Items;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Repositories.Items;
using KTPS.Model.Services.Groups;
using System;
using System.Collections.Generic;
using System.Linq;
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

    public async Task<ServerResult> EditItemAsync(EditItemRequest request)
    {
        // TO DO: Add database context
        try
        {
            var item = await _itemsRepository.GetAsync(request.ItemId);
            if (item is null)
                return new() { Success = false, Message = "Item does not exist!" };

            item.Name = request.Name;
            item.Price = request.Price;
            item.Quantity = request.Quantity;
            await _itemsRepository.UpdateAsync(item);

            var members = await _itemMembersService.GetMembersAsync(request.ItemId);
            var guests = members.Where(x => x.GuestId is not null).Select(x => x.GuestId.Value).ToList();
            var users = members.Where(x => x.UserId is not null).Select(x => x.UserId.Value).ToList();

            var guestsToAdd = request.GuestIds.Where(x => !guests.Contains(x));
            var usersToAdd = request.UserIds.Where(x => !users.Contains(x));

            foreach (var guest in guestsToAdd)
                await _itemMembersService.AddItemMemberAsync(new() { ItemId = request.ItemId, GuestId = guest });

            foreach (var user in usersToAdd)
                await _itemMembersService.AddItemMemberAsync(new() { ItemId = request.ItemId, UserId = user });

            var guestsToRemove = guests.Where(x => !request.GuestIds.Contains(x));
            var usersToRemove = users.Where(x => !request.UserIds.Contains(x));

            foreach (var guest in guestsToRemove)
                await _itemMembersService.RemoveGuestAsync(guest);

            foreach (var user in usersToRemove)
                await _itemMembersService.RemoveUserAsync(user);

            return new() { Success = true };
        }
        catch (Exception)
        {
            return new() { Success = false, Message = "Technical error!" };
        }
    }

    public async Task<IEnumerable<ItemBasic>> GetGroupItemsAsync(int groupId) => await _itemsRepository.GetByGroupAsync(groupId);

    public async Task<ServerResult<IEnumerable<ItemBasic>>> GetGroupItemListAsync(int groupId)
    {
        try
        {
            var group = await _groupsService.GetGroupBasicAsync(groupId);
            if (group is null)
                return new() { Success = false, Message = "Group does not exist!" };

            var items = await _itemsRepository.GetByGroupAsync(groupId);
            return new() { Success = true, Data = items };
        }
        catch (Exception)
        {
            return new() { Success = false, Message = "Technical error!" };
        }
    }

    public async Task<ServerResult> DeleteItemAsync(int itemId)
    {
        // TO DO: Add database context
        try
        {
            var item = await _itemsRepository.GetAsync(itemId);
            if (item is null)
                return new() { Success = false, Message = "Item does not exist!" };

            await _itemsRepository.DeleteAsync(itemId);
            await _itemMembersService.DeleteByItemIdAsync(itemId);

            return new() { Success = true };
        }
        catch (Exception)
        {
            return new() { Success = false, Message = "Technical error!" };
        }
    }
}