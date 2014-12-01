package conponents
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class RotationController extends EventDispatcher
	{
		
		private var _orbit:EllipseOrbit;
		public function RotationController(orbit:EllipseOrbit,target:IEventDispatcher=null)
		{
			super(target);
			_orbit = orbit;
			
			Practice.stage.addEventListener
				(MouseEvent.MOUSE_DOWN , mouseDownHandler);
		}
		
		/******************
		 * motion part
		 * ***************/
		private var _originalX:int;
		private var _downX:Number=0;
		private var _targetX:Number=0;
		private var _scrollX:Number=0;
		private var _deltaMove:Number=0;
		private var _mouseX:Number=0;
		private var _lastMouseX:Number=0;
		private var _ease:Number = .4;
		private var _isMouseDown:Boolean = false;
		private var _isMouseUp:Boolean = false;
		
		protected function mouseDownHandler(event:MouseEvent):void {
			_isMouseDown = true;
			_isMouseUp = false;
			_ease = .1;
			_downX = Practice.stage.mouseX;
			_originalX = _orbit.container.x;
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
		
		protected function onDrag(event:Event):void
		{
			// TODO Auto-generated method stub
			_deltaMove = (_targetX-_scrollX)*_ease;
			_scrollX += _deltaMove;
			_orbit.degree = _deltaMove;
			if(!_isMouseDown&&_isMouseUp){
				if(Math.abs(_scrollX-_targetX)<1){
					Practice.stage.removeEventListener
						(Event.ENTER_FRAME,onDrag);
				}
			}
		}
	}
}