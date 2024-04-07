using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Helpers;
using KTPS.Model.Repositories.PasswordReset;
using KTPS.Model.Repositories.User;
using KTPS.Model.Services.Login;
using KTPS.Model.Services.User;

namespace KTPS.Model.Tests.Services.Login;

public class LoginService_ResetPasswordAsync_Should
{
    [Fact]
    public async void ReturnErrorIfUserDoesNotExist()
    {
        var userService = new Mock<IUserService>();
        var passwordResetRepository = new Mock<IPasswordResetRepository>();

        var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
        userService.Setup(_ => _.GetUserByIdAsync(5)).ReturnsAsync(null as UserBasic);

        var resetPaswordRequest = new ResetPasswordRequest() { UserID = 5 };
        var res = await loginService.ResetPasswordAsync(resetPaswordRequest);

        var exceptedRes = new ServerResult() { Success = false, Message = "User not found!" };
        res.Should().BeEquivalentTo(exceptedRes);
    }

    [Fact]
    public async void ReturnErrorIfAuthCodeDoesNotMatch()
    {
        var userService = new Mock<IUserService>();
        var passwordResetRepository = new Mock<IPasswordResetRepository>();

        var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
        userService.Setup(_ => _.GetUserByIdAsync(5)).ReturnsAsync(new UserBasic());
        passwordResetRepository.Setup(_ => _.GetCodeAsync(5)).ReturnsAsync("abcdef");

        var resetPaswordRequest = new ResetPasswordRequest() { UserID = 5, AuthCheck = "wrong_code" };
        var res = await loginService.ResetPasswordAsync(resetPaswordRequest);

        var exceptedRes = new ServerResult() { Success = false, Message = "Technical error!" };
        res.Should().BeEquivalentTo(exceptedRes);
    }

    [Fact]
    public async void ReturnSuccessfulResultAndChangePassword()
    {
        var passwordResetRepository = new Mock<IPasswordResetRepository>();
        var userRepository = new Mock<IUserRepository>();
        var userServiceMock = new Mock<IUserService>();
        var userService = new UserService(userRepository.Object);

        var loginService = new LoginService(userServiceMock.Object, passwordResetRepository.Object);
        userServiceMock.Setup(_ => _.GetUserByIdAsync(5)).ReturnsAsync(new UserBasic());
        passwordResetRepository.Setup(_ => _.GetCodeAsync(5)).ReturnsAsync("abcdef");

        var resetPaswordRequest = new ResetPasswordRequest() { UserID = 5, AuthCheck = "abcdef", NewPassword = "test_password" };
        var res = await loginService.ResetPasswordAsync(resetPaswordRequest);

        var expecetedRes = new ServerResult { Success = true };
        res.Should().BeEquivalentTo(expecetedRes);

        userRepository.Setup(_ => _.GetByIdAsync(5)).ReturnsAsync(new UserBasic { Password = resetPaswordRequest.NewPassword.Hash() });
        var updatedUser = await userService.GetUserByIdAsync(5);

        var expectedRes2 = new UserBasic { Password = resetPaswordRequest.NewPassword.Hash() };
        updatedUser.Should().BeEquivalentTo(expectedRes2);
    }
}