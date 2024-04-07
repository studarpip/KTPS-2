using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities;
using KTPS.Model.Repositories.Friends;
using KTPS.Model.Services.Friends;

namespace KTPS.Model.Tests.Services.Friends
{
    public class FriendsService_AddFriend_Should
    {
        [Fact]
        public async void CallFriendRepositoryAndAddFriend()
        {
            var someUserId = 1;//Setting up variables
            var someOtherUserId = 2;

            var friendsRepository = new Mock<IFriendsRepository>();

            friendsRepository.Setup(_ => _.InsertAsync(someUserId, someOtherUserId));//Mocking repository method

            var friendsService = new FriendsService(friendsRepository.Object);

            await friendsService.AddFriendAsync(someUserId, someOtherUserId);//Calling service

            friendsRepository.Verify(_ => _.InsertAsync(someUserId, someOtherUserId), Times.Once);//Checking if method was called once with these variables and once with them reversed
            friendsRepository.Verify(_ => _.InsertAsync(someOtherUserId, someUserId), Times.Once);
        }
    }
}
