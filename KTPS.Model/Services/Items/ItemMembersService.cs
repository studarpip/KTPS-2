using KTPS.Model.Entities.Items;
using KTPS.Model.Repositories.Items;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Items;

public class ItemMembersService : IItemMembersService
{
	private readonly IItemMemberRepository _itemMemberRepository;

	public ItemMembersService(
		IItemMemberRepository itemMemberRepository
		)
	{
		_itemMemberRepository = itemMemberRepository;
	}

	public async Task AddItemMemberAsync(ItemMemberBasic itemMember) => await _itemMemberRepository.InsertAsync(itemMember);
}