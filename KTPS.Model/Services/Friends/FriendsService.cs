using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Friends
{
    public class FriendsService : IFriendsService
    {
        public Task AddFriendAsync(int userId, int friendId)
        {
            throw new System.NotImplementedException();
        }

        public Task<ServerResult> DeleteFriendAsync(DeleteFriendRequest request)
        {
            throw new System.NotImplementedException();
        }

        public Task<ServerResult<IEnumerable<UserMinimal>>> FindFriendAsync(FindFriendRequest request)
        {
            throw new System.NotImplementedException();
        }

        public Task<ServerResult<IEnumerable<UserMinimal>>> GetFriendListAsync(int userId)
        {
            throw new System.NotImplementedException();
        }
    }
}
