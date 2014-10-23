package items
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import MP3Player.MP3ResManager;
	
	public class VertScrollItem extends Sprite
	{
		public function VertScrollItem()
		{
			super();
			initUI();
		}
		
		private var _skin:Shape;
		private var _tf1:TextField;
		private var _tf2:TextField;
		private var tf1:TextFormat;
		private var tf2:TextFormat;
		private static const WIDTH:int = 400;
		private static const HEIGHT:int = 100;
		
		private var _data:Object;
		public function set data(value:Object):void {
			_data = value;
			if(value.soundName.length>20){
				_tf1.text = String(value.soundName).substr(0,20)+"...";
			}else{
				_tf1.text = value.soundName;
			}
			
			_tf1.setTextFormat(tf1);
		}
		
		private function initUI():void {
			if(!_skin)_skin = new Shape();
			_skin.graphics.beginFill(0xffffff,.5);
			_skin.graphics.drawRect(0,0,WIDTH,HEIGHT);
			_skin.graphics.endFill();
			addChild(_skin);
			
			_tf1 = new TextField();
			_tf2 = new TextField();
			tf1 = new TextFormat("Microsoft YaHei",15,0xffffff);
			tf2 = new TextFormat("Microsoft YaHei",15,0xffffff);
			_tf1.selectable = false;
			_tf2.selectable = false;
			_tf1.autoSize = TextFieldAutoSize.LEFT;
			_tf2.autoSize = TextFieldAutoSize.LEFT;
			addChild(_tf1);
			addChild(_tf2);
			_tf1.x = 15;
			_tf1.y = 30;
			_tf2.x = _skin.width-100;
			_tf2.y = 30;
		}
		
		public function selected():void {
			this.alpha = 1;
			MP3ResManager.instance.playSound(_data);
		}
		
		public function unselected():void {
			this.alpha = .5;
		}
	}
}