using KTPS.Model.Entities.Groups;
using KTPS.Model.Entities.Guests;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities;
using KTPS.Model.Repositories.GroupMembers;
using KTPS.Model.Repositories.Groups;
using KTPS.Model.Repositories.Guests;
using KTPS.Model.Services.Groups;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using System.ComponentModel.DataAnnotations;

namespace KTPS.Model.Tests.Services.Groups
{
    [TestClass]
    public class GroupsServiceTest
    {
        private Mock<IGroupsRepository> _groupsRepositoryMock;
        private Mock<IGroupMembersRepository> _groupMembersRepositoryMock;
        private Mock<IGuestsRepository> _guestsRepositoryMock;
        private IGroupsService _groupsService;

        [TestInitialize]
        public void Setup()
        {
            _groupsRepositoryMock = new Mock<IGroupsRepository>();
            _groupMembersRepositoryMock = new Mock<IGroupMembersRepository>();
            _guestsRepositoryMock = new Mock<IGuestsRepository>();

            _groupsService = new GroupsService(
                _groupsRepositoryMock.Object,
                _groupMembersRepositoryMock.Object,
                _guestsRepositoryMock.Object
            );
        }

        [TestMethod]
        public async Task NewGroupAsync_ShouldCreateNewGroupAndReturnId()
        {
            var request = new NewGroupRequest { Name = "Test Group", UserID = 1 };
            var newGroupId = 10;

            _groupsRepositoryMock.Setup(x => x.InsertAsync(It.IsAny<GroupBasic>()))
                .ReturnsAsync(newGroupId);

            var result = await _groupsService.NewGroupAsync(request);

            Assert.IsTrue(result.Success);
            Assert.AreEqual(newGroupId, result.Data);
            _groupMembersRepositoryMock.Verify(x => x.AddGroupMemberAsync(request.UserID, newGroupId), Times.Once);
        }

        [TestMethod]
        public async Task EditGroupAsync_UserNotOwner_ShouldReturnError()
        {
            var request = new EditGroupRequest { ID = 1, Name = "New Name", UserID = 2 };
            var group = new GroupBasic { ID = 1, OwnerUserID = 1, Name = "Old Name" };

            _groupsRepositoryMock.Setup(x => x.GetGroupAsync(request.ID))
                .ReturnsAsync(group);

            var result = await _groupsService.EditGroupAsync(request);
            Assert.AreEqual("Only the owner can edit the group name!", result.Message);
        }

        [TestMethod]
        public async Task EditGroupAsync_UserIsOwner_ShouldUpdateGroup()
        {
            var request = new EditGroupRequest { ID = 1, Name = "New Name", UserID = 1 };
            var group = new GroupBasic { ID = 1, OwnerUserID = 1, Name = "Old Name" };

            _groupsRepositoryMock.Setup(x => x.GetGroupAsync(request.ID))
                .ReturnsAsync(group);

            var result = await _groupsService.EditGroupAsync(request);

            Assert.IsTrue(result.Success);
            _groupsRepositoryMock.Verify(x => x.UpdateAsync(It.Is<GroupBasic>(g => g.Name == request.Name)), Times.Once);
        }

        [TestMethod]
        public async Task DeleteGroupAsync_UserNotOwner_ShouldReturnError()
        {
            var request = new DeleteGroupRequest { ID = 1, UserID = 2 };
            var group = new GroupBasic { ID = 1, OwnerUserID = 1 };

            _groupsRepositoryMock.Setup(x => x.GetGroupAsync(request.ID))
                .ReturnsAsync(group);

            var result = await _groupsService.DeleteGroupAsync(request);
            Assert.AreEqual("Only the owner can delete the group", result.Message);
        }

        [TestMethod]
        public async Task DeleteGroupAsync_UserIsOwner_ShouldDeleteGroupAndMembers()
        {
            var request = new DeleteGroupRequest { ID = 1, UserID = 1 };
            var group = new GroupBasic { ID = 1, OwnerUserID = 1 };

            var members = new List<GroupMember>
            {
                new GroupMember { GroupID = group.ID, UserID = 2 },
                new GroupMember { GroupID = group.ID, UserID = 3 }
            };

            _groupsRepositoryMock.Setup(x => x.GetGroupAsync(request.ID))
                .ReturnsAsync(group);

            _groupMembersRepositoryMock.Setup(x => x.GetByGroupIDAsync(group.ID))
                .ReturnsAsync(members);

            var result = await _groupsService.DeleteGroupAsync(request);

            Assert.IsTrue(result.Success);
            _groupsRepositoryMock.Verify(x => x.DeleteAsync(request.ID), Times.Once);
            _groupMembersRepositoryMock.Verify(x => x.DeleteGroupMemberAsync(It.IsAny<int>(), group.ID), Times.Exactly(members.Count));
        }

        [TestMethod]
        public async Task GetGroupListAsync_ShouldReturnGroups()
        {
            var userId = 1;
            var groups = new List<GroupBasic>
            {
                new GroupBasic { ID = 1, Name = "Group 1" },
                new GroupBasic { ID = 2, Name = "Group 2" }
            };

            _groupsRepositoryMock.Setup(x => x.GetUserGroupsAsync(userId))
                .ReturnsAsync(groups);

            var result = await _groupsService.GetGroupListAsync(userId);

            Assert.IsTrue(result.Success);
            Assert.AreEqual(groups.Count, result.Data.Count());
        }

