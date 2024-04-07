using KTPS.Model.Entities;
using KTPS.Model.Entities.Registration;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Helpers;
using KTPS.Model.Repositories.Registration;
using KTPS.Model.Services.User;
using System;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Registration;

public class RegistrationService : IRegistrationService
{
    private readonly IUserService _userService;
    private readonly IRegistrationRepository _registrationRepository;


    public RegistrationService(
        IUserService userService,
         IRegistrationRepository registrationRepository
    )
    {
        _userService = userService;
        _registrationRepository = registrationRepository;
    }

    public async Task<ServerResult<int>> StartRegistrationAsync(RegistrationStartRequest request)
    {
        var usernameExists = await _userService.UsernameExistsAsync(request.Username);
        if (usernameExists)
            return new() { Success = false, Message = "Username already exists!" };

        var emailExists = await _userService.EmailExistsAsync(request.Email);
        if (emailExists)
            return new() { Success = false, Message = "Email already exists!" };

        var registration = new RegistrationBasic
        {
            Email = request.Email,
            Username = request.Username,
            Password = request.Password.Hash(),
            AuthCode = RandomString.GenerateRandomString()
        };

        var id = await _registrationRepository.InsertAsync(registration);

        return new() { Success = true, Data = id };
    }

    public async Task<ServerResult<int>> AuthRegistrationAsync(RegistrationAuthRequest request)
    {
        throw new NotImplementedException();
    }
}