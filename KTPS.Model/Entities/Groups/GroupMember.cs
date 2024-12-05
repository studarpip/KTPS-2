namespace KTPS.Model.Entities.Groups;

public class GroupMember
{
    public int Id { get; set; }
    public int GroupID { get; set; }
    public int UserID { get; set; }
    public string Username { get; set; }
}