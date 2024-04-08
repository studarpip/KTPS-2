using FluentAssertions;
using Newtonsoft.Json;
using System.Text;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities;
using KTPS.Model.Entities.Registration;
using KTPS.Model.Helpers;
using KTPS.Model.Entities.User;

namespace KTPS.Server.WebAPI.E2E;

public class RegistrationFlowE2E : RegistrationTestContext, E2E
{
    public async Task Test()
    {
        await testDbRepository.ResetDb();

        var startRegisterRequest = new RegistrationStartRequest
        {
            Username = someUsername,
            Email = someEmail,
            Password = somePassword
        };

        //create registration in db
        var serializedStart = JsonConvert.SerializeObject(startRegisterRequest);
        var contentStart = new StringContent(serializedStart, Encoding.UTF8, "application/json");

        var responseStart = await http.PostAsync(url + startRegistrationSubUrl, contentStart);

        var registrationStartResult = JsonConvert.DeserializeObject<ServerResult<int>>(await responseStart.Content.ReadAsStringAsync());

        registrationStartResult.Data.Should().Be(1);

        var registrationQuery = @"SELECT * FROM registrations WHERE ID = 1";
        var createdRegistration = await testDbRepository.QueryAsync<RegistrationBasic>(registrationQuery);

        createdRegistration.ID.Should().Be(1);
        createdRegistration.UserID.Should().BeNull();
        createdRegistration.Username.Should().Be(someUsername);
        createdRegistration.Password.Should().Be(somePassword.Hash());
        createdRegistration.Email.Should().Be(someEmail);
        createdRegistration.AuthCode.Should().NotBeNullOrEmpty();

        var authCodeQuery = @$"SELECT AuthCode FROM registrations WHERE ID={registrationStartResult.Data}";
        var authCode = await testDbRepository.QueryAsync<string>(authCodeQuery);

        var authRegistrationSubUrl = "/register/auth";
        var registrationAuthRequest = new RegistrationAuthRequest()
        {
            RegistrationID = registrationStartResult.Data,
            AuthCode = authCode
        };

        //create user when authenticated
        var serializedAuth = JsonConvert.SerializeObject(registrationAuthRequest);
        var contentAuth = new StringContent(serializedAuth, Encoding.UTF8, "application/json");
        var responseAuth = await http.PostAsync(url + authRegistrationSubUrl, contentAuth);
        var registrationAuthResult = JsonConvert.DeserializeObject<ServerResult<int>>(await responseAuth.Content.ReadAsStringAsync());


        var userId = registrationAuthResult?.Data;
        userId.Should().NotBeNull();

        var getUserQuery = @$"SELECT * FROM users WHERE ID = {userId}";
        var createdUser = await testDbRepository.QueryAsync<UserBasic>(getUserQuery);
        createdUser.Should().NotBeNull();
        createdUser.Email.Should().Be(someEmail);
        createdUser.Username.Should().Be(someUsername);
        createdUser.Password.Should().Be(somePassword.Hash());
    }
}

public class RegistrationTestContext
{
    public TestDbRepository testDbRepository = new TestDbRepository();
    public HttpClient http = new HttpClient();
    public string url = "https://localhost:7000";
    public string startRegistrationSubUrl = "/register/start";

    public string someUsername = "someUsername";
    public string someEmail = "someEmail@ktpsemail.com";
    public string somePassword = "somePassword";

}