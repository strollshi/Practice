package conponents
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	import items.LaunchPadScrollItem;
	
	public class EllipseOrbit extends EventDispatcher
	{
		private var _container:Sprite = new Sprite();
		public function get container():Sprite {
			return _container;
		}
		private var _a:Number = 250;
		private var _b:Number = 80;
		public var degree:int=0;
		private var dg:Number;
		
		private var _items:Array = [];
		
		public function EllipseOrbit(target:IEventDispatcher=null)
		{
			super(target);
			init();
		}
		
		private function init():void {
			for(var i:int=0 ; i<10 ; i++){
				var item:LaunchPadScrollItem = new LaunchPadScrollItem();
				_items.push(item);
				dg = i*360/10;
				item.y = _b*Math.sin(Number(Math.PI*degree/180));
				item.x = _a*Math.cos(Number(Math.PI*degree/180));
				item.alpha = 1 - .5*Math.sin(Number(Math.PI*degree/180))
				item.scaleX=item.scaleY = 1 - .5*Math.sin(Number(Math.PI*degree/180));
				_container.addChild(item);
			}
		}
		
		private var x:Number=0;
		private var y:Number=0;
		public function update():void {
			for(var i:int=0 ; i<_items.length ; i++){
				var ss:Number = degree+dg*i;
				var item:LaunchPadScrollItem = _items[i];
				item.y = _b*Math.sin(Number(Math.PI*ss/180));
				item.x = _a*Math.cos(Number(Math.PI*ss/180));
				item.alpha = 1 + .5*Math.sin(Number(Math.PI*ss/180))
				item.scaleX=item.scaleY = 1 + .5*Math.sin(Number(Math.PI*ss/180));
			}
			//trace(_items[0].x,_items[0].y,_items[0].scaleX,_items[0].scaleY,_items[0].alpha);
		}
	}
}