package cameraConponents
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.JPEGEncoderOptions;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.FileReference;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.ByteArray;
	
	public class CameraManager extends Sprite
	{
		private var _cam:Camera;
		private var _video:Video;
		private var _netStream:NetStream;
		
		public function CameraManager()
		{
			super();
			_cam = Camera.getCamera();
			_cam.setQuality(0,100);
			_cam.setMode(Practice.stage.stageWidth,Practice.stage.stageHeight,30);
			_video = new Video(Practice.stage.stageWidth,Practice.stage.stageHeight);
			_video.attachCamera(_cam);
			addChild(_video);
			
			this.addEventListener(MouseEvent.CLICK , onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var content:DisplayObject = _video.loaderInfo.content;
			var bd:BitmapData = new BitmapData(content.width,content.height);
			bd.draw(content);
			var bmp:Bitmap = new Bitmap(bd);
			var bytes:ByteArray = bd.encode(bd.rect,new JPEGEncoderOptions());
			
			TweenMax.delayedCall(1,addChild,[bmp]);
			TweenMax.delayedCall(3,removeChild,[bmp]);
			
			var file:FileReference = new FileReference();
			var url:String = File.desktopDirectory.nativePath;
			file.save(bytes,"camera.jpg");
		}
	}
}