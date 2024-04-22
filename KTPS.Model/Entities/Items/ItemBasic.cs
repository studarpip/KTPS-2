namespace KTPS.Model.Entities.Items;

public class ItemBasic
{
    public int Id { get; set; }
    public int GroupId { get; set; }
    public string Name { get; set; }
    public int Quantity { get; set; }
    public decimal Price { get; set; }
}