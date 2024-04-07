using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using System;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Login;

public class LoginService : ILoginService
{
    public async Task<ServerResult> ResetPasswordAsync(ResetPasswordRequest request) => throw new NotImplementedException();

    public async Task<ServerResult> ResetPasswordAuthAsync(ResetPasswordAuthRequest request) => throw new NotImplementedException();

    public async Task<ServerResult<int>> ForgotPasswordAsync(ForgotPasswordRequest request) => throw new NotImplementedException();

    public async Task<ServerResult<int>> LoginAsync(LoginRequest request) => throw new NotImplementedException();
}