package  
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import mvc.commands.StartupCommand;
	import mvc.commands.UpdateRoomVarsCommand;
	import mvc.mediators.AppMediator;
	import mvc.mediators.ConnectionPanelMediator;
	import mvc.mediators.ConsoleMediator;
	import mvc.mediators.StorageViewMediator;
	import mvc.models.SessionModel;
	import mvc.views.ConnectionPanel;
	import mvc.views.ConsoleView;
	import mvc.views.StorageView;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.utils.LogService;
	import mvc.events.GameEvent;
	import mvc.commands.AssignProbeCommand;
	import mvc.commands.PingCommand;
	import mvc.views.ActionsView;
	import mvc.mediators.ActionsViewMediator;
	import mvc.commands.LoadSessionCommand;
	import mvc.commands.ToggleLayerCommand;
	/**
	 * ...
	 * @author liss
	 */
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var eventCommandMap:IEventCommandMap;

		[Inject]
		public var directCommandMap:IDirectCommandMap;
		
		[Inject]
		public var contextView:ContextView;
		
		public function AppConfig() 
		{
			
		}
		
		public function configure():void
		{
			//MODELS
			injector.map(ConfigModel).asSingleton();
			injector.map(SessionModel).asSingleton();
			injector.map(SmartFox).toValue(new SmartFox());
			injector.map(LogService).asSingleton();
			//MEDIATORS
			mediatorMap.map(App).toMediator(AppMediator);
			mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
			mediatorMap.map(ConnectionPanel).toMediator(ConnectionPanelMediator);
			mediatorMap.map(StorageView).toMediator(StorageViewMediator);
			mediatorMap.map(ActionsView).toMediator(ActionsViewMediator);
		
			//event
			eventCommandMap.map(GameEvent.ASSIGN_PROBE, GameEvent).toCommand(AssignProbeCommand);
			eventCommandMap.map(GameEvent.PING, GameEvent).toCommand(PingCommand);
			eventCommandMap.map(GameEvent.LOAD_SESSION, GameEvent).toCommand(LoadSessionCommand);
			eventCommandMap.map(GameEvent.TOGGLE_LAYER, GameEvent).toCommand(ToggleLayerCommand);
			eventCommandMap.map(SFSEvent.ROOM_VARIABLES_UPDATE, SFSEvent).toCommand(UpdateRoomVarsCommand);
			//Commands
			directCommandMap.map(StartupCommand).execute();
		}
		
	}

}