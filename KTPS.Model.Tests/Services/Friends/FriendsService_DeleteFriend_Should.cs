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
            var someUserId = 1;//Setting up variables
            var someFriendId = 2;

            var friendsRepository = new Mock<IFriendsRepository>();

            friendsRepository.Setup(_ => _.DeleteFriendAsync(someUserId, someFriendId));//Mocking repository method

            var friendsService = new FriendsService(friendsRepository.Object);

            DeleteFriendRequest deleteFriendRequest = new DeleteFriendRequest
            {
                UserID = someUserId,
                FriendID = someFriendId
            };

            var result = await friendsService.DeleteFriendAsync(deleteFriendRequest);//Calling service

            var expectedResult = new ServerResult() { Success = true };//Expected result set up

            result.Should().BeEquivalentTo(expectedResult);//Checking if result and expected result is equal

            friendsRepository.Verify(_ => _.DeleteFriendAsync(someUserId, someFriendId), Times.Once);//Checking if method was called once with these variables and once reversed
            friendsRepository.Verify(_ => _.DeleteFriendAsync(someFriendId, someUserId), Times.Once);
        }
    }
}
