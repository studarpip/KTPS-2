using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Items;

public interface IItemsService
{
    Task<ServerResult> CreateItemAsync(CreateItemRequest request);
}