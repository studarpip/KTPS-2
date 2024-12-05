using KTPS.Model.Entities;
using System.Threading.Tasks;
using System;

namespace KTPS.Model.Services
{
    public class ServiceBase
    {
        protected async Task<ServerResult> ProcessRequestAsync(Func<Task<ServerResult>> operation)
        {
            try
            {
                return await operation();
            }
            catch (ServiceException ex)
            {
                return new ServerResult { Success = false, Message = ex.ErrorMessage };
            }
            catch (Exception)
            {
                return new ServerResult { Success = false, Message = "Technical error occurred" };
            }
        }

        protected async Task<ServerResult<T>> ProcessRequestAsync<T>(Func<Task<ServerResult<T>>> operation)
        {
            try
            {
                return await operation();
            }
            catch (ServiceException ex)
            {
                return new ServerResult<T> { Success = false, Message = ex.ErrorMessage };
            }
            catch (Exception)
            {
                return new ServerResult<T> { Success = false, Message = "Technical error occurred" };
            }
        }
    }
}
