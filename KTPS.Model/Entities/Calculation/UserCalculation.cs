using KTPS.Model.Entities.Groups;

namespace KTPS.Model.Entities.Calculation;

public class UserCalculation : AmountCalculation
{
    public int UserId { get; set; }

    public UserCalculation(GroupMember user)
    {
        UserId = user.Id;
        Amount = 0m;
        Username = user.Username;
    }
}