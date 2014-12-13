package conponents
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class ExpProgressBar extends Sprite
	{
		private static const BARWIDTH:int = 200;
		private static const expArr:Array = [10,50,100,200,400,600,800,1200,1600,2000];
		private var _curLv:int=0;
		private var increasedExp:int;
		private var _levelUpExp:int;
		private var _curExp:int=0;
		private var _ratio:Number;
		
		private var _mask:Shape;
		private var _bar:Sprite;
		private var _bg:Shape;
		private var _lvTf:TextField;
		private var _tf:TextFormat;
		
		public function ExpProgressBar()
		{
			super();
			_mask = new Shape();
			_bg  = new Shape();
			_bar = new Sprite();
			
			_mask.graphics.beginFill(0xffffff,1);
			_mask.graphics.drawRect(0,0,BARWIDTH,10);
			_mask.graphics.endFill();
			_bg.graphics.beginFill(0x000000,.5);
			_bg.graphics.drawRect(0,-40,BARWIDTH,50);
			_bg.graphics.endFill();
			_bar.graphics.beginFill(0x00ff00,1);
			_bar.graphics.drawRect(0,0,BARWIDTH,10);
			_bar.graphics.endFill();
			_bar.mask = _mask;
			
			this.addChild(_bg);
			this.addChild(_bar);
			this.addChild(_mask);
			_bar.x = -BARWIDTH;
			
			_tf = new TextFormat("Arial",25,0x000000);
			_lvTf = new TextField();
			_lvTf.width = 50;
			_lvTf.height = 30;
			_lvTf.text = "lv."+_curLv;
			_lvTf.setTextFormat(_tf);
			
			this.addChild(_lvTf);
			_lvTf.y = -40;
		}
		
		public function  setCurLvAndExp(lv:int,exp:int):void {
			_curLv = lv;
			increasedExp = exp;
			doExpProgress();
		}
		
		private function doExpProgress():void {
			if(_curLv>=expArr.length-1){//满级
				_bar.graphics.beginFill(0xff0000,1);
				_bar.graphics.drawRect(0,0,BARWIDTH,10);
				_bar.graphics.endFill();
				return;
			}
			
			_levelUpExp = expArr[_curLv];//设定本级升级经验
			_bar.x = (_curExp/_levelUpExp-1)*BARWIDTH;//设定本级经验条初始位置
			if(increasedExp<=0)return;
			if(increasedExp-_levelUpExp+_curExp>0){//当前级经验加满
				increasedExp -= _levelUpExp-_curExp;
				_ratio = 1;
				_curExp = 0;
				_curLv++;
				_lvTf.text = "lv."+_curLv;
				_lvTf.setTextFormat(_tf);
			}else{//当前级经验加不满
				_curExp += increasedExp;
				_ratio = _curExp/_levelUpExp;
				increasedExp = 0;
			}
			
			TweenMax.to(_bar,.5,{x:(_ratio-1)*BARWIDTH,ease:Expo.easeOut,onComplete:doExpProgress});
		}
		
		public function resetProgressBar():void {
			TweenMax.killTweensOf(_bar);
			_bar.x = -_bar.width;
		}
		
		public function dispose():void {
			if(this.numChildren>0){
				this.removeChildren(0,this.numChildren-1);
			}
			_mask = null;
			_bg = null;
			_bar = null;
		}
		
		public function testControl(parent:Sprite):void {
			var inputExpTf:TextField = new TextField();
			var tf:TextFormat = new TextFormat("Arial",25,0x000000);
			inputExpTf.width = 150;
			inputExpTf.height = 50;
			inputExpTf.background = true;
			inputExpTf.backgroundColor=0xffffff;
			inputExpTf.border = true;
			inputExpTf.borderColor=0x000000;
			inputExpTf.type = TextFieldType.INPUT;
			inputExpTf.multiline = false;
			inputExpTf.setTextFormat(tf);
			
			parent.addChild(inputExpTf);
			inputExpTf.x = 50;
			inputExpTf.y = 50;
			
			var confirmBtn:Sprite = new Sprite();
			confirmBtn.graphics.beginFill(0x555555,1);
			confirmBtn.graphics.drawRect(0,0,50,30);
			confirmBtn.addEventListener(MouseEvent.CLICK , function onConfirm(event:MouseEvent):void
			{
				// TODO Auto-generated method stub
				setCurLvAndExp(_curLv,int(inputExpTf.text));
			});
			parent.addChild(confirmBtn);
			confirmBtn.x = 200;
			confirmBtn.y = 50;
		}
	}
}