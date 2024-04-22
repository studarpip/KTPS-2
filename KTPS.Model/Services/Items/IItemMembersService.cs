using KTPS.Model.Entities.Items;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Items;

public interface IItemMembersService
{
    Task AddItemMemberAsync(ItemMemberBasic itemMember);
    Task<IEnumerable<ItemMemberBasic>> GetMembersAsync(int itemId);
    Task RemoveGuestAsync(int guestId);
    Task RemoveUserAsync(int userId);
    Task DeleteByItemIdAsync(int itemId);
}