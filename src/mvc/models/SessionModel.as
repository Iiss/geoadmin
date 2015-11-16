package mvc.models 
{
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.variables.RoomVariable;
	import flash.events.EventDispatcher;
	import mx.collections.ArrayCollection;
	import mvc.models.StorageConfig;
	/**
	 * ...
	 * @author liss
	 */
	public class SessionModel extends EventDispatcher
	{
		private static const STORAGE_DATA_VAR:String = "storage";
		
		private var _room:Room;
		private var _storage:ArrayCollection;
		
		public function get storage():ArrayCollection { return _storage; }
		public function get room():Room { return _room; }
		
		public function SessionModel() 
		{
			_storage = new ArrayCollection();
		}
		
		public function setup(room:Room):void
		{
			_room = room;
			updateStorage();
		}
		
		public function updateRoomVariable(varName:String):void
		{
			switch (true)
			{
				case varName == STORAGE_DATA_VAR:
					updateStorage();
					break;
			}
		}
		
		private function updateStorage():void
		{
			_storage.source = dumpToArray(STORAGE_DATA_VAR).filter(filterUnassigmentProbes);
		}
		
		private function filterUnassigmentProbes(element:*, index:int, arr:Array):Boolean 
		{
			var assigned:Boolean = !isNaN(element.kern_id);
			if (!assigned)
			{
				element.color = StorageConfig.getColor(element.rock_key);
				element.boxNumber = StorageConfig.getBox(element.rock_key);
			}
			return !assigned;
		}
		
		private function dumpToArray(varName:String):Array
		{
			if (_room)
			{
				var roomVar:RoomVariable =  _room.getVariable(varName)
				if (roomVar)
				{
					var arr:SFSArray = roomVar.getSFSArrayValue() as SFSArray;
					if (arr)
					{
						return arr.toArray();
					}
				}
			}
			
			return null
		}
	}
}