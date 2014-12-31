package nape
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import nape.constraint.ConstraintList;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	public class Dildo extends Sprite
	{
		private var _space:Space;
		private var _container:Sprite;
		
		public function Dildo(container:Sprite,space:Space)
		{
			super();
			_container = container;
			_space = space;
			setBody();
			setJoint();
		}
		
		public function update():void
		{
			// TODO Auto-generated method stub
			for(var i:int=0 ; i<_bodies.length ; i++){
				var bd:Body = _bodies.at(i);
				var skin:Sprite = bd.userData.graphic;
				skin.x = bd.position.x;
				skin.y = bd.position.y;
				skin.rotation = (bd.rotation * 180 / Math.PI) % 360;
			}
		}
		
		private var _bodies:BodyList = new BodyList();
		private function setBody():void {
			for(var i:int=0 ; i<5 ; i++){
				var bd:Body = new Body(BodyType.DYNAMIC , new Vec2(500,300+i*20));
				_bodies.push(bd);
				bd.mass = .02;
				var shape:Polygon = new Polygon(Polygon.rect(-5,-10,10,20),Material.wood());
				bd.shapes.push(shape);
				var skin:Sprite = new Sprite();
				skin.graphics.beginFill(0x999922);
				skin.graphics.drawRect(-5,-10,10,20);
				skin.graphics.endFill();
				skin.x = bd.position.x;
				skin.y = bd.position.y;
				_container.addChild(skin);
				bd.userData.graphic = skin;
				bd.space = _space;
				if(i==4){
					bd.type = BodyType.STATIC;
				}
			}
		}
		
		private var _joints:ConstraintList = new ConstraintList();
		private function setJoint():void {
			for(var i:int=0 ; i<_bodies.length-1 ; i++){
				var bd1:Body = _bodies.at(i);
				var bd2:Body = _bodies.at(i+1);
				var lv1:Vec2 = Vec2.weak(-5,10);
				var lv2:Vec2 = Vec2.weak(-5,-10);
				var rv1:Vec2 = Vec2.weak(5,10);
				var rv2:Vec2 = Vec2.weak(5,-10);
				var leftJoint:PivotJoint = new PivotJoint(bd1,bd2,lv1,lv2);
				var rightJoint:PivotJoint = new PivotJoint(bd1,bd2,rv1,rv2);
				leftJoint.damping = 80;
				leftJoint.frequency = 100;
				leftJoint.stiff = false;
				leftJoint.space = _space;
				rightJoint.damping = 80;
				rightJoint.frequency = 100;
				rightJoint.stiff = false;
				rightJoint.space = _space;
				_joints.push(leftJoint);
				_joints.push(rightJoint);
			}
		}
	}
}