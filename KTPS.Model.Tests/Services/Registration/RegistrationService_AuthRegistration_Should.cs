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

    [Fact]
    public async void ReturnErrorIfAuthCodesDoNotMatch()
    {
        var someId = 1;
        var someAuthCode = "someAuthCode";

        var userService = new Mock<IUserService>();

        var registrationRepo = new Mock<IRegistrationRepository>();
        var someRegistrationBasic = new RegistrationBasic() { ID = someId, AuthCode = someAuthCode };
        registrationRepo.Setup(_ => _.GetByID(someId)).ReturnsAsync(someRegistrationBasic);

        var registrationService = new RegistrationService(userService.Object, registrationRepo.Object);

        var request = new RegistrationAuthRequest() { RegistrationID = someId, AuthCode = "mismatchingCode" };
        var expected = new ServerResult<int>() { Success = false, Message = "Authentication code is incorrect!" };

        var result = await registrationService.AuthRegistrationAsync(request);

        result.Should().BeEquivalentTo(expected);
    }


}