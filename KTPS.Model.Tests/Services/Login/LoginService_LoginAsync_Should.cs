using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Repositories.PasswordReset;
using KTPS.Model.Services.Login;
using KTPS.Model.Services.User;

namespace KTPS.Model.Tests.Services.Login;

public class LoginService_LoginAsync_Should
{
    [Fact]
    public async void ReturnErrorIfUserDoesNotExist()
    {
        var userService = new Mock<IUserService>();
        var passwordResetRepository = new Mock<IPasswordResetRepository>();

        var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
        userService.Setup(_ => _.GetUserByUsernameAsync("test_user")).ReturnsAsync(null as UserBasic);

        var loginRequest = new LoginRequest() { Username = "test_user", Password = "test_password" };
        var res = await loginService.LoginAsync(loginRequest);

        var exceptedRes = new ServerResult<int>() { Success = false, Message = "User does not exist!" };
        res.Should().BeEquivalentTo(exceptedRes);
    }
}