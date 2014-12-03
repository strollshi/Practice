package conponents
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.PNGEncoderOptions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	public class FileManager extends EventDispatcher
	{
		private static var _instance:FileManager;
		public static function instance():FileManager {
			if(!_instance){
				_instance = new FileManager();
			}
			return _instance;
		}
		
		public function FileManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private var _container:Sprite;
		public function set container(sp:Sprite):void {
			_container = sp;
		}
		
		private var fr:FileReference = new FileReference();
		private var _loader:Loader = new Loader();
		public function browseFile():void {
			var filterArr:FileFilter = new FileFilter("png","jpeg","jpg");
			fr.browse([filterArr]);
			fr.addEventListener(Event.SELECT , onSelectFile);
		}
		protected function onSelectFile(event:Event):void
		{
			// TODO Auto-generated method stub
			fr.load();
			fr.removeEventListener(Event.SELECT , onSelectFile);
			fr.addEventListener(Event.COMPLETE , onCompleteLoadFile);
		}
		protected function onCompleteLoadFile(event:Event):void
		{
			// TODO Auto-generated method stub
			var bytes:ByteArray = fr.data;
			trace(fr.name,fr.extension,fr.size,fr.type);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteLoadBytes);
			_loader.loadBytes(bytes);
		}
		protected function onCompleteLoadBytes(event:Event):void
		{
			// TODO Auto-generated method stub
			_container.addChild(_loader.content);
		}

		
		///////////////////
		
		private var file:File = new File();
		private var fs:FileStream = new FileStream();
		public function getFile():void {
			file.browseForOpen("");
			file.addEventListener(Event.SELECT , onGetFile);
		}
		protected function onGetFile(event:Event):void
		{
			// TODO Auto-generated method stub
			fs.open(file,FileMode.READ);
			trace(fs.bytesAvailable);
			if(file.extension=="txt"){
				var str:String = fs.readUTFBytes(fs.bytesAvailable);
				fs.close();
				trace(str);
			}
		}
		
		////////////////////
		
		public function saveFile():void {
//			var bd:BitmapData = new BitmapData(100,100,true,0xffffff);
//			var encoder:PNGEncoderOptions = new PNGEncoderOptions();
//			var bytes:ByteArray = bd.encode(bd.rect,encoder);
//			var fl:File = File.desktopDirectory.resolvePath("savedBmp.png");
//			fs.open(fl,FileMode.WRITE);
//			fs.writeBytes(bytes,0,bytes.bytesAvailable);
//			fs.close();
			
			var str:String = "xxxxxxxxxxx";
			var fl:File = File.desktopDirectory.resolvePath("savedTxt.txt");
			fs.open(fl,FileMode.WRITE);
			fs.writeUTFBytes(str);
			fs.close();
		}
		
	}
}