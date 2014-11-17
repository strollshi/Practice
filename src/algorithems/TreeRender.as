package algorithems
{
	public class TreeRender implements IRender
	{
		private static var _instance:TreeRender;
		public static function get instance():TreeRender {
			return _instance;
		}
		
		public function TreeRender()
		{
			_instance = new TreeRender();
		}
		
		public function dispose():void {
			
		}
		
		private var _data:Object;
		public function set data(dt:Object):void{
			_data = dt;
		}
		public function get data():Object{
			return _data;
		}
		

		public function render():void{
			
		}
		public function update():void{
			
		}
	}
}