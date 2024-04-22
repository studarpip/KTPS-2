using KTPS.Model.Entities.Items;
using KTPS.Model.Helpers;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KTPS.Model.Repositories.Items;

public class ItemMemberRepository : IItemMemberRepository
{
	private readonly IRepository _repository;

	public ItemMemberRepository(
		IRepository repository
		)
	{
		_repository = repository;
	}

	public async Task InsertAsync(ItemMemberBasic itemMember)
	{
		var sql = @"INSERT INTO `item_members` (`ItemId`, `GuestId`, `UserId`)
					VALUES (@ItemId, @GuestId, @UserId);";

		await _repository.ExecuteAsync<dynamic>(sql, itemMember.MapValuesFromEntity());
	}

	public async Task<IEnumerable<ItemMemberBasic>> GetListAsync(int itemid)
	{
		var sql = @"SELECT `Id`, `ItemId`, `GuestId`, `UserId`
					FROM `item_members`
					WHERE `Itemid` = @ItemId;";

		return await _repository.QueryListAsync<ItemMemberBasic, dynamic>(sql, new { ItemId = itemid });
	}

    public async Task DeleteGuestAsync(int guestId)
    {
        var sql = @"DELETE FROM `item_members`
					WHERE `GuestId` = @GuestId;";

       await _repository.ExecuteAsync<dynamic>(sql, new { GuestId = guestId });
    }

    public async Task DeleteUserAsync(int userId)
    {
        var sql = @"DELETE FROM `item_members`
					WHERE `UserId` = @UserId;";

        await _repository.ExecuteAsync<dynamic>(sql, new { UserId = userId });
    }

	public async Task DeleteByItemId(int itemId)
	{
		var sql = @"DELETE FROM `item_members`
					WHERE `ItemId` = @ItemId";

		await _repository.ExecuteAsync<dynamic>(sql, new { ItemId = itemId });
	}
}