package
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.Socket;
	import flash.system.MessageChannel;
	import flash.system.System;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	
	import MP3Player.MP3ResManager;
	
	import MP4Player.VideoManager;
	
	import cameraConponents.CameraManager;
	
	import conponents.BottomController;
	import conponents.EllipseOrbit;
	import conponents.HorizPageScroller;
	import conponents.ImageLoadManager;
	import conponents.LaunchPadScrollList;
	import conponents.RotationController;
	import conponents.VertScrollList;
	import conponents.XMLFileAnalysisor;
	
	[SWF(backgroundColor="0x000000",  frameRate="30", width="1024", height="640")] 
	
	public class Practice extends Sprite
	{
		
		private static var _instance:Practice;
		public static var stage:Stage;
		public static function get instance():Practice {
			if(!_instance){
				_instance = new Practice();
			}
			return _instance;
		}
		private var orbit:EllipseOrbit = new EllipseOrbit();
		private var _controller:RotationController;
		public function Practice()
		{
			Practice.stage = this.stage;
//			initList();
			addChild(orbit.container);
			orbit.container.x = Practice.stage.stageWidth*.5;
			orbit.container.y = Practice.stage.stageHeight*.5;
			addEventListener(Event.ENTER_FRAME , run);
			
			_controller = new RotationController(orbit);
		}
		
		protected function run(event:Event):void
		{
			// TODO Auto-generated method stub
			orbit.update();
		}
		
//		private function initList():void {
//			var ary:Array = [];
//			for(var i:int=0 ; i<20 ; i++){
//				ary.push(0);
//			}
//			var list:LaunchPadScrollList = 
//				new LaunchPadScrollList(this,ary);
//		}
	}
}