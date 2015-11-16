package mvc.models 
{
	public class StorageConfig 
	{
		private static var _items:Object;
		
		public static function setup(config:XML):void
		{
			_items = new Object;
			var rockKey:int;
			var color:uint;
			var boxNumber:int;
			
			for each (var node:XML in config.children())
			{
				rockKey = parseInt(node.@rock_key);
				color = uint(node.@color);
				boxNumber = parseInt(node.@box_number);
				
				_items[rockKey] = { color:color, boxNumber:boxNumber };
			}
		}
		
		public static function getColor(rock_key:int):uint{ return _items[rock_key].color }
		public static function getBox(rock_key:int):int{ return _items[rock_key].boxNumber }
	}
}