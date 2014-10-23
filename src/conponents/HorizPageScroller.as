package conponents
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import items.HorizScrollItem;
	
	public class HorizPageScroller extends Sprite
	{
		private var _parent:DisplayObjectContainer;
		private var _datas:Array;
		private var _pages:Vector.<HorizScrollItem>;
		private var _pageContainer:Sprite;
		private var _originalX:int;
		private var interval:int;
		private var _pageIndicator:PageIndicator;

		
		public function HorizPageScroller(parent:DisplayObjectContainer,datas:Array)
		{
			super();
			_parent = parent;
			_datas = datas;
			initPages();
			
			Practice.stage.addEventListener
				(MouseEvent.MOUSE_DOWN , mouseDownHandler);
		}
		
		private function initPages():void
		{
			// TODO Auto Generated method stub
			if(_pageContainer)return;
			interval = Practice.stage.stageWidth-HorizScrollItem.WIDTH;
			_pageContainer = new Sprite();
			_pages = new Vector.<HorizScrollItem>;
			
			for(var i:int=0;i<_datas.length;i++){
				var page:HorizScrollItem = new HorizScrollItem();
				page.data = _datas[i];
				_pageContainer.addChild(page);
				_pages.push(page);
				page.x = i*(interval+HorizScrollItem.WIDTH);
				page.relativeX = page.x;
			}
			
			_parent.addChild(_pageContainer);
			_originalX = interval*.5;
			_pageContainer.x = _originalX;
			_scrollX = _originalX;
			_pageContainer.y = (Practice.stage.stageHeight-HorizScrollItem.HEIGHT)*.5;
			
			_pageIndicator = new PageIndicator(_pages.length);
			_parent.addChild(_pageIndicator);
			_pageIndicator.x = (1024-_pageIndicator.width)*.5;
			_pageIndicator.y = 640 - _pageIndicator.height - 10;
			trace(_pageIndicator.x,_pageIndicator.y);
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
		private var _ease:Number = .4;
		private var _isMouseDown:Boolean = false;
		private var _isMouseUp:Boolean = false;
		
		protected function mouseDownHandler(event:MouseEvent):void {
			_isMouseDown = true;
			_isMouseUp = false;
			_ease = .5;
			_downX = Practice.stage.mouseX;
			_originalX = _pageContainer.x;
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
			pullBack();
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
			_pageContainer.x = _scrollX;
			if(!_isMouseDown&&_isMouseUp){
				if(Math.abs(_pageContainer.x-_targetX)<1){
					Practice.stage.removeEventListener
						(Event.ENTER_FRAME,onDrag);
				}
			}
		}
		
		protected function pullBack():void {
			var targetPage:int;
			if(_pageContainer.x>interval*.5){
				targetPage = 0;
			}else if(_pageContainer.x<
				-_pageContainer.width+interval*.5+HorizScrollItem.WIDTH){
				targetPage = _pages.length-1;
			}else{
				targetPage = Math.round(Math.abs(_pageContainer.x-interval*.5)
					/(interval+HorizScrollItem.WIDTH));
			}
			_targetX = 
				-targetPage*(interval+HorizScrollItem.WIDTH)+interval*.5;
			
			_pageIndicator.updatePage(targetPage+1);
		}
	}
}