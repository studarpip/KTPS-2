using KTPS.Model.Entities;
using KTPS.Model.Entities.Registration;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Helpers;
using KTPS.Model.Repositories.Registration;
using KTPS.Model.Services.Registration;
using KTPS.Model.Services.User;

namespace KTPS.Model.Tests.Services.Registration;

public class RegistrationService_AuthRegistration_Should
{

    [Fact]
    public async void ReturnErrorIfRegistrationDoesNotExist()
    {
        var someUsername = "someUsername";
        var someEmail = "someEmail";
        var somePassword = "somePassword";
        var someId = 1;

        var userService = new Mock<IUserService>();

        var registrationRepo = new Mock<IRegistrationRepository>();
        registrationRepo.Setup(_ => _.GetByID(someId)).ReturnsAsync(null as RegistrationBasic);

        var registrationService = new RegistrationService(userService.Object, registrationRepo.Object);

        var request = new RegistrationAuthRequest() { RegistrationID = someId, AuthCode = "not important" };
        var expected = new ServerResult<int>() { Success = false, Message = "Registration does not exist!" };

        var result = await registrationService.AuthRegistrationAsync(request);

        result.Should().BeEquivalentTo(expected);
    }


}