using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Repositories.Friends;
using KTPS.Model.Services.Friends;

namespace KTPS.Model.Tests.Services.Friends
{
    public class FriendsService_DeleteFriend_Should
    {
        [Fact]
        public async void CallFriendRepositoryAndDeleteFriend()
        {
            var someUserId = 1;
            var someFriendId = 2;

            var friendsRepository = new Mock<IFriendsRepository>();

            friendsRepository.Setup(_ => _.DeleteFriendAsync(someUserId, someFriendId));

            var friendsService = new FriendsService(friendsRepository.Object);

            DeleteFriendRequest deleteFriendRequest = new DeleteFriendRequest
            {
                UserID = someUserId,
                FriendID = someFriendId
            };

            var result = await friendsService.DeleteFriendAsync(deleteFriendRequest);

            var expectedResult = new ServerResult() { Success = true };

            result.Should().BeEquivalentTo(expectedResult);

            friendsRepository.Verify(_ => _.DeleteFriendAsync(someUserId, someFriendId), Times.Once);
        }
    }
}
