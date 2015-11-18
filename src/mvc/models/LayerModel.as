package mvc.models 
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class LayerModel extends EventDispatcher
	{
		public var id:int;
		public var title:String;
		public var enabled:Boolean;
		
		public function LayerModel(src:*)
		{
			id = src['id'];
			title = src['title'];
			enabled = Boolean(src['enabled']);
		}
	}

}