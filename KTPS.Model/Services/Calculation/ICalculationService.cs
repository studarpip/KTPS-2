using KTPS.Model.Entities;
using KTPS.Model.Entities.Responses;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Calculation;

public interface ICalculationService
{
    Task<ServerResult<CalculationResponse>> CalculateGroupExpensesAsync(int groupId);
}