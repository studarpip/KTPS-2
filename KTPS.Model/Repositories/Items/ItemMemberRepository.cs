using KTPS.Model.Entities.Items;
using KTPS.Model.Helpers;
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

		await _repository.ExecuteAsync<ItemMemberBasic>(sql, itemMember.MapValuesFromEntity());
	}
}