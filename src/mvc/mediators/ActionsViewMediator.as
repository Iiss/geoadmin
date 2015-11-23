package mvc.mediators 
{
	import mvc.events.GameEvent;
	import mvc.models.LayerModel;
	import mvc.models.SessionModel;
	import spark.components.Button;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import mvc.views.ActionsView
	import flash.events.MouseEvent;
	import spark.components.supportClasses.ItemRenderer;
	
	public class ActionsViewMediator extends Mediator 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var view:ActionsView
		
		public function ActionsViewMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(view.loadSessionBtn, MouseEvent.CLICK, _onLoadSessionClick);
			eventMap.mapListener(view.layerSelector, MouseEvent.MOUSE_DOWN, _onLayerSelectorClick);
			view.layerSelector.dataProvider = sessionModel.layers;
			view.mapSelector.dataProvider = sessionModel.maps;
		}
		
		private function _onLoadSessionClick(e:MouseEvent):void
		{
			_dispatchCommandEvent(GameEvent.LOAD_SESSION,{id:view.mapSelector.selectedItem.id});
		}
		
		private function _onLayerSelectorClick(e:MouseEvent):void
		{
			var btn:Button = e.target as Button;
			if (btn)
			{
				var item:ItemRenderer = btn.parent as ItemRenderer;
				if (item)
				{
					_dispatchCommandEvent(GameEvent.TOGGLE_LAYER, { layer_id: item.data.id} );
				}
			}
		}
		
		private function _dispatchCommandEvent(eventType:String,data:Object = null):void
		{
			var ge:GameEvent = new GameEvent(eventType);
			ge.data = data;
			dispatch(ge);
		}
	}
}