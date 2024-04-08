using FluentAssertions;
using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Helpers;
using Newtonsoft.Json;
using System.Text;

namespace KTPS.Server.WebAPI.E2E.Controllers;

public class ResetPasswordFlowE2E : E2E
{
    public async Task Test()
    {
        var testRepository = new TestDbRepository();
        await testRepository.ResetDb();

        var insertTestUserQuery = $"INSERT INTO users (`Username`, `Password`, `Email`) VALUES ('test_username', '{"test_password".Hash()}', 'test_email');";
        await testRepository.ExecuteAsync(insertTestUserQuery);

        var forgotPasswordRequest = new ForgotPasswordRequest { Email = "test_email" };
        var forgotPasswordRequestContent = new StringContent(JsonConvert.SerializeObject(forgotPasswordRequest), Encoding.UTF8, "application/json");

        var http = new HttpClient();
        var res = await http.PostAsync("https://localhost:7000" + "/login/forgotMyPassword", forgotPasswordRequestContent);

        var resContent = await res.Content.ReadAsStringAsync();
        var deserializedContent = JsonConvert.DeserializeObject<ServerResult<int>>(resContent);

        deserializedContent?.Data.Should().Be(1);

        var getCodeQuery = "SELECT RecoveryCode FROM passwordResets WHERE UserID = 1";
        var code = await testRepository.QueryAsync<string>(getCodeQuery);

        code.Should().NotBeNull();

        var resetPasswordAuthRequest = new ResetPasswordAuthRequest { UserID = 1, RecoveryCode = code };
        var resetPasswordAuthRequestContent = new StringContent(JsonConvert.SerializeObject(resetPasswordAuthRequest), Encoding.UTF8, "application/json");

        var res2 = await http.PostAsync("https://localhost:7000" + "/login/resetAuth", resetPasswordAuthRequestContent);

        var resContent2 = await res2.Content.ReadAsStringAsync();
        var deserializedContent2 = JsonConvert.DeserializeObject<ServerResult>(resContent2);

        deserializedContent2?.Success.Should().BeTrue();

        var resetPasswordRequest = new ResetPasswordRequest { UserID = 1, NewPassword = "new_password", AuthCheck = code };
        var resetPasswordRequestContent = new StringContent(JsonConvert.SerializeObject(resetPasswordRequest), Encoding.UTF8, "application/json");

        var res3 = await http.PostAsync("https://localhost:7000" + "/login/reset", resetPasswordRequestContent);

        var resContent3 = await res3.Content.ReadAsStringAsync();
        var deserializedContent3 = JsonConvert.DeserializeObject<ServerResult>(resContent3);

        deserializedContent3?.Success.Should().BeTrue();

        var getUserQuery = "SELECT * FROM users WHERE ID = 1";
        var user = await testRepository.QueryAsync<UserBasic>(getUserQuery);

        user.Should().NotBeNull();
        user.Password.Should().Be("new_password".Hash());
    }
}