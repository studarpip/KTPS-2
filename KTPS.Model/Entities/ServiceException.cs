using System;

namespace KTPS.Model.Entities
{
    public class ServiceException : Exception
    {
        public string ErrorMessage { get; set; }

        public ServiceException(string errorMessage)
        {
            ErrorMessage = errorMessage;
        }
    }
}
