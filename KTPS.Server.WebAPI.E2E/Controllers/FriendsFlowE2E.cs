using FluentAssertions;
using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using Newtonsoft.Json;
using System.Text;

namespace KTPS.Server.WebAPI.E2E;

public class FriendsFlowE2E : LoginTestContext, E2E
{
    public async Task Test()
    {
        await testDbRepository.ResetDb();

        //Insert 2 users and make them friends

        var sqlInsert = @"
            INSERT INTO users (`Username`, `Password`, `Email`)
            VALUES ('username1', 'password1', 'email1');";
        await testDbRepository.ExecuteAsync(sqlInsert);

        sqlInsert = @"
            INSERT INTO users (`Username`, `Password`, `Email`)
            VALUES ('username2', 'password2', 'email2');";
        await testDbRepository.ExecuteAsync(sqlInsert);

        sqlInsert = @"
            INSERT INTO friends (`UserId`, `FriendID`)
            VALUES (1, 2);";
        await testDbRepository.ExecuteAsync(sqlInsert);

        sqlInsert = @"
            INSERT INTO friends (`UserId`, `FriendID`)
            VALUES (2, 1);";
        await testDbRepository.ExecuteAsync(sqlInsert);

        //Check if friends/list returns correct list of friends for user 1

        var getFriendsList = await http.GetAsync(url + friendListSubUrl + 1);
        var getFriendsListResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await getFriendsList.Content.ReadAsStringAsync());

        getFriendsListResult?.Success.Should().BeTrue();
        getFriendsListResult?.Data.Should().NotBeNull();
        getFriendsListResult?.Data.Count().Should().Be(1);
        getFriendsListResult?.Data.First().ID.Should().Be(2);

        //Delete friend for user 1

        var deleteFriendRequest = new DeleteFriendRequest() { UserID = 1, FriendID = 2 };
        var serializedDeleteFriendRequest = JsonConvert.SerializeObject(deleteFriendRequest);
        var deleteRequestContent = new StringContent(serializedDeleteFriendRequest, Encoding.UTF8, "application/json");
        var deleteFriend = await http.PostAsync(url + friendDeleteSubUrl, deleteRequestContent);
        var deleteFriendResult = JsonConvert.DeserializeObject<ServerResult>(await deleteFriend.Content.ReadAsStringAsync());

        getFriendsList = await http.GetAsync(url + friendListSubUrl + 1);
        getFriendsListResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await getFriendsList.Content.ReadAsStringAsync());

        getFriendsListResult?.Success.Should().BeTrue();
        getFriendsListResult?.Data.Should().NotBeNull();
        getFriendsListResult?.Data.Count().Should().Be(0);
        deleteFriendResult?.Success.Should().BeTrue();

        //Find users by user 1

        var findFriendRequest = new FindFriendRequest() { UserID = 1, Input = "name" };
        var serializedFindFriendRequest = JsonConvert.SerializeObject(findFriendRequest);
        var findFriendRequestContent = new StringContent(serializedFindFriendRequest, Encoding.UTF8, "application/json");
        var findFriend = await http.PostAsync(url + friendFindSubUrl, findFriendRequestContent);
        var findFriendResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await findFriend.Content.ReadAsStringAsync());

        findFriendResult?.Success.Should().BeTrue();
        findFriendResult?.Data.Should().NotBeNull();
        findFriendResult?.Data.Count().Should().Be(1);
        findFriendResult?.Data.First().ID.Should().Be(2);
    }
}

public class LoginTestContext
{
    public TestDbRepository testDbRepository = new TestDbRepository();
    public HttpClient http = new HttpClient();
    public string url = "https://localhost:7000";
    public string friendListSubUrl = "/friends/list/";
    public string friendDeleteSubUrl = "/friends/delete";
    public string friendFindSubUrl = "/friends/find";
}