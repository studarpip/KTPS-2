using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Helpers;
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

    public async Task<ServerResult> ResetPasswordAsync(ResetPasswordRequest request)
    {
        try
        {
            var user = await _userService.GetUserByIdAsync(request.UserID);
            if (user == null)
                return new() { Success = false, Message = "User not found!" };

            var code = await _passwordResetRepository.GetCodeAsync(request.UserID);
            if (!code.Equals(request.AuthCheck))
                return new() { Success = false, Message = "Technical error!" };

            return new() { Success = true };
        }
        catch
        {
            return new() { Success = false, Message = "Technical error!" };
        }
    }

    public async Task<ServerResult> ResetPasswordAuthAsync(ResetPasswordAuthRequest request) => throw new NotImplementedException();

    public async Task<ServerResult<int>> ForgotPasswordAsync(ForgotPasswordRequest request) => throw new NotImplementedException();

    public async Task<ServerResult<int>> LoginAsync(LoginRequest request)
    {
        try
        {
            var user = await _userService.GetUserByUsernameAsync(request.Username);
            if (user is null)
                return new() { Success = false, Message = "User does not exist!" };

            var hashedPassword = request.Password.Hash();
            if (!user.Password.Equals(hashedPassword))
                return new() { Success = false, Message = "Wrong password!" };

            return new() { Success = true, Data = user.ID };
        }
        catch
        {
            return new() { Success = false, Message = "Technical error!" };
        }
    }
}