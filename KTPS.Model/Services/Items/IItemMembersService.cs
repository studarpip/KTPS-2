using KTPS.Model.Entities.Items;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Items;

public interface IItemMembersService
{
    Task AddItemMemberAsync(ItemMemberBasic itemMember);
}