package conponents
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class PageIndicator extends Sprite
	{
		private var _pages:int=0;
		private var _currentPage:int=0;
		private var _prevPage:int=0;
		private var _indicators:Array=[];
		private static const interval:int=20;
		
		public function PageIndicator(num:int=0)
		{
			super();
			_pages = num;
			_currentPage = 1;
			_prevPage = 1;
			initPageIndicators();
		}
		
		private function initPageIndicators():void {
			for(var i:int=0 ; i<_pages ; i++){
				var indicator:Shape = new Shape();
				indicator.graphics.beginFill(0xffffff,1);
				indicator.graphics.drawCircle(-5,-5,10);
				indicator.graphics.endFill();
				if(i==0){
					indicator.alpha = 1;
				}else{
					indicator.alpha = .3;
				}
				this.addChild(indicator);
				indicator.x = _indicators.length*(indicator.width + interval);
				trace(indicator.x);
				_indicators.push(indicator);
			}
		}
		
		public function updatePage(newPage:int):void {
			if(newPage>_pages||newPage<0){
				return;
			}
			_currentPage = newPage;
			_indicators[_prevPage-1].alpha = .3;
			_indicators[_currentPage-1].alpha = 1;
			_prevPage = _currentPage;
			trace("page count : " + _currentPage);
		}
		
		public  function dispose():void {
			if(_indicators){
				_indicators.splice(0,_indicators.length);
				_indicators = null;
			}
			if(this.numChildren>0){
				this.removeChildren(0,this.numChildren-1);
			}
		}
	}
}