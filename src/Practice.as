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
	
	import conponents.BottomController;
	import conponents.HorizPageScroller;
	import conponents.ImageLoadManager;
	import conponents.VertScrollList;
	
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
		
		public function Practice()
		{
			Practice.stage = this.stage;
			//TweenMax.delayedCall(2,initList);
			
			TweenMax.delayedCall(1,MP3ResManager.instance.clickChooseBtn);
			MP3ResManager.instance.addEventListener(Event.COMPLETE,initList);
			trace("change1");
		}
		
		protected function initList(event:Event):void
		{
			// TODO Auto-generated method stub
			var datas:Array = MP3ResManager.instance.datas;
			var _vertList:VertScrollList = new VertScrollList(this,400,100,10,datas);
		}
	}
}