package MP3Player
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class MP3ResManager extends EventDispatcher
	{
		private var _inputFile:File;
		private var _snd:Sound;
		private var _sndChannel:SoundChannel;
		private var _datas:Array
		private var _callBackFunc:Function;
		public function get datas():Array {
			return _datas;
		}
		
		private static var _instance:MP3ResManager;
		public static function get instance():MP3ResManager {
			if(!_instance){
				_instance = new MP3ResManager();
			}
			return _instance;
		}
		
		public function MP3ResManager(target:IEventDispatcher=null)
		{
			super(target);
			_datas = new Array();
			_sndChannel = new SoundChannel();
		}
		
		public function clickChooseBtn():void
		{
			// TODO Auto-generated method stub
			_inputFile = File.desktopDirectory;
			_inputFile.browseForDirectory("input");
			_inputFile.addEventListener(Event.SELECT , getFile);
		}
		
		private function getFile(event:Event):void {
			var file:File = event.currentTarget as File;
			if(file.isDirectory){
				var sounds:Array = file.getDirectoryListing();
				for(var i:int=0 ; i<sounds.length ; i++){
					var sound:File = sounds[i];
					if(sound.extension!="mp3"&&sound.extension!="wmv")continue;
					var sndObj:Object = new Object();
					sndObj.soundName = sound.name;
					sndObj.url = sound.url;
					_datas.push(sndObj);
				}
			}
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function playSound(sndData:Object):void {
			trace(sndData.url);
			var req:URLRequest = new URLRequest(sndData.url);
			_snd = new Sound();
			_snd.load(req);
			_snd.addEventListener
				(Event.COMPLETE , function onPlay(event:Event):void {
				_sndChannel.stop();
				_sndChannel.soundTransform = new SoundTransform(1,0);
				_sndChannel = _snd.play();
			},false,0,true);
		}
	}
}