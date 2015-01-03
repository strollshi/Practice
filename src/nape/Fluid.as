package nape
{
	import flash.display.Sprite;
	
	import nape.constraint.ConstraintList;
	import nape.constraint.PivotJoint;
	import nape.dynamics.InteractionFilter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Edge;
	import nape.shape.Polygon;
	import nape.space.Space;

	public class Fluid extends Sprite
	{
		private var _space:Space;
		
		private var segmentNum : uint;
		private var segmentHeight : Number = 4;
		private var segmentWidth : Number = 10;
		
		private var startPoint : Vec2;
		public var bodyList : BodyList;
		private var jointList : ConstraintList;
		private var _container:Sprite;
		private var _boxes:Array = [];

		public function Fluid(container:Sprite,world:Space,segmentSize:Number=10, ropeLenth:Number=400)
		{
			_container = container;
			_space = world;
			segmentHeight=segmentSize;
			segmentNum = Math.ceil(ropeLenth/ segmentHeight);
			
			bodyList = new BodyList();
			jointList = new ConstraintList();
			
			init();
		}
		private var px : Number;
		private var py : Number;
		private var joint : PivotJoint;
		private var segment : Body;
		private var upV1:Vec2;
		private var upV2:Vec2;
		private var downV1:Vec2;
		private var downV2:Vec2;
		
		private function init():void{
			startPoint = new Vec2(0,300);
			var skin:Sprite;
			for(var i:int = 0; i<segmentNum; i++){
				px = startPoint.x + 20 + i*segmentWidth;
				py = startPoint.y;
				if(i==segmentNum-1||i==0){
					segment = new Body(BodyType.STATIC);
				}else{
					segment = new Body(BodyType.DYNAMIC);
				}
				var box:Polygon=new Polygon(Polygon.box(segmentWidth, segmentHeight),Material.wood());
				segment.shapes.push(box);
				segment.userData.graphic = skin;
				segment.space = _space; 
				segment.position.setxy(px,py);
				bodyList.push(segment);
				_boxes.push(box);
			}
			for(i=0 ; i<segmentNum-1 ; i++){
				upV1 = new Vec2(-segmentWidth/2,segmentHeight/2);
				upV2 = new Vec2(segmentWidth/2,segmentHeight/2);
				downV1 = new Vec2(-segmentWidth/2,-segmentHeight/2);
				downV2 = new Vec2(segmentWidth/2,-segmentHeight/2);
				upJoint = new PivotJoint(bodyList.at(i),bodyList.at(i+1),upV1,upV2);
				downJoint = new PivotJoint(bodyList.at(i),bodyList.at(i+1),downV1,downV2);
				
				
				
				var upJoint:PivotJoint;
				upJoint.space = _space;
				upJoint.active = true;
				upJoint.ignore = true;
				upJoint.stiff = true;
				upJoint.frequency = 50;
				upJoint.damping = 0;
				jointList.push(upJoint);
				var downJoint:PivotJoint;
				downJoint.space = _space;
				downJoint.active = true;
				downJoint.ignore = true;
				downJoint.stiff = true;
				downJoint.frequency = 50;
				downJoint.damping = 0;
				jointList.push(downJoint);
			}
		}
		
		public function update():void{
			var force:Number = 0;
			for (var i:int = 0; i < bodyList.length; i++) {
				//2.遍历这个BodyList对象，并通过BodyList.at(index)方法获取每个刚体的引用，同时获取贴图对象引用
				var body:Body = bodyList.at(i);
				var edge:Edge = _boxes[i].edges.at(0);
				force = Math.random()>.5?-Math.random()*.3:Math.random()*.3;
				body.applyImpulse(edge.worldNormal.mul(force,true),body.position,false);
			}
		}
	}
}