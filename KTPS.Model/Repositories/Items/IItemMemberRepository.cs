using KTPS.Model.Entities.Items;
using System.Threading.Tasks;

namespace KTPS.Model.Repositories.Items;

public interface IItemMemberRepository
{
    Task InsertAsync(ItemMemberBasic itemMember);
}