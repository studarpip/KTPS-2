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
        var someId = 1;//Setting up variables

        var userService = new Mock<IUserService>();

        var registrationRepository = new Mock<IRegistrationRepository>();
        registrationRepository.Setup(_ => _.GetByID(someId)).ReturnsAsync(null as RegistrationBasic);//Mocking repository to return null registration

        var registrationService = new RegistrationService(userService.Object, registrationRepository.Object);

        var request = new RegistrationAuthRequest() { RegistrationID = someId, AuthCode = "not important" };//Setting up a request for service
        var expected = new ServerResult<int>() { Success = false, Message = "Registration does not exist!" };//Setting up an expected result

        var result = await registrationService.AuthRegistrationAsync(request);//Calling service

        result.Should().BeEquivalentTo(expected);//Checking if result is equal to expected result
    }

    [Fact]
    public async void ReturnErrorIfAuthCodesDoNotMatch()
    {
        var someId = 1;//Setting up variables
        var someAuthCode = "someAuthCode";

        var userService = new Mock<IUserService>();

        var registrationRepository = new Mock<IRegistrationRepository>();
        var someRegistrationBasic = new RegistrationBasic() { ID = someId, AuthCode = someAuthCode };//Registration that we want mocked repository to return
        registrationRepository.Setup(_ => _.GetByID(someId)).ReturnsAsync(someRegistrationBasic);//Mocking registration repository to return some registration that we set up

        var registrationService = new RegistrationService(userService.Object, registrationRepository.Object);

        var request = new RegistrationAuthRequest() { RegistrationID = someId, AuthCode = "mismatchingCode" };//Setting up a request
        var expected = new ServerResult<int>() { Success = false, Message = "Authentication code is incorrect!" };//Setting up an expected result

        var result = await registrationService.AuthRegistrationAsync(request);//Calling service

        result.Should().BeEquivalentTo(expected);//Checking if result is equal to expected result
    }

    [Fact]
    public async void CreateUserAndUpdateRegistration()
    {
        var someId = 1;//Setting up variables
        var someAuthCode = "someAuthCode";
        var someUserId = 3;


        var registrationRepository = new Mock<IRegistrationRepository>();
        var someRegistrationBasic = new RegistrationBasic() { ID = someId, AuthCode = someAuthCode };//Registration that we want mocked repository to return
        registrationRepository.Setup(_ => _.GetByID(someId)).ReturnsAsync(someRegistrationBasic);//Mocking repository to return some registration

        var userService = new Mock<IUserService>();
        userService.Setup(_ => _.CreateUserAsync(It.IsAny<RegistrationBasic>())).ReturnsAsync(someUserId);//Mocking user service to return user id (someUserId)

        var registrationService = new RegistrationService(userService.Object, registrationRepository.Object);

        var request = new RegistrationAuthRequest() { RegistrationID = someId, AuthCode = someAuthCode };//Setting up a request
        var expected = new ServerResult<int>() { Success = true, Data = someUserId };//Setting up an expected result

        var result = await registrationService.AuthRegistrationAsync(request);//Calling service

        result.Should().BeEquivalentTo(expected);//Checking if result is equal to expected result

        registrationRepository.Verify(_ => _.AddUserToRegistration(someRegistrationBasic.ID, someUserId));//Verifying if service was called with correct variables
    }


}