        [TestMethod]
        public async Task RemoveGroupMembersAsync_UserNotOwner_ShouldThrowException()
        {
            var request = new RemoveGroupMembersRequest { GroupID = 1, RequestUserID = 2 };
            var group = new GroupBasic { ID = 1, OwnerUserID = 1 };

            _groupsRepositoryMock.Setup(x => x.GetGroupAsync(request.GroupID))
                .ReturnsAsync(group);

            var result = await _groupsService.RemoveGroupMembersAsync(request);
            Assert.AreEqual("Only the owner can remove group members!", result.Message);
        }

        [TestMethod]
        public async Task RemoveGroupMembersAsync_ShouldRemoveMembers()
        {
            var request = new RemoveGroupMembersRequest
            {
                GroupID = 1,
                RequestUserID = 1,
                UserToRemoveID = 2,
                GuestToRemoveID = 3
            };
            var group = new GroupBasic { ID = 1, OwnerUserID = 1 };

            _groupsRepositoryMock.Setup(x => x.GetGroupAsync(request.GroupID))
                .ReturnsAsync(group);

            var result = await _groupsService.RemoveGroupMembersAsync(request);

            Assert.IsTrue(result.Success);
            _groupMembersRepositoryMock.Verify(x => x.DeleteGroupMemberAsync((int)request.UserToRemoveID, group.ID), Times.Once);
            _groupMembersRepositoryMock.Verify(x => x.DeleteGroupGuestAsync((int)request.GuestToRemoveID, group.ID), Times.Once);
        }

        [TestMethod]
        public async Task AddGuestAsync_ShouldAddGuestAndReturnId()
        {
            var request = new AddGuestRequest { GroupID = 1, Name = "Guest 1" };
            var guestId = 10;

            _groupsRepositoryMock.Setup(x => x.GetGroupAsync(1)).ReturnsAsync(new GroupBasic()
            {
                ID = 1,
                OwnerUserID = guestId,
                Name = Guid.NewGuid().ToString(),
            });

            _guestsRepositoryMock.Setup(x => x.InsertAsync(It.IsAny<Guest>()))
                .ReturnsAsync(guestId);

            var result = await _groupsService.AddGuestAsync(request);

            Assert.IsTrue(result.Success);
            Assert.AreEqual(guestId, result.Data);
        }

        [TestMethod]
        public async Task LeaveGroupAsync_ShouldRemoveMember()
        {
            var request = new LeaveGroupRequest { GroupID = 1, UserID = 2 };

            var result = await _groupsService.LeaveGroupAsync(request);

            Assert.IsTrue(result.Success);
            _groupMembersRepositoryMock.Verify(x => x.DeleteGroupMemberAsync(request.UserID, request.GroupID), Times.Once);
        }

        [TestMethod]
        public async Task GetGroupInfoAsync_ShouldRetrunInfo()
        {
            var groupId = 1;
            _groupsRepositoryMock.Setup(x => x.GetGroupAsync(groupId))
                                 .ReturnsAsync(new GroupBasic() { ID = groupId, OwnerUserID = 2, Name = "Test" });

            var result = await _groupsService.GetGroupInfoAsync(groupId);
            Assert.IsTrue(result.Success);
            Assert.AreEqual(groupId, result.Data.ID);
            Assert.AreEqual(2, result.Data.OwnerUserID);
            Assert.AreEqual("Test", result.Data.Name);
        }

        [TestMethod]
        public async Task GetMemberListAsync_ValidGroupID_ReturnsCorrectData()
        {
            // Arrange
            var groupID = 1;
            var group = new GroupBasic { ID = groupID, OwnerUserID = 100 };
            var members = new List<GroupMember>
        {
            new GroupMember { UserID = 101 },
            new GroupMember { UserID = 102 },
            new GroupMember { UserID = 100 } // Owner
        };
            var guests = new List<Guest>
        {
            new Guest { Id = 201, Name = "Guest1" },
            new Guest { Id = 202, Name = "Guest2" }
        };

            _groupsRepositoryMock.Setup(repo => repo.GetGroupAsync(groupID))
                .ReturnsAsync(group);
            _groupMembersRepositoryMock.Setup(repo => repo.GetByGroupIDAsync(groupID))
                .ReturnsAsync(members);
            _guestsRepositoryMock.Setup(repo => repo.GetByGroupID(groupID))
                .ReturnsAsync(guests);

            var result = await _groupsService.GetMemberListAsync(groupID);

            Assert.IsNotNull(result);
            Assert.IsTrue(result.Success);
            Assert.AreEqual(group.OwnerUserID, result.Data.OwnerUserID);
            Assert.AreEqual(2, result.Data.Members.Count);
            Assert.AreEqual(2, result.Data.Guests.Count);
            Assert.IsTrue(result.Data.Guests.Any(g => g.Name == "Guest1"));
        }

        [TestMethod]
        public async Task GetMemberListAsync_EmptyGroupMembers_ReturnsEmptyMembersList()
        {
            var groupID = 2;
            var group = new GroupBasic { ID = groupID, OwnerUserID = 100 };
            var members = new List<GroupMember>();
            var guests = new List<Guest>
        {
            new Guest { Id = 301, Name = "Guest1" }
        };

            _groupsRepositoryMock.Setup(repo => repo.GetGroupAsync(groupID))
                .ReturnsAsync(group);
            _groupMembersRepositoryMock.Setup(repo => repo.GetByGroupIDAsync(groupID))
                .ReturnsAsync(members);
            _guestsRepositoryMock.Setup(repo => repo.GetByGroupID(groupID))
                .ReturnsAsync(guests);

            var result = await _groupsService.GetMemberListAsync(groupID);

            Assert.IsNotNull(result);
            Assert.IsTrue(result.Success);
            Assert.AreEqual(0, result.Data.Members.Count); 
            Assert.AreEqual(1, result.Data.Guests.Count);
        }
    }
}
