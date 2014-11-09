package MP4Player
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ConponentGenerator extends EventDispatcher
	{
		private static var _progressBar:Sprite;
		private static var _pauseBtn:Sprite;
		private static var _playBtn:Sprite;
		private static var _speedUpBtn:Sprite;
		private static var _speedDownBtn:Sprite;
		private static var _board:Sprite;
		
		private static var _isntance:ConponentGenerator;
		public static function instance():ConponentGenerator {
			return _isntance;
		}
		
		
		public function ConponentGenerator(target:IEventDispatcher=null)
		{
			super(target);
			_isntance = this;
		}
		
		private function generateProgressBar():void {
			_progressBar = new Sprite();
			var greenBar:Sprite = new Sprite();
			var mask:Sprite = new Sprite();
			greenBar.name = "progressBar";
			mask.name = "mask";
		}
		private function generatePauseBtn():void {
			_pauseBtn  = new Sprite();
		}
		private function generatePlayBtn():void {
			_playBtn = new Sprite();
		}
		private function generateSpeedUpBtn():void {
			_speedUpBtn = new Sprite();
		}
		private function generateSpeedDownBtn():void {
			_speedDownBtn = new Sprite(); 
		}
		private function generateBoard():void {
			_board = new Sprite();
		}
	}
}