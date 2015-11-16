package mvc.commands 
{
	import ru.marstefo.liss.net.commands.LoadCommandBase;
	import mvc.models.StorageConfig;
	/**
	 * ...
	 * @author liss
	 */
	public class LoadStorageConfigCommand extends LoadCommandBase 
	{
		private static const CONFIG_PATH:String = "config/storage-config.xml";
		
		public function LoadStorageConfigCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			load(CONFIG_PATH);
		}
		
		override protected function onComplete(result:*):void 
		{
			var data:XML = new XML(result);
			StorageConfig.setup(data);
		}	
	}

}