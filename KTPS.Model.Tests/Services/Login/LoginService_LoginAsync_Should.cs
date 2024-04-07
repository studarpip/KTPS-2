using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Helpers;
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

    [Fact]
    public async void ReturnErrorIfPasswordDoesNotMatch()
    {
        var userService = new Mock<IUserService>();
        var passwordResetRepository = new Mock<IPasswordResetRepository>();

        var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
        userService.Setup(_ => _.GetUserByUsernameAsync("test_user")).ReturnsAsync(new UserBasic { ID = 5, Password = "test_password" });

        var loginRequest = new LoginRequest() { Username = "test_user", Password = "wrong_password" };
        var res = await loginService.LoginAsync(loginRequest);

        var exceptedRes = new ServerResult<int>() { Success = false, Message = "Wrong password!" };
        res.Should().BeEquivalentTo(exceptedRes);
    }

    [Fact]
    public async void ReturnSuccessfulResssssult()
    {
        var userService = new Mock<IUserService>();
        var passwordResetRepository = new Mock<IPasswordResetRepository>();

        var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
        userService.Setup(_ => _.GetUserByUsernameAsync("test_user")).ReturnsAsync(new UserBasic { ID = 5, Password = "test_password".Hash() });

        var loginRequest = new LoginRequest() { Username = "test_user", Password = "test_password" };
        var res = await loginService.LoginAsync(loginRequest);

        var exceptedRes = new ServerResult<int>() { Success = true, Data = 5 };
        res.Should().BeEquivalentTo(exceptedRes);
    }
}