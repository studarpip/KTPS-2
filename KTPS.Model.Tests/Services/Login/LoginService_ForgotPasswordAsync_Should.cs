using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Entities;
using KTPS.Model.Repositories.PasswordReset;
using KTPS.Model.Services.Login;
using KTPS.Model.Services.User;
using KTPS.Model.Helpers;

namespace KTPS.Model.Tests.Services.Login
{
    public class LoginService_ForgotPasswordAsync_Should
    {
        [Fact]
        public async void ReturnErrorIfUserWithEmailDoesNotExist()
        {
            var userService = new Mock<IUserService>();
            var passwordResetRepository = new Mock<IPasswordResetRepository>();

            var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
            userService.Setup(_ => _.GetUserByEmailAsync("fake_email")).ReturnsAsync(null as UserBasic);

            var forgotPassswordRequest = new ForgotPasswordRequest() { Email = "fake_email" };

            var res = await loginService.ForgotPasswordAsync(forgotPassswordRequest);

            var exceptedRes = new ServerResult<int>() { Success = false, Message = "User with this email does not exist!" };
            res.Should().BeEquivalentTo(exceptedRes);
        }

        [Fact]
        public async void ReturnUserAndGenerateCodeOnSuccess()
        {
            var userService = new Mock<IUserService>();
            var passwordResetRepository = new Mock<IPasswordResetRepository>();

            var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
            userService.Setup(_ => _.GetUserByEmailAsync("some_email")).ReturnsAsync(new UserBasic() { ID = 1, Email = "some_email", Username = "name", Password = "password" });

            var forgotPassswordRequest = new ForgotPasswordRequest() { Email = "some_email" };

            var res = await loginService.ForgotPasswordAsync(forgotPassswordRequest);

            var authCode = RandomString.GenerateRandomString();

            var exceptedRes = new ServerResult<int>() { Success = true, Data = 1 };
            res.Should().BeEquivalentTo(exceptedRes);
            authCode.Count().Should().BeOneOf(6);
        }

        [Fact]
        public async void ReturnErrorOnException()
        {
            var userService = new Mock<IUserService>();
            var passwordResetRepository = new Mock<IPasswordResetRepository>();

            var loginService = new LoginService(userService.Object, passwordResetRepository.Object);
            userService.Setup(_ => _.GetUserByEmailAsync("fake_email")).Throws(new Exception());

            var forgotPassswordRequest = new ForgotPasswordRequest() { Email = "fake_email" };

            var res = await loginService.ForgotPasswordAsync(forgotPassswordRequest);

            var exceptedRes = new ServerResult<int>() { Success = false, Message = "Technical error!" };
            res.Should().BeEquivalentTo(exceptedRes);
        }
    }
}