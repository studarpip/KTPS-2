using KTPS.Model.Entities;
using KTPS.Model.Entities.User;
using KTPS.Model.Repositories.Friends;
using KTPS.Model.Repositories.Registration;
using KTPS.Model.Services.Friends;
using System.Collections.Generic;

namespace KTPS.Model.Tests.Services.Friends
{
    public class FriendsService_GetFriendList_Should
    {
        [Fact]
        public async void CallFriendRepositoryAndReturnFriends()
        {
            var someUserId = 1;//Setting up variables

            var friendsRepository = new Mock<IFriendsRepository>();

            IEnumerable<UserMinimal> friendsList = new List<UserMinimal>()
            {
                new UserMinimal() {ID = 1, Username = "name1"},
                new UserMinimal() {ID = 2, Username = "name2"}
            };

            friendsRepository.Setup(_ => _.GetFriendListAsync(someUserId)).ReturnsAsync(friendsList);//Mocking repository to return friend list we set up

            var friendsService = new FriendsService(friendsRepository.Object);

            var result = await friendsService.GetFriendListAsync(someUserId);//Calling service

            var expectedResult = new ServerResult<IEnumerable<UserMinimal>>() { Success = true, Data = friendsList };//Setting up expected result

            result.Should().BeEquivalentTo(expectedResult);//Checking if result is equal to expected result
        }

        [Fact]
        public async void ReturnErrorOnException()
        {
            var someUserId = 1;

            var friendsRepository = new Mock<IFriendsRepository>();

            friendsRepository.Setup(_ => _.GetFriendListAsync(someUserId)).Throws(new Exception());

            var friendsService = new FriendsService(friendsRepository.Object);

            var result = await friendsService.GetFriendListAsync(someUserId);

            var expectedResult = new ServerResult<IEnumerable<UserMinimal>>() { Success = false, Message = "Technical error!" };

            result.Should().BeEquivalentTo(expectedResult);
        }
    }
}
