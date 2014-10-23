package conponents
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class ImageDisplayManager extends Sprite
	{
		private var _bmpDts:Vector.<BitmapData>;
		private var bmps:Vector.<Bitmap>;
		
		public function ImageDisplayManager(bmpDts:Vector.<BitmapData>)
		{
			super();
			_bmpDts = bmpDts;
			bmps = new Vector.<Bitmap>;
			
		}
		
		public function layout():void {
			for(var i:int=0 ; i<_bmpDts.length ; i++){
				var bmp:Bitmap = new Bitmap(_bmpDts[i]);
				bmp.scaleX=bmp.scaleY=100/bmp.width;
				bmp.smoothing = true;
				addChild(bmp);
			}
		}
	}
}