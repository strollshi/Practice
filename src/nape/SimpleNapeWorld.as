package nape
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.constraint.PivotJoint;
	import nape.dynamics.InteractionFilter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	
	[SWF(backgroundColor="0x000000",  frameRate="30")] 
	
	public class SimpleNapeWorld extends Sprite
	{
		
		private var _world:Space;
		private var _debug:ShapeDebug;
		private var _circleBody:Body;
		private var _circleBody1:Body;
		private var rope:RopeJoint;
		private var dildo:Dildo;
		private var fluid:Fluid;
		private var _bg:Sprite = new Sprite();
		
		public function SimpleNapeWorld(){
			_bg.graphics.beginFill(0x000000,.1);
			_bg.graphics.drawRect(0,0,1024,700);
			_bg.graphics.endFill();
			this.addChild(_bg);
			
			_world = new Space(new Vec2(0,1));
			_debug = new ShapeDebug(1024,640);
			//addChild(_debug.display);
			fluid = new Fluid(this,_world,4);			
			createWalls();
//			createBodies();
			createMouseJoint();
			
			addEventListener(Event.ENTER_FRAME,loop);
			addEventListener(MouseEvent.CLICK , randomCreateBody);
			
			var interlistener:InteractionListener = new InteractionListener(
				CbEvent.ONGOING,
				InteractionType.COLLISION,
				_steelType,
				CbType.ANY_BODY,
				collisionHandler);
			
			_world.listeners.add(interlistener);
		}
		
		private function collisionHandler(cb:InteractionCallback):void
		{
			// TODO Auto Generated method stub
			trace(cb.int1,cb.int2);
			delayedCancelCollision(cb.int1 as Body);
		}
		private function delayedCancelCollision(bd:Body):void {
			bd.castBody.shapes.at(0).filter.collisionMask = ~bd.castBody.shapes.at(0).filter.collisionMask;
		}
		
		private var _randBds:Array = [];
		private var _steelType:CbType = new CbType();
		public function randomCreateBody(evt:MouseEvent):void {
			var bd:Body = new Body(BodyType.DYNAMIC,new Vec2(this.mouseX,this.mouseY));
			bd.mass = 50;
			var filter:InteractionFilter = new InteractionFilter();
			var circle:Circle = new Circle(30,new Vec2(0,0),Material.steel(),filter);
			bd.shapes.push(circle);
			bd.space = _world;
			bd.cbTypes.add(_steelType); 
			var skin:Sprite = new Sprite();
			skin.graphics.beginFill(0x000000,.5);
			skin.graphics.drawCircle(0,0,30);
			skin.graphics.endFill();
			addChild(skin);
			bd.userData.graphic = skin;
			_randBds.push(bd);
		}
			
		private function loop(event:Event):void
		{
			//Nape空间模拟
			_world.step(1/50,30,30);
			//清除视图
			_debug.clear();
			//绘制空间
			_debug.draw(_world);
			//优化显示视图
			_debug.flush();
			fillColor();
			fluid.update();
			updateBdForce();
		}
		
		private function updateBdForce():void {
			var skin:Sprite;
			for each(var bd:Body in _randBds){
				bd.applyImpulse(new Vec2(0,2000));
				skin = bd.userData.graphic;
				if(skin){
					skin.x = bd.position.x;
					skin.y = bd.position.y;
				}
			}
		}
		
		private function fillColor():void {
			this.graphics.clear();
			this.graphics.beginFill(0x0000ff,.5);
			this.graphics.moveTo(20,700);
			for(var i:int=0 ; i<fluid.bodyList.length ; i++){
				var pos:Vec2 = fluid.bodyList.at(i).position;
				this.graphics.lineTo(pos.x,pos.y);
			}
			this.graphics.lineTo(Practice.instance.width-20,700);
			this.graphics.lineTo(20,700);
			this.graphics.endFill();
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
		
		private function createBodies():void {
//			_circleBody = new Body();
//			var shape:Circle = new Circle(5,new Vec2(0,0),Material.rubber());
//			_circleBody.shapes.push(shape);
//			_circleBody.space = _world;
//			_circleBody.position.setxy(500,100);
//			var skin:Sprite = new Sprite();
//			skin.graphics.beginFill(0x00000,.5);
//			skin.graphics.drawCircle(0,0,5);
//			skin.graphics.endFill();
//			this.addChild(skin);
//			_circleBody.userData.graphic = skin;
//			
//			_circleBody1 = new Body();
//			shape = new Circle(5,new Vec2(0,0),Material.rubber());
//			_circleBody1.shapes.push(shape);
//			_circleBody1.space = _world;
//			_circleBody1.position.setxy(500,450);
//			var skin1:Sprite = new Sprite();
//			skin1.graphics.beginFill(0x00000,.5);
//			skin1.graphics.drawCircle(0,0,5);
//			skin1.graphics.endFill();
//			this.addChild(skin1);
//			_circleBody1.userData.graphic = skin1;
			
//			rope = new RopeJoint(this,_world,10,300);
			//rope.active = true;
			//dildo = new Dildo(this,_world);
			
		}
		
		public var mousePivot:PivotJoint;
		private function createMouseJoint() : void {
			var body1:Body = _world.world;
			mousePivot = new PivotJoint(
				body1,
				null,
				Vec2.weak(mouseX,mouseY),
				Vec2.weak(0,0));
			mousePivot.stiff = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN , mouseEventHanlder);
			this.addEventListener(MouseEvent.MOUSE_MOVE , mouseEventHanlder);
			this.addEventListener(MouseEvent.MOUSE_UP , mouseEventHanlder);
		}
		protected function mouseEventHanlder(event : MouseEvent) : void {
			switch (event.type){
				case MouseEvent.MOUSE_DOWN:
					var body:Body = getBodyAtMouse();
					if (body!=null){
						mousePivot.active = true;
						mousePivot.body2 = body;
						mousePivot.anchor1.setxy(mouseX, mouseY);
						mousePivot.anchor2=body.worldPointToLocal(Vec2.weak(mouseX,mouseY));
						mousePivot.space = _world;
						stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseEventHanlder);
					}
					break;
				case MouseEvent.MOUSE_UP:
					if(mousePivot!=null){
						mousePivot.active = false;
					}
					
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseEventHanlder);
					break;
				case MouseEvent.MOUSE_MOVE:
					mousePivot.anchor1.setxy(mouseX, mouseY);
					break;
			}
		}
		public function getBodyAtMouse():Body{
			var bodyPressed:Body;
			var mouseVec2:Vec2=new Vec2(stage.mouseX, stage.mouseY);
			
			var bodiesUnderMouse:BodyList;
			bodiesUnderMouse = _world.bodiesUnderPoint(mouseVec2);
			bodiesUnderMouse.foreach(function(body:Body):void{
				bodyPressed= body;
			});
			return bodyPressed;
		}
	}
}


