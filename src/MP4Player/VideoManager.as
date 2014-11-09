package MP4Player
{
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class VideoManager extends Sprite
	{
		public function VideoManager()
		{
			super();
			initConnection();
		}
		
		private var _video:Video;
		private const WIDTH:int = 1136;
		private const HEIGHT:int = 640;
		private var _nc:NetConnection;
		private var _ns:NetStream;
		private var _client:Object;
		
		private function initConnection():void
		{
			// TODO Auto Generated method stub
			_client = new Object();
			_client.onMetaData = onMetaData;
			_nc = new NetConnection();
			_nc.connect(null);
			_nc.addEventListener(NetStatusEvent.NET_STATUS , onNetStatus);
		}
		private function onMetaData(info:Object):void {
			
		}
		
		protected function onNetStatus(event:NetStatusEvent):void
		{
			// TODO Auto-generated method stub
			if(event.info.code=="NetConnection.Connect.Success"){
				_ns = new NetStream(_nc);
				_ns.client = _client;
				initVideo();
			}
		}
		
		private function initVideo():void
		{
			// TODO Auto Generated method stub
			_video = new Video(WIDTH,HEIGHT);
			_video.attachNetStream(_ns);
			_ns.play("start.mp4");
			this.addChild(_video);
		}
	}
}