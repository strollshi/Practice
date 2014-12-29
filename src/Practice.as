package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import nape.SimpleNapeWorld;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.space.Space;
	import nape.util.Debug;
	
	[SWF(backgroundColor="0xffffff",  frameRate="50", width="1024", height="640")] 
	
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
//			var expBar:ExpProgressBar = new ExpProgressBar();
//			addChild(expBar);
//			expBar.x = 200;
//			expBar.y = 400;
//			expBar.testControl(this);
		
			
			nw = new SimpleNapeWorld();
			addChild(nw);
		}
		
		private var nw:SimpleNapeWorld;
	}
}