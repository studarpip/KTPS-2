using KTPS.Model.Entities.Items;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KTPS.Model.Repositories.Items;

public interface IItemsRepository
{
    Task<int> InsertAsync(ItemBasic item);
    Task<ItemBasic> GetAsync(int itemId);
    Task UpdateAsync(ItemBasic item);
    Task<IEnumerable<ItemBasic>> GetByGroupAsync(int groupId);
    Task DeleteAsync(int id);
}