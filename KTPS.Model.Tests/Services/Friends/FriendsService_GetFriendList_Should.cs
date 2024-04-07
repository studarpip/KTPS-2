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
            var someUserId = 1;

            var friendsRepository = new Mock<IFriendsRepository>();

            IEnumerable<UserMinimal> friendsList = new List<UserMinimal>()
            {
                new UserMinimal() {ID = 1, Username = "name1"},
                new UserMinimal() {ID = 2, Username = "name2"}
            };

            friendsRepository.Setup(_ => _.GetFriendListAsync(someUserId)).ReturnsAsync(friendsList);

            var friendsService = new FriendsService();

            var result = await friendsService.GetFriendListAsync(someUserId);

            var expectedResult = new ServerResult<IEnumerable<UserMinimal>>() { Success = true, Data = friendsList };

            result.Should().BeEquivalentTo(expectedResult);
        }
    }
}
