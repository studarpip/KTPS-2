namespace KTPS.Model.Entities.Items;

public class ItemMemberBasic
{
    public int Id { get; set; }
    public int ItemId { get; set; }
    public int? GuestId { get; set; }
    public int? UserId { get; set; }
}