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
        var someUsername = "someUsername";//Setting up variables
        var someEmail = "someEmail";
        var somePassword = "somePassword";

        var userService = new Mock<IUserService>();
        userService.Setup(_ => _.UsernameExistsAsync(someUsername)).ReturnsAsync(true);//Mocking service to return true

        var registrationRepository = new Mock<IRegistrationRepository>();

        var registrationService = new RegistrationService(userService.Object, registrationRepository.Object);

        var request = new RegistrationStartRequest() { Username = someUsername, Email = someEmail, Password = somePassword };//Setting up a request
        var expected = new ServerResult<int>() { Success = false, Message = "Username already exists!" };//Setting up expected result

        var result = await registrationService.StartRegistrationAsync(request);//Calling service

        result.Should().BeEquivalentTo(expected);//Checking if result is equal to expected result
    }

    [Fact]
    public async void ReturnErrorIfEmailExists()
    {
        var someUsername = "someUsername";//Setting up variables
        var someEmail = "someEmail";
        var somePassword = "somePassword";

        var userService = new Mock<IUserService>();
        userService.Setup(_ => _.EmailExistsAsync(someEmail)).ReturnsAsync(true);//Mocking service to return true

        var registrationRepository = new Mock<IRegistrationRepository>();

        var registrationService = new RegistrationService(userService.Object, registrationRepository.Object);

        var request = new RegistrationStartRequest() { Username = someUsername, Email = someEmail, Password = somePassword };//Setting up a request
        var expected = new ServerResult<int>() { Success = false, Message = "Email already exists!" };//Setting up expected result

        var result = await registrationService.StartRegistrationAsync(request);//Calling service

        result.Should().BeEquivalentTo(expected);//Checking if result is equal to expected result
    }

    [Fact]
    public async void CreateRegistrationBasicAndReturnRegistrationId()
    {
        var someUsername = "someUsername";//Setting up variables
        var someEmail = "someEmail";
        var somePassword = "somePassword";
        var someRegistrationId = 0;

        var userService = new Mock<IUserService>();
        userService.Setup(_ => _.EmailExistsAsync(someEmail)).ReturnsAsync(false);
        userService.Setup(_ => _.UsernameExistsAsync(someUsername)).ReturnsAsync(false);

        var registrationRepository = new Mock<IRegistrationRepository>();
        var expectedRegistrationBasic = new RegistrationBasic()//Setting up expected registration to check parameters later
        {
            UserID = null,
            Username = someUsername,
            Email = someEmail,
            Password = somePassword.Hash()
        };
        registrationRepository.Setup(_ => _.InsertAsync(It.IsAny<RegistrationBasic>())).ReturnsAsync(someRegistrationId);//Mocking service to return registration

        var registrationService = new RegistrationService(userService.Object, registrationRepository.Object);

        var request = new RegistrationStartRequest() { Username = someUsername, Email = someEmail, Password = somePassword };//Setting up a request
        var expected = new ServerResult<int>() { Success = true, Data = someRegistrationId };//Setting up expected result

        var result = await registrationService.StartRegistrationAsync(request);//Calling service

        result.Should().BeEquivalentTo(expected);//Checking if result is equal to expected result
        registrationRepository.Verify(_ => _.InsertAsync(It.Is<RegistrationBasic>(r =>
            r.UserID == expectedRegistrationBasic.UserID
            && r.Username == expectedRegistrationBasic.Username
            && r.Email == expectedRegistrationBasic.Email
            && r.Password == expectedRegistrationBasic.Password
        )));//Checking if insterted registration is the same to the expected
    }

}