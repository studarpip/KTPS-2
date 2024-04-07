using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Repositories.PasswordReset;
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
}