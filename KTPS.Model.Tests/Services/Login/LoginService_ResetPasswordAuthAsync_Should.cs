using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Repositories.PasswordReset;
using KTPS.Model.Services.Login;
using KTPS.Model.Services.User;

namespace KTPS.Model.Tests.Services.Login
{
    public class LoginServiceResetPasswordAuthAsync_Should
    {
        [Fact]
        public async void ReturnErrorIfRecoveryCodeNotCorrect()
        {
            var userService = new Mock<IUserService>();
            var passwordResetRepository = new Mock<IPasswordResetRepository>();

            var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
            passwordResetRepository.Setup(_ => _.GetCodeAsync(1)).ReturnsAsync("code");

            var resetPasswordAuthRequest = new ResetPasswordAuthRequest() { UserID = 1, RecoveryCode = "wrong_code" };
            var res = await loginService.ResetPasswordAuthAsync(resetPasswordAuthRequest);

            var exceptedRes = new ServerResult() { Success = false, Message = "Recovery code incorrect!" };
            res.Should().BeEquivalentTo(exceptedRes);
        }

        [Fact]
        public async void ReturnSuccessOnCorrectRecoveryCode()
        {
            var userService = new Mock<IUserService>();
            var passwordResetRepository = new Mock<IPasswordResetRepository>();

            var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
            passwordResetRepository.Setup(_ => _.GetCodeAsync(1)).ReturnsAsync("code");

            var resetPasswordAuthRequest = new ResetPasswordAuthRequest() { UserID = 1, RecoveryCode = "code" };
            var res = await loginService.ResetPasswordAuthAsync(resetPasswordAuthRequest);

            var exceptedRes = new ServerResult() { Success = true };
            res.Should().BeEquivalentTo(exceptedRes);
        }
        [Fact]
        public async void ReturnErrorOnException()
        {
            var userService = new Mock<IUserService>();
            var passwordResetRepository = new Mock<IPasswordResetRepository>();

            var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
            passwordResetRepository.Setup(_ => _.GetCodeAsync(1)).Throws(new Exception());

            var resetPasswordAuthRequest = new ResetPasswordAuthRequest() { UserID = 1, RecoveryCode = "code" };
            var res = await loginService.ResetPasswordAuthAsync(resetPasswordAuthRequest);

            var exceptedRes = new ServerResult() { Success = false, Message = "Technical error!" };
            res.Should().BeEquivalentTo(exceptedRes);
        }
    }
}