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
		private static const LAYERS_DATA_VAR:String = "layers";
		
		private var _room:Room;
		private var _storage:ArrayCollection;
		private var _layers:ArrayCollection;
		
		public function get storage():ArrayCollection { return _storage; }
		public function get room():Room { return _room; }
		public function get layers():ArrayCollection { return _layers; }
		
		public function SessionModel() 
		{
			_storage = new ArrayCollection();
			_layers = new ArrayCollection();
		}
		
		public function setup(room:Room):void
		{
			_room = room;
			updateRoomVars([
							LAYERS_DATA_VAR,
							STORAGE_DATA_VAR
							]);
		}
		
		public function updateRoomVars(varsArr:Array):void
		{
			for each (var roomVar:String in varsArr)
			{
				switch (roomVar)
				{
					case LAYERS_DATA_VAR:
						updateLayers();
						break;
						
					case STORAGE_DATA_VAR:
						updateStorage();
						break;
				}
			}
		}
		
		private function updateLayers():void
		{
			var src:Array = dumpToArray(LAYERS_DATA_VAR);
			var newLayers:Array = new Array();
			
			for each(var obj:* in src)
			{
				newLayers.push(new LayerModel(obj));
			}
			_layers.source = newLayers;
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