using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Services.Registration;

namespace KTPS.Model.Tests.Services.Registration;

public class RegistrationService_StartRegistration_Should
{

    [Fact]
    public async void ReturnErrorIfUserExists()
    {
        var registrationService = new RegistrationService();

        var request = new RegistrationStartRequest() { Username = "someUsername", Email = "someEmail", Password = "somePassword" };
        var expected = new ServerResult() { Success = false, Message = "User already exists" };

        var result = await registrationService.StartRegistrationAsync(request);

        Assert.Equal(expected, result);
    }
}