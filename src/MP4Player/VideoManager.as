package MP4Player
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
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
		private var _duration:Number;
		private var _totalBytes:int;
		private var _byteLoaded:int;
		
		private function initConnection():void
		{
			// TODO Auto Generated method stub
			_client = new Object();
			_client.onMetaData = onMetaData;
			_nc = new NetConnection();
			_nc.addEventListener(NetStatusEvent.NET_STATUS , onNetStatus);
			_nc.connect(null);
		}
		private function onMetaData(info:Object):void {
			_duration = info.duration;
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
			
			addEventListener(Event.ENTER_FRAME , onCatchData);
		}
		
		protected function onCatchData(event:Event):void
		{
			// TODO Auto-generated method stub
		}		
		
		/********
		 * control
		 * *****/
		
		public function resume():void {
			_ns.resume();
		}
		
		public function pause():void {
			_ns.pause();	
		}
		
		public function volume(ratio:Number):void {
			var transform:SoundTransform = _ns.soundTransform;
			transform.volume = ratio;
			_ns.soundTransform = transform;
		}
		
		public function playByDragSpot(ratio:Number):void {
			_ns.seek(_duration*ratio);
		}
		
		public function stop():void {
			_ns.close();
			_video.clear();
		}
	}
}