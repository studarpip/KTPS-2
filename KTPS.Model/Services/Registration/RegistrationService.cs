using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using System;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Registration;

public class RegistrationService : IRegistrationService
{
    public RegistrationService() { }

    public async Task<ServerResult<int>> StartRegistrationAsync(RegistrationStartRequest request)
    {
        throw new NotImplementedException();
    }

    public async Task<ServerResult<int>> AuthRegistrationAsync(RegistrationAuthRequest request)
    {
        throw new NotImplementedException();
    }
}