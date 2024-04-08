
using System.Data;
using FluentAssertions;
using MySql.Data.MySqlClient;
using Dapper;
using Newtonsoft.Json;
using System.Text;
using KTPS.Model.Entities.Requests;
using KTPS.Model.Entities;
using KTPS.Model.Entities.Registration;
using KTPS.Model.Helpers;
using KTPS.Model.Entities.User;

namespace KTPS.Server.WebAPI.E2E;

public class TestDbRepository
{
    public TestDbRepository() { }

    private string TestDbConnectionString = "server=127.0.0.1;port=3306;uid=ktps2testuser;pwd=;database=ktps2test";

    public async Task<IEnumerable<TRes>> QueryListAsync<TRes, T>(string command, T parameters)
    {
        using IDbConnection connection = new MySqlConnection(TestDbConnectionString);
        return await connection.QueryAsync<TRes>(command, parameters, commandType: CommandType.Text);
    }

    public async Task<TRes> QueryAsync<TRes>(string command, object? parameters = null)
    {
        using IDbConnection connection = new MySqlConnection(TestDbConnectionString);
        return await connection.QuerySingleOrDefaultAsync<TRes>(command, parameters, commandType: CommandType.Text);
    }

    public async Task ExecuteAsync(string command, object? parameters = null)
    {
        using IDbConnection connection = new MySqlConnection(TestDbConnectionString);
        await connection.ExecuteAsync(command, parameters, commandType: CommandType.Text);
    }

    public async Task DropAllTables()
    {
        var query = @"
            drop table if exists friends;
            drop table if exists group_members;
            drop table if exists user_groups;
            drop table if exists guests;
            drop table if exists notifications;
            drop table if exists passwordResets;
            drop table if exists registrations;
            drop table if exists users;
        ";

        await ExecuteAsync(query);
    }

    public async Task CreateAllTables()
    {
        var friends = @"
            CREATE TABLE friends (
                ID INT AUTO_INCREMENT PRIMARY KEY,
                FriendID INT NOT NULL,
                UserID INT NOT NULL,
                CONSTRAINT unique_friend_user UNIQUE (FriendId, UserId)
            );
        ";

        var groupMembers = @"
            CREATE TABLE group_members (
                ID INT AUTO_INCREMENT PRIMARY KEY,
                GroupID INT NOT NULL,
                UserID INT NOT NULL,
                CONSTRAINT uc_user_group UNIQUE (UserId, GroupId)
            );
        ";

        var userGroups = @"
            CREATE TABLE user_groups (
                ID INT AUTO_INCREMENT PRIMARY KEY,
                Name VARCHAR(255) NOT NULL,
                OwnerUserID INT NOT NULL
            );
        ";

        var guests = @"
            CREATE TABLE guests (
                ID INT AUTO_INCREMENT PRIMARY KEY,
                Name VARCHAR(255) NOT NULL,
                GroupID INT NOT NULL
            );
        ";

        var notifications = @"
            CREATE TABLE notifications (
                ID INT AUTO_INCREMENT PRIMARY KEY,
                SenderID INT NOT NULL,
                ReceiverID INT NOT NULL,
                GroupID INT,
                Type VARCHAR(255),
                Responded TINYINT(1)
            );
        ";

        var passwordResets = @"
            CREATE TABLE passwordResets (
                ID INT AUTO_INCREMENT PRIMARY KEY,
                UserID INT NOT NULL,
                RecoveryCode VARCHAR(10) NOT NULL
            );
        ";

        var registrations = @"
            CREATE TABLE registrations (
                ID INT AUTO_INCREMENT PRIMARY KEY,
                UserID INT,
                Username VARCHAR(255) NOT NULL,
                Password VARCHAR(255) NOT NULL,
                Email VARCHAR(255) NOT NULL,
                AuthCode VARCHAR(255) NOT NULL
            );
        ";

        var users = @"
            CREATE TABLE users (
                ID INT AUTO_INCREMENT PRIMARY KEY,
                Username VARCHAR(255) NOT NULL UNIQUE,
                Email VARCHAR(255) NOT NULL UNIQUE,
                Password VARCHAR(255) NOT NULL
            );
        ";

        var finalQuery = friends + groupMembers + userGroups + guests + notifications + passwordResets + registrations + users;
        await ExecuteAsync(finalQuery, new { });
    }

    public async Task ResetDb()
    {
        await DropAllTables();
        await CreateAllTables();
    }
}