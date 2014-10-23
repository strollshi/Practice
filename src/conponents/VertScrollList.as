package conponents
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import items.VertScrollItem;
	
	public class VertScrollList extends EventDispatcher
	{
		public function VertScrollList(parent:DisplayObjectContainer,renderHeight:int,zeroY:Number,interval:int,items:Array,target:IEventDispatcher=null)
		{
			super(target);
			_parent = parent;
			init(renderHeight,zeroY,interval);
			setItems(items);
			initScrollBar();
			Practice.stage.addEventListener(MouseEvent.MOUSE_DOWN , onMouseDown);
			
			layout();
		}
		
		private function layout():void
		{
			// TODO Auto Generated method stub
			_parent.addChild(_container);
			_parent.addChild(_mask);
			_container.x = (Practice.stage.stageWidth-_container.width)*.5;
			_container.y = _zeroY;
			_mask.x = _container.x;
			_mask.y = _zeroY;
			
			_parent.addChild(_bar);
			_bar.x = _container.width+_container.x + BAR_INTERVAL;
			_bar.y = _container.y;
		}
		
		private var _parent:DisplayObjectContainer;
		private var _container:Sprite;
		private var _interval:int;
		private var _zeroY:Number;
		private var _mouseY:Number;
		private var _lastMouseY:Number;
		private var _deltaMove:Number;
		private var _downY:Number;
		private var _targetScrollY:Number;
		private var _scrollY:Number;
		private var _renderHeight:int;
		private var _mask:Shape;
		private var _upValue:int;
		private var _downValue:int;
		
		public function get container():Sprite {
			return _container;
		}
		
		private function init(renderHeight:int,zeroY:Number,interval:int):void {
			_container = new Sprite();
			_zeroY = zeroY;
			_interval = interval;
			_renderHeight = renderHeight;
			_targetScrollY = _container.y;
			_scrollY = _container.y;
		}
		
		private var _items:Array=[];
		private var h:int;
		private function setItems(ary:Array):void {
			for(var i:int=0 ; i<ary.length ; i++){
				var item:VertScrollItem = new VertScrollItem();
				item.data = ary[i];
				if(i==0){
					item.selected();
				}else{
					item.unselected();
				}
				_items.push(item);
				_container.addChild(item);
				item.addEventListener
					(Event.SELECT,onSelectItem,false,0,true);
				item.x = 0;
				item.y = i*(_interval+item.height);
				h = item.height;
			}
			
			_mask = new Shape();
			_mask.graphics.beginFill(0,1);
			_mask.graphics.drawRect(0,0,_container.width,_renderHeight);
			_container.mask = _mask;
			_container.addEventListener(MouseEvent.CLICK , onClickContainer);
			trace(h);
			_upValue = _zeroY+h;
			_downValue = _zeroY+_renderHeight-h;
		}
		
		protected function onClickContainer(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(Math.abs(_targetScrollY)<5){
				var index:int = int(_container.mouseY/(h+_interval));
				_items[index].dispatchEvent(new Event(Event.SELECT));
			}
		}
		
		protected function onSelectItem(event:Event):void
		{
			var item:VertScrollItem = event.target as VertScrollItem;
			function checkItem(scrollItem:VertScrollItem,index:int,ary:Array):void{
				if(scrollItem==item){
					scrollItem.selected();
				}else{
					scrollItem.unselected();
				}
			}
			_items.forEach(checkItem);
			
		}
		
		protected function updateAlpha():void {
			if(_items.length==0)return;
			for(var i:int=0 ; i<_items.length ; i++){
				var item:VertScrollItem = _items[i];
				
			}
		}
		
		protected function onMouseDown(evt:MouseEvent):void {
			
			if(Practice.stage.mouseX<_mask.x||Practice.stage.mouseY<_mask.y||Practice.stage.mouseX>_mask.x+_mask.width||Practice.stage.mouseY>_mask.y+_mask.height)
				return;
			
			_downY = Practice.stage.mouseY;
			_mouseY = _downY;
			_lastMouseY = _downY;

			Practice.stage.addEventListener
				(MouseEvent.MOUSE_MOVE , onMouseMove);
			Practice.stage.addEventListener
				(MouseEvent.MOUSE_UP , onMouseUp);
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			Practice.stage.removeEventListener
				(MouseEvent.MOUSE_MOVE , onMouseMove);
			Practice.stage.removeEventListener
				(MouseEvent.MOUSE_UP , onMouseUp);
			
			if(_container.y>_zeroY){
				_targetScrollY = _zeroY;
			}else if(_container.y<_zeroY-_container.height+_renderHeight){
				_targetScrollY = _zeroY-_container.height+_renderHeight;
			}
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//_deltY = _mouseY-event.target.mouseY;
			_mouseY = Practice.stage.mouseY;
			_deltaMove = _mouseY-_lastMouseY;
			_targetScrollY += _deltaMove;
			_lastMouseY = _mouseY;
			
			if(!_container.hasEventListener(Event.ENTER_FRAME)){
				_container.addEventListener
					(Event.ENTER_FRAME,onDrag);
			}
		}
		
		protected function onDrag(event:Event):void
		{
			// TODO Auto-generated method stub
			_deltaMove = (_targetScrollY-_scrollY)*.4;
			_scrollY += _deltaMove;
			_container.y = _scrollY
			updateAlpha();
			scrollBar();
			if(Math.abs(_container.y-_targetScrollY)<1){
				_container.removeEventListener
					(Event.ENTER_FRAME,onDrag);
			}
		}
		
		
		/******
		 * scroll bar controller
		 * ***/
		
		private var _bar:Sprite;
		private var _totalScrollHeight:int;
		private var _localScrollHeight:int;
		private var _barHeight:int;
		private static const BAR_WIDTH:int=10;
		private static const BAR_INTERVAL:int=10;
		private function initScrollBar():void {
			_bar = new Sprite();
			_totalScrollHeight = _container.height;
			_localScrollHeight = _renderHeight;
			_barHeight = _renderHeight*_localScrollHeight/_totalScrollHeight;
			if(_barHeight>_renderHeight){
				_barHeight = _renderHeight;
			}
			with(_bar.graphics){
				beginFill(0xffffff,.5);
				drawRect(0,0,BAR_WIDTH,_barHeight);
				endFill();
			}
		}
		
		private function scrollBar():void {
			if(_container.y>_zeroY){
				_bar.height = _barHeight*Math.abs
					(_zeroY+_renderHeight-_container.y)
					/_localScrollHeight;
				_bar.y = _zeroY;
			}else if(_container.y<_zeroY-_container.height+_renderHeight){
				_bar.height = _barHeight*Math.abs
					(_zeroY-_container.y-_container.height)
					/_localScrollHeight;
				_bar.y = _zeroY+_renderHeight-_bar.height;
			}else {
				//_bar.y = _zeroY+_renderHeight*()/_localScrollHeight;
				_barHeight = _renderHeight*_localScrollHeight/_totalScrollHeight;
				if(_barHeight>_renderHeight){
					_barHeight = _renderHeight;
				}
				_bar.height = _barHeight;
				if(_deltaMove>0){
					_bar.y -= _deltaMove*Math.abs(_renderHeight-_barHeight)
						/Math.abs(_container.height-_renderHeight);//往上走
				}else{
					_bar.y -= _deltaMove*Math.abs(_renderHeight-_barHeight)
						/Math.abs(_container.height-_renderHeight);//往下走
				}
			}
		}
	}
}