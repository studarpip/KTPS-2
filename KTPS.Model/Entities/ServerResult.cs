namespace KTPS.Model.Entities;

public class ServerResult
{
    public bool Success { get; set; }
    public string Message { get; set; }

    public ServerResult()
    {

    }

    public ServerResult(bool success)
    {
        Success = success;
    }
    public ServerResult(bool success, string message)
    {
        Success = success;
        Message = message;
    }
}

public class ServerResult<T> : ServerResult
{
    public ServerResult()
    {

    }

    public ServerResult(bool success) : base(success)
    {
    }

    public ServerResult(T data) : base(true)
    {
        Data = data;
    }

    public T Data { get; set; }
}