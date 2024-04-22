using KTPS.Model.Entities.Items;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KTPS.Model.Repositories.Items;

public interface IItemMemberRepository
{
    Task InsertAsync(ItemMemberBasic itemMember);
    Task<IEnumerable<ItemMemberBasic>> GetListAsync(int itemid);
    Task DeleteGuestAsync(int guestId);
    Task DeleteUserAsync(int userId);
    Task DeleteByItemId(int itemId);
}