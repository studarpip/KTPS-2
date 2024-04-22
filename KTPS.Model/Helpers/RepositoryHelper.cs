using System.Collections.Generic;
using System.Linq;

namespace KTPS.Model.Helpers;

public static class RepositoryHelper
{
    public static dynamic MapValuesFromEntity(this object entity)
    {
        var variables = new Dictionary<string, object>();
        var properties = entity.GetType().GetProperties().ToList();
        properties.ForEach(x => variables.Add(x.Name, x.GetValue(entity)));
        return variables;
    }
}