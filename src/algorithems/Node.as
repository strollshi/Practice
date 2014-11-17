package algorithems
{
	import flash.display.Sprite;
	
	public class Node extends Sprite
	{
		public function Node()
		{
			super();
		}
		
		private function init():void {
			
		}
		
		private var _data:Object;//包含父节点，子节点和权值
		public function set data(dt:Object):void {
			_data = dt;
		}
		public function get data():Object {
			return _data;
		}
		
		
		public function dispose():void {
			
		}
	}
}