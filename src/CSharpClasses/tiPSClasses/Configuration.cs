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

	public enum WritePowerShellTipCadence
	{
		Never = 0,
		EverySession = 1,
		Daily = 2,
		Weekly = 3
	}

	public class Configuration
	{
		public ModuleAutoUpdateCadence AutoUpdateCadence { get; set; }
		public WritePowerShellTipCadence AutoWritePowerShellTipCadence { get; set; }

		public Configuration()
		{
			AutoUpdateCadence = ModuleAutoUpdateCadence.Never;
			AutoWritePowerShellTipCadence = WritePowerShellTipCadence.Never;
		}
	}
}
