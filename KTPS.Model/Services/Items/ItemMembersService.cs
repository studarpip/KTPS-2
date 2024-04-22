using KTPS.Model.Entities.Items;
using KTPS.Model.Repositories.Items;
using System.Collections.Generic;
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

	public async Task<IEnumerable<ItemMemberBasic>> GetMembersAsync(int itemId) => await _itemMemberRepository.GetListAsync(itemId);

	public async Task RemoveGuestAsync(int guestId) => await _itemMemberRepository.DeleteGuestAsync(guestId);

	public async Task RemoveUserAsync(int userId) => await _itemMemberRepository.DeleteUserAsync(userId);

	public async Task AddItemMemberAsync(ItemMemberBasic itemMember) => await _itemMemberRepository.InsertAsync(itemMember);
}