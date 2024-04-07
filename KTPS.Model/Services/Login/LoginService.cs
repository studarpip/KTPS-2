using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Repositories.PasswordReset;
using KTPS.Model.Services.User;
using System;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Login;

public class LoginService : ILoginService
{
    private readonly IUserService _userService;
    private readonly IPasswordResetRepository _passwordResetRepository;

    public LoginService(
        IUserService userService,
        IPasswordResetRepository passwordResetRepository
        )
    {
        _userService = userService;
        _passwordResetRepository = passwordResetRepository;
    }

    public async Task<ServerResult> ResetPasswordAsync(ResetPasswordRequest request) => throw new NotImplementedException();

    public async Task<ServerResult> ResetPasswordAuthAsync(ResetPasswordAuthRequest request) => throw new NotImplementedException();

    public async Task<ServerResult<int>> ForgotPasswordAsync(ForgotPasswordRequest request) => throw new NotImplementedException();

    public async Task<ServerResult<int>> LoginAsync(LoginRequest request) => throw new NotImplementedException();
}