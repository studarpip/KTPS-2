using KTPS.Model.Entities.Calculation;
using System.Collections.Generic;

namespace KTPS.Model.Entities.Responses;

public class CalculationResponse
{
    public List<GuestCalculation> GuestCalculations { get; set; }
    public List<UserCalculation> UserCalculations { get; set; }
    public int TotalItems { get; set; }
    public decimal TotalAmount { get; set; }
}