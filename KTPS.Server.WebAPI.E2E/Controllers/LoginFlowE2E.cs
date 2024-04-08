using FluentAssertions;
using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Helpers;
using Newtonsoft.Json;
using System.Text;

namespace KTPS.Server.WebAPI.E2E.Controllers;

public class LoginFlowE2E : E2E
{
    public async Task Test()
    {
        var testRepository = new TestDbRepository();
        await testRepository.ResetDb();

        var insertTestUserQuery = $"INSERT INTO users (`Username`, `Password`, `Email`) VALUES ('test_username', '{"test_password".Hash()}', 'test_email');";
        await testRepository.ExecuteAsync(insertTestUserQuery);

        var loginRequest = new LoginRequest { Username = "test_username", Password = "test_password" };
        var loginRequestContent = new StringContent(JsonConvert.SerializeObject(loginRequest), Encoding.UTF8, "application/json");

        var http = new HttpClient();
        var res = await http.PostAsync("https://localhost:7000" + "/login/login", loginRequestContent);

        var resContent = await res.Content.ReadAsStringAsync();
        var deserializedContent = JsonConvert.DeserializeObject<ServerResult<int>>(resContent);

        deserializedContent?.Data.Should().Be(1);

        var getUserQuery = "SELECT * FROM users WHERE ID = 1";
        var user = await testRepository.QueryAsync<UserBasic>(getUserQuery);

        user.Should().NotBeNull();

        user.Username.Should().Be("test_username");
        user.Password.Should().Be("test_password".Hash());
        user.Email.Should().Be("test_email");
    }
}