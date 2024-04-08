namespace KTPS.Server.WebAPI.E2E;

class Program
{
    static async Task Main(string[] args)
    {
        var tests = new List<E2E>
        {
            new RegistrationFlowE2E(),
            new FriendsFlowE2E()
        };

        foreach (var test in tests)
        {
            await test.Test();
        }
    }
}


interface E2E
{
    Task Test();
}

