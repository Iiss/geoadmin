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
		private static const HAS_COMMON_MAPS_VAR:String = "hasCommonMaps";
		private static const EPIC_MAPS_VAR:String = "epicMaps";
		
		private var _room:Room;
		private var _storage:ArrayCollection;
		private var _layers:ArrayCollection;
		private var _maps:ArrayCollection;
		
		public function get storage():ArrayCollection { return _storage; }
		public function get room():Room { return _room; }
		public function get layers():ArrayCollection { return _layers; }
		public function get maps():ArrayCollection { return _maps; }
		
		public function SessionModel() 
		{
			_storage = new ArrayCollection();
			_layers = new ArrayCollection();
			_maps = new ArrayCollection();
		}
		
		public function setup(room:Room):void
		{
			_room = room;
			updateMapList();
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
		
		private function updateMapList():void
		{
			var epicMaps:Array = dumpToArray(EPIC_MAPS_VAR);
			if (room.getVariable(HAS_COMMON_MAPS_VAR).getBoolValue())
			{
				epicMaps.unshift( { title: "Станд. игра" } );
			}
			_maps.source = epicMaps;
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