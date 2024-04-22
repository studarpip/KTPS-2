using FluentAssertions;
using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using Newtonsoft.Json;
using System.Text;

namespace KTPS.Server.WebAPI.E2E;

public class GroupsFlowE2E : GroupsFlowContext, E2E
{
    public async Task Test()
    {
        await CreateNewTest();
        await EditTest();
        await DeleteTest();
    }

    public async Task CreateNewTest()
    {

        await testDbRepository.ResetDb();

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

        var getGroupList = await http.GetAsync(url + groupListSubUrl + 1);
        var getGroupResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await getGroupList.Content.ReadAsStringAsync());

        getGroupResult?.Success.Should().BeTrue();
        getGroupResult?.Data.Should().NotBeNull();

        var createGroupRequest = new DeleteFriendRequest() { UserID = 1, FriendID = 2 };
        var serializedCreateGroupRequest = JsonConvert.SerializeObject(createGroupRequest);
        var createGroupContent = new StringContent(serializedCreateGroupRequest, Encoding.UTF8, "application/json");
        var createGroup = await http.PostAsync(url + friendDeleteSubUrl, createGroupContent);
        var createGroupResult = JsonConvert.DeserializeObject<ServerResult>(await createGroup.Content.ReadAsStringAsync());

        getGroupList = await http.GetAsync(url + groupListSubUrl + 1);
        getGroupResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await getGroupList.Content.ReadAsStringAsync());

        getGroupResult?.Success.Should().BeTrue();
        getGroupResult?.Data.Should().NotBeNull();
        getGroupResult?.Data.Count().Should().Be(0);
        createGroupResult?.Success.Should().BeTrue();
    }

    public async Task EditTest()
    {
        await testDbRepository.ResetDb();

        var sqlInsert = @"
            INSERT INTO users (`Username`, `Password`, `Email`)
            VALUES ('username1', 'password1', 'email1');";
        await testDbRepository.ExecuteAsync(sqlInsert);

        var createGroupInsert = @"
            INSERT INTO users (`Username`, `Password`, `Email`)
            VALUES ('username1', 'password1', 'email1');";

        var getGroupList = await http.GetAsync(url + groupListSubUrl + 1);
        var getGroupResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await getGroupList.Content.ReadAsStringAsync());

        getGroupResult?.Success.Should().BeTrue();
        getGroupResult?.Data.Should().NotBeNull();
        getGroupResult?.Data.Count().Should().Be(0);


        var editGroupRequest = new DeleteFriendRequest() { UserID = 1, FriendID = 2 };
        var serializedEditGroupRequest = JsonConvert.SerializeObject(editGroupRequest);
        var editGroupRequestContent = new StringContent(serializedEditGroupRequest, Encoding.UTF8, "application/json");
        var editGroup = await http.PostAsync(url + friendDeleteSubUrl, editGroupRequestContent);
        var editGroupResult = JsonConvert.DeserializeObject<ServerResult>(await editGroup.Content.ReadAsStringAsync());

        getGroupList = await http.GetAsync(url + groupListSubUrl + 1);
        getGroupResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await getGroupList.Content.ReadAsStringAsync());

        getGroupResult?.Success.Should().BeTrue();
        getGroupResult?.Data.Should().NotBeNull();
        getGroupResult?.Data.Count().Should().Be(0);

        editGroupResult?.Success.Should().BeTrue();
    }

    public async Task DeleteTest()
    {

        await testDbRepository.ResetDb();

        var sqlInsert = @"
            INSERT INTO users (`Username`, `Password`, `Email`)
            VALUES ('username1', 'password1', 'email1');";
        await testDbRepository.ExecuteAsync(sqlInsert);

        var sqlInsertGroup = @"
            INSERT INTO users (`Username`, `Password`, `Email`)
            VALUES ('username2', 'password2', 'email2');";

        var getGroupList = await http.GetAsync(url + groupListSubUrl + 1);
        var getGroupResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await getGroupList.Content.ReadAsStringAsync());

        getGroupResult?.Success.Should().BeTrue();
        getGroupResult?.Data.Should().NotBeNull();

        var deleteGroupRequest = new DeleteFriendRequest() { UserID = 1, FriendID = 2 };
        var serializedDeleteGroupRequest = JsonConvert.SerializeObject(deleteGroupRequest);
        var deleteGroupContent = new StringContent(serializedDeleteGroupRequest, Encoding.UTF8, "application/json");
        var deleteGroup = await http.PostAsync(url + friendDeleteSubUrl, deleteGroupContent);
        var deleteGroupResult = JsonConvert.DeserializeObject<ServerResult>(await deleteGroup.Content.ReadAsStringAsync());


        getGroupList = await http.GetAsync(url + groupListSubUrl + 1);
        getGroupResult = JsonConvert.DeserializeObject<ServerResult<IEnumerable<UserMinimal>>>(await getGroupList.Content.ReadAsStringAsync());

        deleteGroupResult?.Success.Should().BeTrue();

        getGroupResult?.Data.Count().Should().Be(0);
    }
}

public class GroupsFlowContext
{
    public TestDbRepository testDbRepository = new TestDbRepository();
    public HttpClient http = new HttpClient();
    public string url = "https://localhost:7000";
    public string groupListSubUrl = "/friends/list/";
    public string friendDeleteSubUrl = "/friends/delete";
    public string friendFindSubUrl = "/friends/find";
}