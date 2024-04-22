using KTPS.Model.Entities;
using KTPS.Model.Entities.Items;
using KTPS.Model.Entities.Requests;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Items;

public interface IItemsService
{
    Task<ServerResult> CreateItemAsync(CreateItemRequest request);
    Task<ServerResult> EditItemAsync(EditItemRequest request);
    Task<IEnumerable<ItemBasic>> GetGroupItemsAsync(int groupId);
    Task<ServerResult<IEnumerable<ItemBasic>>> GetGroupItemListAsync(int groupId);
    Task<ServerResult> DeleteItemAsync(int itemId);
}