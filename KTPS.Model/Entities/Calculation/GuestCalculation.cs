using KTPS.Model.Entities.Guests;

namespace KTPS.Model.Entities.Calculation;

public class GuestCalculation : AmountCalculation
{
    public int GuestId { get; set; }

    public GuestCalculation(Guest guest)
    {
        GuestId = guest.Id;
        Username = guest.Name;
        Amount = 0m;
    }
}