using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Repositories.Friends;
using KTPS.Model.Services.Friends;

namespace KTPS.Model.Tests.Services.Friends
{
    public class FriendsService_FindFriend_Should
    {
        public class FriendsService_DeleteFriend_Should
        {
            [Fact]
            public async void CallFriendRepositoryAndFindUsers()
            {
                var someUserId = 1;
                var someInput = "input";

                IEnumerable<UserMinimal> friendsList = new List<UserMinimal>()
                {
                    new UserMinimal() { ID = 1, Username = "input1" },
                    new UserMinimal() { ID = 2, Username = "input2" },
                };

                var friendsRepository = new Mock<IFriendsRepository>();

                friendsRepository.Setup(_ => _.FindFriendAsync(someInput)).ReturnsAsync(friendsList);

                var friendsService = new FriendsService(friendsRepository.Object);

                FindFriendRequest findFriendRequest = new FindFriendRequest
                {
                    UserID = someUserId,
                    Input = someInput
                };

                var result = await friendsService.FindFriendAsync(findFriendRequest);

                var expectedResult = new ServerResult<IEnumerable<UserMinimal>>() { Success = true, Data = friendsList.Where(x => x.ID != someUserId) };

                result.Should().BeEquivalentTo(expectedResult);
            }

            [Fact]
            public async void ReturnErrorOnException()
            {
                var someUserId = 1;
                var someInput = "input";

                var friendsRepository = new Mock<IFriendsRepository>();

                friendsRepository.Setup(_ => _.FindFriendAsync(someInput)).Throws(new Exception());

                var friendsService = new FriendsService(friendsRepository.Object);

                FindFriendRequest findFriendRequest = new FindFriendRequest
                {
                    UserID = someUserId,
                    Input = someInput
                };

                var result = await friendsService.FindFriendAsync(findFriendRequest);

                var expectedResult = new ServerResult<IEnumerable<UserMinimal>>() { Success = false, Message = "Technical error!" };

                result.Should().BeEquivalentTo(expectedResult);
            }
        }
    }
}
