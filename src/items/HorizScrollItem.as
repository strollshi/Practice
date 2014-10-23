package items
{
	import flash.display.Shape;
	import flash.display.Sprite;

	public class HorizScrollItem extends PageItem
	{
		private var _skin:Shape;
		public static const WIDTH:int = 800;
		public static const HEIGHT:int = 500;
		
		public function HorizScrollItem()
		{
			super();
			initUI();
		}
		
		private function initUI():void {
			if(!_skin)_skin = new Shape();
			_skin.graphics.beginFill(0xffffff,.5);
			_skin.graphics.drawRect(0,0,WIDTH,HEIGHT);
			_skin.graphics.endFill();
			addChild(_skin);
		}
	}
}