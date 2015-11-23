package mvc.commands 
{
	public class LoadSessionCommand extends ExtensionCommand 
	{
		
		public function LoadSessionCommand() 
		{
			super("game.load");
		}
		
		override public function execute():void 
		{
			if (!gameEvent.data.id)
			{
				_command = "game.next";
			}
			super.execute();
		}
	}
}