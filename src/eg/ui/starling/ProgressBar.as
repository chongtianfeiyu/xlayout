package eg.ui.starling
{
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ProgressBar extends DisplayObjectContainer
	{
		public function ProgressBar(barTex:Texture,backTex:Texture,showType:int = 0,
											font:String = "黑体",fontSize:int = 30,fontColor:uint = 0x000000)
		{
			super();
			init(barTex,backTex,font,fontSize,fontColor);
			this.showType = showType;
		}
		public static var ShowNo:int = 0;
		public static var ShowNumber:int = 1;
		public static var ShowPercent:int = 2;
		
		private var showType:int;
		private var back:Image = null;
		private var bar:Image = null;
		private var barContain:Sprite = new Sprite();
		private var text:TextField = null;
		private var _percent:Number = 0;
		
		public function set percent(p:Number):void{
			_percent = p;
			if(_percent > 1)	_percent = 1;
			if(_percent <= 0)	_percent = 0;
			var w:int = _percent * bar.texture.width;
			barContain.clipRect = new Rectangle(0,0,w,	bar.height);
		}
		public function get percent():Number{
			return _percent;
		}
		override public function dispose():void{
			if(back) back.dispose();
			if(bar) bar.dispose();
			if(text) text.dispose();
			super.dispose();
		}
		private function init(barTex:Texture,backTex:Texture,font:String,fontSize:int,fontColor:uint):void{
			if(backTex)
			{
				back = new Image(backTex);
				this.addChild(back);
			}
			else
			{
				trace("[Error]ProgressBar mis backTex");
				return;
			}
			
			if(barTex)
			{
				bar = new Image(barTex);
				this.addChild(barContain);
				barContain.addChild(bar);
			}
			else
			{
				trace("[Error]ProgressBar mis barTex");
				return;
			}
			
			barContain.x = int((back.texture.width - bar.texture.width)*0.5);
			barContain.y = int((back.texture.height - bar.texture.height)*0.5);
			
			if(showType != ShowNo)
			{
				text = new TextField(back.width,back.height,"",font,fontSize,fontColor);
				text.hAlign = HAlign.CENTER;
				text.vAlign = VAlign.CENTER;
			}
		}
	}
}