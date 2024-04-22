using System.Collections.Generic;

namespace KTPS.Model.Entities.Requests;

public class EditItemRequest
{
    public int ItemId { get; set; }
    public string Name { get; set; }
    public int Quantity { get; set; }
    public decimal Price { get; set; }
    public List<int> GuestIds { get; set; }
    public List<int> UserIds { get; set; }
}