﻿using KTPS.Model.Entities.Items;
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

        return await _repository.QueryAsync<int, dynamic>(sql, item.MapValuesFromEntity());
    }

	public async Task<ItemBasic> GetAsync(int itemId)
	{
		var sql = @"SELECT `Id`, `GroupId`, `Name`, `Quantity`, `Price`
					FROM `items`
					WHERE `Id` = @Id";

		return await _repository.QueryAsync<ItemBasic, dynamic>(sql, new { Id = itemId });
	}

    public async Task UpdateAsync(ItemBasic item)
    {
        var sql = @"UPDATE `items SET`
					`GroupId` = @GroupId,
					`Name` = @Name,
					`Quantity` = @Quantity,
					`Price` = @Price
					WHERE Id = @Id;";

        await _repository.ExecuteAsync<dynamic>(sql, item.MapValuesFromEntity());
    }
}