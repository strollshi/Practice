package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.Socket;
	
	public class SocketComManager extends EventDispatcher
	{
		private var _socket:Socket;
		
		public function SocketComManager(target:IEventDispatcher=null)
		{
			super(target);
			_socket = new Socket();
			_socket.addEventListener(Event.CONNECT , onConnected);
			_socket.addEventListener(IOErrorEvent.IO_ERROR , onError);
			_socket.addEventListener(Event.ACTIVATE, onActivate);
			_socket.addEventListener(Event.DEACTIVATE, onDeactivate);
			_socket.connect("www.limboworks.com",80);
		}
		
		protected function onDeactivate(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("onDeactivate");
		}
		
		protected function onActivate(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("onActivate");
		}
		
		protected function onError(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace("onError");
		}
		
		protected function onConnected(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("onConnected");
		}
	}
}