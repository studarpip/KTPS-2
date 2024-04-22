using KTPS.Model.Entities;
using KTPS.Model.Entities.Items;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.Responses;
using KTPS.Model.Services.Calculation;
using KTPS.Model.Services.Items;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KTPS.Server.WebAPI.Controllers;

[Controller, Route("/shopping_list")]
public class ShoppingListController
{
	private readonly IItemsService _itemsService;
	private readonly ICalculationService _calculationService;

	public ShoppingListController(
		IItemsService itemsService,
		ICalculationService calculationService
		)
	{
		_itemsService= itemsService;
		_calculationService = calculationService;
	}

	[HttpPost("/create_item")]
	public async Task<ServerResult> CreateItemAsync(CreateItemRequest request) => await _itemsService.CreateItemAsync(request);

    [HttpPost("/edit_item")]
    public async Task<ServerResult> EditItemAsync(EditItemRequest request) => await _itemsService.EditItemAsync(request);

	[HttpGet("/{groupId}/get_items")]
	public async Task<ServerResult<IEnumerable<ItemBasic>>> GetItemsAsync(int groupId) => await _itemsService.GetGroupItemListAsync(groupId);

	[HttpGet("/{itemId}/delete_item")]
	public async Task<ServerResult> DeleteItemAsync(int itemId) => await _itemsService.DeleteItemAsync(itemId);

	[HttpGet("/{groupId}/calculation")]
	public async Task<ServerResult<CalculationResponse>> CalculateAsync(int groupId) => await _calculationService.CalculateGroupExpensesAsync(groupId);
}