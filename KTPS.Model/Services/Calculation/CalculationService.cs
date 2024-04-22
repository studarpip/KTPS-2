using KTPS.Model.Entities;
using KTPS.Model.Entities.Calculation;
using KTPS.Model.Entities.Responses;
using KTPS.Model.Repositories.GroupMembers;
using KTPS.Model.Repositories.Guests;
using KTPS.Model.Services.Items;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Calculation;

public class CalculationService : ICalculationService
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
    {
        try
        {
            var items = await _itemsService.GetGroupItemsAsync(groupId);
            if (items?.Any() != true)
                return new() { Success = false, Message = "Group has no items!" };

            var guests = await _guestsRepository.GetByGroupID(groupId);
            var users = await _groupMembersRepository.GetByGroupIDAsync(groupId);

            var guestCalculations = guests.Select(x => new GuestCalculation { GuestId = x.ID, Amount = 0m, Name = x.Name });
            var userCalculations = users.Select(x => new UserCalculation { UserId = x.ID, Amount = 0m, Username = x.Username });

            foreach (var item in items)
            {
                var itemMembers = await _itemMembersService.GetMembersAsync(item.Id);
                if (itemMembers?.Any() != true)
                    continue;

                foreach (var calculation in guestCalculations)
                {
                    if (!itemMembers.Any(x => x.GuestId == calculation.GuestId))
                        continue;

                    var itemAmountForGuest = item.Quantity * item.Price / itemMembers.Count();
                    calculation.Amount += itemAmountForGuest;
                }

                foreach (var calculation in userCalculations)
                {
                    if (!itemMembers.Any(x => x.UserId == calculation.UserId))
                        continue;

                    var itemAmountForUser = item.Quantity * item.Price / itemMembers.Count();
                    calculation.Amount += itemAmountForUser;
                }
            }

            return new()
            {
                Success = true,
                Data = new()
                {
                    GuestCalculations = guestCalculations.ToList(),
                    UserCalculations = userCalculations.ToList(),
                    TotalItems = items.Select(x => x.Quantity).Sum(),
                    TotalAmount = items.Select(x => x.Price).Sum()
                }
            };
        }
        catch (Exception)
        {
            return new() { Success = false, Message = "Technical error occurred while calculating expenses!" };
        }
    }
}