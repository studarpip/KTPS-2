using KTPS.Model.Entities.Items;
using KTPS.Model.Helpers;
using System.Threading.Tasks;

namespace KTPS.Model.Repositories.Items;

public class ItemsRepository : IItemsRepository
{
	private readonly IRepository _repository;

	public ItemsRepository(
		IRepository repository
		)
	{
		_repository = repository;
	}

    public async Task<int> InsertAsync(ItemBasic item)
    {
		var sql = @"INSERT INTO `items` (`GroupId`, `Name`, `Quantity`, `Price`)
					VALUES (@GroupId, @Name, @Quantity, @Price);
					SELECT LAST_INSERT_ID();";

        return await _repository.QueryAsync<int, ItemBasic>(sql, item.MapValuesFromEntity());
    }
}