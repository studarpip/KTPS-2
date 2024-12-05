using KTPS.Model.Entities.Calculation;
using System.Collections.Generic;

namespace KTPS.Model.Entities.Responses;

public class CalculationResponse
{
    public List<GuestCalculation> GuestCalculations { get; set; }
    public List<UserCalculation> UserCalculations { get; set; }
    public int TotalItems { get; set; }
    public decimal TotalAmount { get; set; }

    public CalculationResponse(List<GuestCalculation> guests, List<UserCalculation> users, int totalItemsCount, decimal totalAmount)
    {
        GuestCalculations = guests;
        UserCalculations = users;
        TotalItems = totalItemsCount;
        TotalAmount = totalAmount;
    }
}