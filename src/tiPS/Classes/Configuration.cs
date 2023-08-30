// Windows PowerShell only supports C# 5.0, so we can't use any newer language features: https://stackoverflow.com/a/40789694/602585
// List of C# versions and features: https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history
using System;

namespace tiPS
{
	public enum ModuleAutoUpdateCadence
	{
		Never = 0,
		Daily = 1,
		Weekly = 2,
		Biweekly = 3,
		Monthly = 4
	}

	public class Configuration
	{
		public ModuleAutoUpdateCadence { get; set; }

		public Configuration()
		{
			ModuleAutoUpdateCadence = ModuleAutoUpdateCadence.Never;
		}
	}
}
