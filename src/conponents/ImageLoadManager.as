package conponents
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	public class ImageLoadManager extends EventDispatcher
	{	
		public static const LOAD_FINISHED:String = "loadFinished";
		
		private var _inputFile:File;
		private var _loader:Loader;
		private var _req:URLRequest;
		private var _album:Vector.<BitmapData>;
		private var _urls:Array = [];
		private var _imgCounter:int=0;
		private var _imgsMeasure:int=0;
		private var _per:Number;
		private var _percents:Number;
		public function percents():Number {
			return _percents;
		}
		public function album():Vector.<BitmapData> {
			return _album;
		}
		
		public function ImageLoadManager()
		{
			super();
			_album = new Vector.<BitmapData>;
			_loader = new Loader();
			TweenMax.delayedCall(1,clickChooseBtn);
		}
		
		protected function clickChooseBtn():void
		{
			// TODO Auto-generated method stub
			_inputFile = File.desktopDirectory;
			_inputFile.browseForDirectory("input");
			_inputFile.addEventListener(Event.SELECT , getFile);
		}
		
		private function getFile(event:Event):void {
			var file:File = event.currentTarget as File;
			if(file.isDirectory){
				var imgs:Array = file.getDirectoryListing();
				for(var i:int=0 ; i<imgs.length ; i++){
					var imgFile:File = imgs[i];
					var url:String = imgFile.url;
					_imgsMeasure++;
					trace(url);
					_urls.push(url);
				}
				_per = 1/_imgsMeasure;
				queue();
			}
		}
		
		private function queue():void {
			if(_urls.length>0){
				var url:String = _urls[0];
				_urls.shift();
				loadImage(url);
			}
		}
		
		private function loadImage(url:String):void {
			_req = new URLRequest(url);
			_loader.contentLoaderInfo.addEventListener
				(ProgressEvent.PROGRESS,onProgress);
			_loader.contentLoaderInfo.addEventListener
				(Event.COMPLETE,finishLoadingHandler);
			_loader.load(_req);
		}
		
		protected function finishLoadingHandler(event:Event):void {
			_album.push(Bitmap(_loader.content).bitmapData);
			_imgCounter++;
			if(_imgCounter>=_imgsMeasure){
				loadComplete();
			}else{
				queue();
			}
		}
		
		protected function onProgress(event:ProgressEvent):void {
			var accumulatedPers:Number = _per*_imgCounter;
			var currentPers:Number = 
				_per*(_loader.contentLoaderInfo.bytesLoaded/_loader.contentLoaderInfo.bytesTotal);
			_percents = accumulatedPers+currentPers;
			trace(_percents.toFixed(4));
		}
		
		private function loadComplete():void {
			this.dispatchEvent(new Event(LOAD_FINISHED));	
			trace("load finished...");
		}
	}
}