using KTPS.Model.Entities;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities.User;
using KTPS.Model.Repositories.Friends;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace KTPS.Model.Services.Friends
{
    public class FriendsService : IFriendsService
    {
        private readonly IFriendsRepository _friendsRepository;

        public FriendsService(
            IFriendsRepository friendsRepository
            )
        {
            _friendsRepository = friendsRepository;
        }
        public async Task<ServerResult<IEnumerable<UserMinimal>>> GetFriendListAsync(int userId)
        {
            try
            {
                var friends = await _friendsRepository.GetFriendListAsync(userId);
                return new() { Success = true, Data = friends };
            }
            catch (Exception)
            {
                return new() { Success = false, Message = "Technical error!" };
            }
        }

        public async Task<ServerResult> DeleteFriendAsync(DeleteFriendRequest request)
        {
            try
            {
                await _friendsRepository.DeleteFriendAsync(request.UserID, request.FriendID);
                await _friendsRepository.DeleteFriendAsync(request.FriendID, request.UserID);
                return new() { Success = true };
            }
            catch (Exception)
            {
                return new() { Success = false, Message = "Technical error!" };
            }
        }

        public Task<ServerResult<IEnumerable<UserMinimal>>> FindFriendAsync(FindFriendRequest request)
        {
            throw new System.NotImplementedException();
        }

        public Task AddFriendAsync(int userId, int friendId)
        {
            throw new NotImplementedException();
        }
    }
}
