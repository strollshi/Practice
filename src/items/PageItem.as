package items
{
	import flash.display.Sprite;
	
	public class PageItem extends Sprite
	{
		public function PageItem()
		{
			super();
		}
		
		protected var _data:Object;
		public var relativeX:int;
		
		public function set data(data:Object):void {
			_data = data;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function dispose():void {
			_data = null;
		}
	}
}