using System.Collections.Generic;

namespace KTPS.Model.Entities.Requests;

public class CreateItemRequest
{
    public int GroupId { get; set; }
    public string Name { get; set; }
    public int Quantity { get; set; }
    public decimal Price { get; set; }
    public List<int> GuestIds { get; set; }
    public List<int> UserIds { get; set; }
}