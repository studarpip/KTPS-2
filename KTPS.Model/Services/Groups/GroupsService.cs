using KTPS.Model.Entities;
using KTPS.Model.Entities.Groups;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.Responses;
using KTPS.Model.Repositories.GroupMembers;
using KTPS.Model.Repositories.Groups;
using KTPS.Model.Repositories.Guests;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Groups;

public class GroupsService : ServiceBase, IGroupsService
{
    private readonly IGroupsRepository _groupsRepository;
    private readonly IGroupMembersRepository _groupMembersRepository;
    private readonly IGuestsRepository _guestsRepository;

    public GroupsService(IGroupsRepository groupsRepository, IGroupMembersRepository groupMembersRepository, IGuestsRepository guestsRepository)
    {
        _groupsRepository = groupsRepository;
        _groupMembersRepository = groupMembersRepository;
        _guestsRepository = guestsRepository;
    }

    public async Task<ServerResult<int>> NewGroupAsync(NewGroupRequest request)
        => await ProcessRequestAsync<int>(async () =>
        {
            var id = await _groupsRepository.InsertAsync(new(request));
            await _groupMembersRepository.AddGroupMemberAsync(request.UserID, id);
            return new(id);
        });

    public async Task<ServerResult> EditGroupAsync(EditGroupRequest request)
        => await ProcessRequestAsync(async () =>
        {
            var group = await GetGroupAsync(request.ID);

            if (!group.IsOwner(request.UserID))
                throw new ServiceException("Only the owner can edit the group name!");

            group.Name = request.Name;
            await _groupsRepository.UpdateAsync(group);

            return new(true);
        });

    public async Task<ServerResult> DeleteGroupAsync(DeleteGroupRequest request)
        => await ProcessRequestAsync(async () =>
        {
            var group = await GetGroupAsync(request.ID);

            if (!group.IsOwner(request.UserID))
                throw new ServiceException("Only the owner can delete the group");

            await _groupsRepository.DeleteAsync(request.ID);

            var groupMembers = (await _groupMembersRepository.GetByGroupIDAsync(group.ID)).ToList();

            foreach (var member in groupMembers)
                await _groupMembersRepository.DeleteGroupMemberAsync(member.UserID, group.ID);

            return new(true);
        });

    public async Task<ServerResult<IEnumerable<GroupBasic>>> GetGroupListAsync(int userID)
        => await ProcessRequestAsync<IEnumerable<GroupBasic>>(async () =>
        {
            var list = await _groupsRepository.GetUserGroupsAsync(userID);
            return new(list);
        });

    public async Task<ServerResult> RemoveGroupMembersAsync(RemoveGroupMembersRequest request)
        => await ProcessRequestAsync(async () =>
        {
            var group = await GetGroupAsync(request.GroupID);

            if (!group.IsOwner(request.RequestUserID))
                throw new ServiceException("Only the owner can remove group members!");

            if (request.UserToRemoveID != null && request.UserToRemoveID != group.OwnerUserID)
                await _groupMembersRepository.DeleteGroupMemberAsync((int)request.UserToRemoveID, group.ID);

            if (request.GuestToRemoveID != null)
                await _groupMembersRepository.DeleteGroupGuestAsync((int)request.GuestToRemoveID, group.ID);

            return new(true);
        });

    public async Task<ServerResult<GetGroupMembersResponse>> GetMemberListAsync(int groupID)
        => await ProcessRequestAsync<GetGroupMembersResponse>(async () =>
        {
            var group = await GetGroupAsync(groupID);
            var members = await _groupMembersRepository.GetByGroupIDAsync(groupID);
            var filteredMembers = members.Where(x => x.UserID != group.OwnerUserID);
            var guests = await _guestsRepository.GetByGroupID(groupID);

            var result = new GetGroupMembersResponse { Guests = guests.ToList(), Members = filteredMembers.ToList(), OwnerUserID = group.OwnerUserID };

            return new(result);
        });

    public async Task<ServerResult<int>> AddGuestAsync(AddGuestRequest request)
        => await ProcessRequestAsync<int>(async () =>
        {
            var group = await GetGroupAsync(request.GroupID);
            var id = await _guestsRepository.InsertAsync(new() { GroupID = request.GroupID, Name = request.Name });
            return new(id);
        });

    public async Task<ServerResult> AddGroupMemberAsync(int groupID, int userID)
        => await ProcessRequestAsync(async () =>
        {
            await _groupMembersRepository.AddGroupMemberAsync(userID, groupID);
            return new(true);
        });

    public async Task<ServerResult> LeaveGroupAsync(LeaveGroupRequest request)
        => await ProcessRequestAsync(async () =>
        {
            await _groupMembersRepository.DeleteGroupMemberAsync(request.UserID, request.GroupID);
            return new(true);
        });

    public async Task<ServerResult<GroupBasic>> GetGroupInfoAsync(int groupId)
        => await ProcessRequestAsync<GroupBasic>(async () =>
        {
            var group = await _groupsRepository.GetGroupAsync(groupId);
            return new(group);
        });

    public async Task<GroupBasic> GetGroupBasicAsync(int groupId) => await _groupsRepository.GetGroupAsync(groupId);

    private async Task<GroupBasic> GetGroupAsync(int groupId) => await _groupsRepository.GetGroupAsync(groupId) ?? throw new ServiceException("Group doesn't exist");
}