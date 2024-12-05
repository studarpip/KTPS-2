using KTPS.Model.Entities.Requests;

namespace KTPS.Model.Entities.Groups;

public class GroupBasic
{
    public int ID { get; set; }
    public string Name { get; set; }
    public int OwnerUserID { get; set; }

    public bool IsOwner(int userId) => OwnerUserID == userId;

    public GroupBasic() { }

    public GroupBasic(NewGroupRequest request)
    {
        Name = request.Name;
        OwnerUserID = request.UserID;
    }
}