package items
{
	import flash.display.Sprite;
	
	public class LaunchPadScrollItem extends Sprite
	{
		private var _data:Object;
		
		public function LaunchPadScrollItem()
		{
			super();
			init();
		}
		
		public function set data(dt:Object):void {
			_data = dt;
		}
		
		public function get data():Object {
			return _data;
		}
		
		private function init():void {
			this.graphics.beginFill(0xffffff,.8);
			this.graphics.drawRect(-40,-60,80,120);
			this.graphics.endFill();
		}
	}
}