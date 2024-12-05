using KTPS.Model.Entities;
using KTPS.Model.Entities.Calculation;
using KTPS.Model.Entities.Items;
using KTPS.Model.Entities.Responses;
using KTPS.Model.Repositories.GroupMembers;
using KTPS.Model.Repositories.Guests;
using KTPS.Model.Services.Items;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Calculation;

public class CalculationService : ServiceBase, ICalculationService
{
    private readonly IItemsService _itemsService;
    private readonly IItemMembersService _itemMembersService;
    private readonly IGroupMembersRepository _groupMembersRepository;
    private readonly IGuestsRepository _guestsRepository;

    public CalculationService(
        IItemsService itemsService,
        IItemMembersService itemMembersService,
        IGroupMembersRepository groupMembersRepository,
        IGuestsRepository guestsRepository
        )
    {
        _itemsService = itemsService;
        _itemMembersService = itemMembersService;
        _groupMembersRepository = groupMembersRepository;
        _guestsRepository = guestsRepository;
    }

    public async Task<ServerResult<CalculationResponse>> CalculateGroupExpensesAsync(int groupId)
        => await ProcessRequestAsync<CalculationResponse>(async () =>
        {
            var items = await _itemsService.GetGroupItemsAsync(groupId);
            if (items?.Any() != true)
                throw new ServiceException("Group has no items");

            var guests = await _guestsRepository.GetByGroupID(groupId);
            var users = await _groupMembersRepository.GetByGroupIDAsync(groupId);

            var guestCalculations = guests.Select(x => new GuestCalculation(x)).ToList();
            var userCalculations = users.Select(x => new UserCalculation(x)).ToList();
            
            foreach (var item in items)
            {
                var itemMembers = await _itemMembersService.GetMembersAsync(item.Id);
                if (itemMembers?.Any() != true)
                    continue;

                UpdateCalculations(itemMembers, guestCalculations, (x, calc) => x.GuestId == calc.GuestId, item);
                UpdateCalculations(itemMembers, userCalculations, (x, calc) => x.UserId == calc.UserId, item);
            }

            var result = new CalculationResponse(guestCalculations, userCalculations, items.Select(x => x.Quantity).Sum(), items.Select(x => x.Price).Sum());

            return new(result);
        });

    private static decimal CaclulateTotal(IEnumerable<ItemMemberBasic> items, Func<ItemMemberBasic, bool> predicate, ItemBasic item)
    {
        if (items.Any(predicate))
            return 0;

        return item.CalculateTotal(items.Count());
    }

    private static void UpdateCalculations<T>(IEnumerable<ItemMemberBasic> itemMembers, IEnumerable<T> calculations, Func<ItemMemberBasic, T, bool> matchCondition, ItemBasic item)
    where T : AmountCalculation
    {
        foreach (var calculation in calculations)
        {
            calculation.Amount += CaclulateTotal(itemMembers, member => matchCondition(member, calculation), item);
        }
    }

}