using KTPS.Server.WebAPI.E2E.Controllers;

namespace KTPS.Server.WebAPI.E2E;

class Program
{
    static async Task Main(string[] args)
    {
        var tests = new List<E2E>
        {
            new RegistrationFlowE2E(),
            new FriendsFlowE2E(),
            new LoginFlowE2E(),
            new ResetPasswordFlowE2E(),
            new GroupsFlowE2E()
        };

        foreach (var test in tests)
        {
            await test.Test();
            Console.WriteLine(test.GetType() + " passed");
        }

        Console.WriteLine("All test passed!");
    }
}


interface E2E
{
    Task Test();
}

