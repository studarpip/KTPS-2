using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Services.User;
using System;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Registration;

public class RegistrationService : IRegistrationService
{
    private readonly IUserService _userService;

    public RegistrationService(
        IUserService userService
    )
    {
        _userService = userService;
    }

    public async Task<ServerResult<int>> StartRegistrationAsync(RegistrationStartRequest request)
    {
        var usernameExists = await _userService.UsernameExistsAsync(request.Username);
        if (usernameExists)
            return new() { Success = false, Message = "Username already exists!" };

        throw new NotImplementedException();
    }

    public async Task<ServerResult<int>> AuthRegistrationAsync(RegistrationAuthRequest request)
    {
        throw new NotImplementedException();
    }
}