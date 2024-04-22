using KTPS.Model.Entities.Items;
using System.Threading.Tasks;

namespace KTPS.Model.Repositories.Items;

public interface IItemsRepository
{
    Task<int> InsertAsync(ItemBasic item);
    Task<ItemBasic> GetAsync(int itemId);
    Task UpdateAsync(ItemBasic item);
}