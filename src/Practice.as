package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.Socket;
	import flash.sensors.Accelerometer;
	import flash.system.Security;
	
	import conponents.ExpProgressBar;
	
	[SWF(backgroundColor="0xffffff",  frameRate="30", width="1024", height="640")] 
	
	public class Practice extends Sprite
	{
		
		private static var _instance:Practice;
		public static var stage:Stage;
		public static function get instance():Practice {
			if(!_instance){
				_instance = new Practice();
			}
			return _instance;
		}
		
		public function Practice()
		{
			Practice.stage = this.stage;
			var expBar:ExpProgressBar = new ExpProgressBar();
			addChild(expBar);
			expBar.x = 200;
			expBar.y = 400;
			expBar.testControl(this);
		}
	}
}