package nape{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import nape.constraint.ConstraintList;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.phys.Compound;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	/**
	 * @author yangfei
	 */
	public class RopeJoint{
		private var _space:Space;

		private var segmentNum : uint;
		private var segmentHeight : Number = 10;
		private var segmentWidth : Number = 4;
		
		private var startPoint : Vec2;
		private var bodyList : BodyList;
		private var jointList : ConstraintList;
		private var _container:Sprite;
		
		public function RopeJoint(container:Sprite,world:Space,segmentSize:Number=10, ropeLenth:Number=100) {
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
		private var v1:Vec2;
		private var v2:Vec2;
		private function init():void{
			startPoint = new Vec2(0,0);
			var skin:Sprite;
			for(var i:int = 0; i<segmentNum; i++){
				px = startPoint.x + 500;
				py = startPoint.y + i*segmentHeight - 100;
				if(i==segmentNum-1){
					segment = new Body(BodyType.STATIC);
				}else{
					segment = new Body(BodyType.DYNAMIC);
				}
				var box:Polygon=new Polygon(Polygon.box(segmentWidth, segmentHeight),Material.steel());
				segment.shapes.push(box);
				segment.shapes.at(0).sensorEnabled = true;
				skin = new Sprite();
				skin.graphics.beginFill(0x000000,.5);
				skin.graphics.drawRect(-2,-5,4,10);
				skin.graphics.endFill();
				_container.addChild(skin);
				segment.userData.graphic = skin;
				segment.space = _space;
				segment.position.setxy(px,py);
				bodyList.push(segment);
			}
			for(i=0 ; i<segmentNum-1 ; i++){
				v1 = new Vec2(0,-segmentHeight/2);
				v2 = new Vec2(0,segmentHeight/2);
				joint = new PivotJoint(bodyList.at(i),bodyList.at(i+1),v1,v2);
				joint.space = _space;
				joint.active = true;
				joint.ignore = false;
				joint.stiff = true;
				jointList.push(joint);
			}
		}
	
		public function update():void{
			for (var i:int = 0; i < bodyList.length; i++) {
				//2.遍历这个BodyList对象，并通过BodyList.at(index)方法获取每个刚体的引用，同时获取贴图对象引用
				var body:Body = bodyList.at(i);
				var graphic:Sprite = body.userData.graphic;
				//3.用刚体的坐标和角度更新贴图的属性，实时更新贴图
				graphic.x = body.position.x;
				graphic.y = body.position.y;
				graphic.rotation = (body.rotation * 180 / Math.PI) % 360;
			}
		}
	}
}