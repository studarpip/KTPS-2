using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Entities;
using KTPS.Model.Repositories.PasswordReset;
using KTPS.Model.Repositories.User;
using KTPS.Model.Services.Login;
using KTPS.Model.Services.User;

namespace KTPS.Model.Tests.Services.User
{
    public class UserService_Should
    {
        [Fact]
        public async void ReturnTrueIfUserIsFoundByUsername()
        {
            var someUsername = "username";

            var userRepositoryMock = new Mock<IUserRepository>();
            var userService = new UserService(userRepositoryMock.Object);

            userRepositoryMock.Setup(_ => _.GetByUsernameAsync(someUsername)).ReturnsAsync(new UserBasic());

            var res = await userService.UsernameExistsAsync(someUsername);

            Assert.True(res);
        }

        [Fact]
        public async void ReturnFalseIfUserIsNotFoundByUsername()
        {
            var someUsername = "username";

            var userRepositoryMock = new Mock<IUserRepository>();
            var userService = new UserService(userRepositoryMock.Object);

            userRepositoryMock.Setup(_ => _.GetByUsernameAsync(someUsername)).ReturnsAsync(null as UserBasic);

            var res = await userService.UsernameExistsAsync(someUsername);

            Assert.False(res);
        }

        [Fact]
        public async void ReturnTrueIfUserIsFoundByEmail()
        {
            var someEmail = "email";

            var userRepositoryMock = new Mock<IUserRepository>();
            var userService = new UserService(userRepositoryMock.Object);

            userRepositoryMock.Setup(_ => _.GetByEmailAsync(someEmail)).ReturnsAsync(new UserBasic());

            var res = await userService.EmailExistsAsync(someEmail);

            Assert.True(res);
        }

        [Fact]
        public async void ReturnFalseIfUserIsNotFoundByEmail()
        {
            var someEmail = "email";

            var userRepositoryMock = new Mock<IUserRepository>();
            var userService = new UserService(userRepositoryMock.Object);

            userRepositoryMock.Setup(_ => _.GetByEmailAsync(someEmail)).ReturnsAsync(null as UserBasic);

            var res = await userService.EmailExistsAsync(someEmail);

            Assert.False(res);
        }
        [Fact]
        public async void ReturnUserIfUserIsFoundByUsername()
        {
            var someUsername = "username";

            var userRepositoryMock = new Mock<IUserRepository>();
            var userService = new UserService(userRepositoryMock.Object);

            userRepositoryMock.Setup(_ => _.GetByUsernameAsync(someUsername)).ReturnsAsync(new UserBasic());

            var res = await userService.GetUserByUsernameAsync(someUsername);

            res.Should().BeEquivalentTo(new UserBasic());
        }

        [Fact]
        public async void ReturnNullIfUserIsNotFoundByUsername()
        {
            var someUsername = "username";

            var userRepositoryMock = new Mock<IUserRepository>();
            var userService = new UserService(userRepositoryMock.Object);

            userRepositoryMock.Setup(_ => _.GetByUsernameAsync(someUsername)).ReturnsAsync(null as UserBasic);

            var res = await userService.GetUserByUsernameAsync(someUsername);

            res.Should().BeNull();
        }
    }
}
