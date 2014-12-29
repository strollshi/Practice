package nape
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	
	public class SimpleNapeWorld extends Sprite
	{
		private var _world:Space;
		private var _debug:ShapeDebug;
		
		public function SimpleNapeWorld(){
			_world = new Space(new Vec2(0,600));
			_debug = new ShapeDebug(1024,640);
			addChild(_debug.display)
			addEventListener(Event.ENTER_FRAME,loop);
			
			createWalls();
		}
			
		private function loop(event:Event):void
		{
			//Nape空间模拟
			_world.step(1 / 60);
			//清除视图
			_debug.clear();
			//绘制空间
			_debug.draw(_world);
			//优化显示视图
			_debug.flush();
		}
		
		public function createWalls():void {
			var shape:Polygon;
			var ceil:Body = new Body(BodyType.STATIC,new Vec2(512,10));
			shape = new Polygon(Polygon.box(1024,20));
			ceil.shapes.push(shape);
			
			var floor:Body = new Body(BodyType.STATIC,new Vec2(512,640-10));
			shape = new Polygon(Polygon.box(1024,20));
			floor.shapes.push(shape);
			
			var leftWall:Body = new Body(BodyType.STATIC,new Vec2(10,640*.5));
			shape = new Polygon(Polygon.box(20,640));
			leftWall.shapes.push(shape);
			
			var rightWall:Body = new Body(BodyType.STATIC,new Vec2(1024-10,640*.5));
			shape = new Polygon(Polygon.box(20,640));
			rightWall.shapes.push(shape);
			
			ceil.space = _world;
			floor.space = _world;
			leftWall.space = _world;
			rightWall.space = _world;
		}
	}
}


