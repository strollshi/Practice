package conponents
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import items.LaunchPadScrollItem;
	
	public class LaunchPadScrollList extends EventDispatcher
	{
		private var _parent:DisplayObjectContainer;
		private var _originalResource:Array;
		private var _items:Array=[];
		public function items():Array {
			return _items
		}
		
		private var _container:Sprite;
		public function get container():Sprite {
			return _container;
		}
		
		public function LaunchPadScrollList(parent:DisplayObjectContainer,items:Array,target:IEventDispatcher=null)
		{
			super(target);
			_parent = parent;
			_container = new Sprite();
			_parent.addChild(_container);
			_container.y = 300;
			_originalResource = items;
			initScrollItems();
			
			Practice.stage.addEventListener
				(MouseEvent.MOUSE_DOWN , mouseDownHandler);
		}
		
		private function initScrollItems():void {
			if(_originalResource.length==0)return;
			for(var i:int=0 ; i<_originalResource.length ; i++){
				var item:LaunchPadScrollItem = new LaunchPadScrollItem();
				item.data = _originalResource[i];
				_container.addChild(item);
				item.x = i*(item.width + 30);
				item.y = 0;
				_items.push(item);
			}
		}
		
		/******************
		 * motion part
		 * ***************/
		
		private var _downX:Number=0;
		private var _targetX:Number=0;
		private var _scrollX:Number=0;
		private var _deltaMove:Number=0;
		private var _mouseX:Number=0;
		private var _lastMouseX:Number=0;
		private var _ease:Number = .3;
		private var _isMouseDown:Boolean = false;
		private var _isMouseUp:Boolean = false;
		private var _originalX:int;
		private var interval:int;
		
		protected function mouseDownHandler(event:MouseEvent):void {
			_isMouseDown = true;
			_isMouseUp = false;
			_ease = .3;
			_downX = Practice.stage.mouseX;
			_originalX = _container.x;
			_mouseX = _downX;
			_lastMouseX = _downX;
			_targetX = _originalX;
			_scrollX = _originalX;
			
			Practice.stage.addEventListener
				(MouseEvent.MOUSE_MOVE , mouseMoveHandler);
			Practice.stage.addEventListener
				(MouseEvent.MOUSE_UP , mouseUpHandler);
			
			if(!Practice.stage.hasEventListener(Event.ENTER_FRAME)){
				Practice.stage.addEventListener
					(Event.ENTER_FRAME , onDrag);
			}
		}
		
		protected function onDrag(event:Event):void
		{
			// TODO Auto-generated method stub
			_deltaMove = (_targetX-_scrollX)*_ease;
			_scrollX += _deltaMove;
			_container.x = _scrollX;
			scaleItem();
			//trace(_container.x,_container.y);
			if(!_isMouseDown&&_isMouseUp){
				if(Math.abs(_container.x-_targetX)<1){
					Practice.stage.removeEventListener
						(Event.ENTER_FRAME,onDrag);
				}
			}
		}
		
		private function scaleItem():void {
			for(var i:int=0 ; i<_items.length ; i++){
				var item:LaunchPadScrollItem = _items[i];
				var absWidth:int = Math.abs(_container.x + item.x - Practice.stage.stageWidth*.5);
				if(absWidth>Practice.stage.stageWidth*.5){
					absWidth = Practice.stage.stageWidth*.5
				}
				var ratio:Number = 2-absWidth/(Practice.stage.stageWidth*.5);
				item.scaleX = ratio;
				item.scaleY = ratio;
			}
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			_isMouseDown = false;
			_isMouseUp = true;
			_ease = .3;
			// TODO Auto-generated method stub
			Practice.stage.removeEventListener
				(MouseEvent.MOUSE_MOVE , mouseMoveHandler);
			Practice.stage.removeEventListener
				(MouseEvent.MOUSE_UP , mouseUpHandler);
		}
		
		protected function mouseMoveHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			_mouseX = Practice.stage.mouseX;
			_deltaMove = _mouseX - _lastMouseX;
			_lastMouseX = _mouseX;
			_targetX += _deltaMove;
		}
	}
}