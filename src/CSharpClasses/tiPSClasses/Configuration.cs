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
		Weekly = 3,
		Biweekly = 4,
		Monthly = 5
	}

	public enum TipRetrievalOrder
	{
		NewestFirst = 0,
		OldestFirst = 1,
		Random = 2
	}

	public enum WritePowerShellTipOptions
	{
		CycleThroughAllTips = 0,
		UnseenTipsOnly = 1
	}

	public class Configuration
	{
		public ModuleAutoUpdateCadence AutoUpdateCadence { get; set; }
		public WritePowerShellTipCadence AutoWritePowerShellTipCadence { get; set; }
		public TipRetrievalOrder TipRetrievalOrder { get; set; }
		public WritePowerShellTipOptions AutoWritePowerShellTipOptions { get; set; }

		public Configuration()
		{
			AutoUpdateCadence = ModuleAutoUpdateCadence.Never;
			AutoWritePowerShellTipCadence = WritePowerShellTipCadence.Never;
			TipRetrievalOrder = TipRetrievalOrder.NewestFirst;
			AutoWritePowerShellTipOptions = WritePowerShellTipOptions.CycleThroughAllTips;
		}
	}
}
