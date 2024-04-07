using KTPS.Model.Entities;
using KTPS.Model.Entities.Registration;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Helpers;
using KTPS.Model.Repositories.Registration;
using KTPS.Model.Services.Registration;
using KTPS.Model.Services.User;

namespace KTPS.Model.Tests.Services.Registration;

public class RegistrationService_StartRegistration_Should
{

    [Fact]
    public async void ReturnErrorIfUserExists()
    {
        var someUsername = "someUsername";
        var someEmail = "someEmail";
        var somePassword = "somePassword";

        var userService = new Mock<IUserService>();
        userService.Setup(_ => _.UsernameExistsAsync(someUsername)).ReturnsAsync(true);

        var registrationService = new RegistrationService(userService.Object);

        var request = new RegistrationStartRequest() { Username = someUsername, Email = someEmail, Password = somePassword };
        var expected = new ServerResult<int>() { Success = false, Message = "Username already exists!" };

        var result = await registrationService.StartRegistrationAsync(request);

        Assert.Equivalent(expected, result);
    }

    [Fact]
    public async void ReturnErrorIfEmailExists()
    {
        var someUsername = "someUsername";
        var someEmail = "someEmail";
        var somePassword = "somePassword";

        var userService = new Mock<IUserService>();
        userService.Setup(_ => _.EmailExistsAsync(someEmail)).ReturnsAsync(true);

        var registrationService = new RegistrationService(userService.Object);

        var request = new RegistrationStartRequest() { Username = someUsername, Email = someEmail, Password = somePassword };
        var expected = new ServerResult<int>() { Success = false, Message = "Email already exists!" };

        var result = await registrationService.StartRegistrationAsync(request);

        Assert.Equivalent(expected, result);
    }

    [Fact]
    public async void CreateRegistrationBasicAndReturnRegistrationId()
    {
        var someUsername = "someUsername";
        var someEmail = "someEmail";
        var somePassword = "somePassword";
        var someRegistrationId = 0;

        var userService = new Mock<IUserService>();
        userService.Setup(_ => _.EmailExistsAsync(someEmail)).ReturnsAsync(false);
        userService.Setup(_ => _.UsernameExistsAsync(someUsername)).ReturnsAsync(false);

        var registrationRepo = new Mock<IRegistrationRepository>();
        var expectedRegistrationBasic = new RegistrationBasic()
        {
            UserID = null,
            Username = someUsername,
            Email = someEmail,
            Password = somePassword.Hash(),
            AuthCode = "asdfsadf"
        };
        registrationRepo.Setup(_ => _.InsertAsync(expectedRegistrationBasic)).ReturnsAsync(someRegistrationId);

        var registrationService = new RegistrationService(userService.Object);

        var request = new RegistrationStartRequest() { Username = someUsername, Email = someEmail, Password = somePassword };
        var expected = new ServerResult<int>() { Success = true, Data = someRegistrationId };

        var result = await registrationService.StartRegistrationAsync(request);

        Assert.Equivalent(expected, result);
    }

}