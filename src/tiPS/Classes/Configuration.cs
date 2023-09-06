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

	public enum ShowPowerShellTipCadence
	{
		Never = 0,
		EveryStartup = 1,
		Daily = 2,
		Weekly = 3
	}

	public class Configuration
	{
		public ModuleAutoUpdateCadence AutoUpdateCadence { get; set; }
		public ShowPowerShellTipCadence AutoShowPowerShellTipCadence { get; set; }

		public Configuration()
		{
			AutoUpdateCadence = ModuleAutoUpdateCadence.Never;
			AutoShowPowerShellTipCadence = ShowPowerShellTipCadence.Never;
		}
	}
}
