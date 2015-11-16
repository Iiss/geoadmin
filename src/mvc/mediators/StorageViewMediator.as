package mvc.mediators 
{
	import mvc.events.GameEvent;
	import mvc.models.SessionModel;
	import mvc.views.StorageView;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class StorageViewMediator extends Mediator
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var view:StorageView;
		
		public function StorageViewMediator() 
		{
			super();
		}
		override public function initialize():void 
		{
			super.initialize();
			view.dataProvider = sessionModel.storage;
			eventMap.mapListener(view.form, GameEvent.ASSIGN_PROBE, _onSubmit);
		}
		
		private function _onSubmit(e:GameEvent):void
		{
			var ge:GameEvent = new GameEvent(GameEvent.ASSIGN_PROBE);
			ge.data = { probe_id:1, kern_id:2 };
			dispatch(e);
		}
	}
}