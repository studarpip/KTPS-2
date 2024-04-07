using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Services.Registration;
using KTPS.Model.Services.User;

namespace KTPS.Model.Tests.Services.Registration;

public class RegistrationService_StartRegistration_Should
{

    [Fact]
    public async void ReturnErrorIfUserExists()
    {
        var userService = new Mock<IUserService>();
        userService.Setup(_ => _.UsernameExistsAsync("someUsername")).ReturnsAsync(true);

        var registrationService = new RegistrationService(userService.Object);

        var request = new RegistrationStartRequest() { Username = "someUsername", Email = "someEmail", Password = "somePassword" };
        var expected = new ServerResult<int>() { Success = false, Message = "Username already exists!" };

        var result = await registrationService.StartRegistrationAsync(request);

        Assert.Equivalent(expected, result);
    }
}