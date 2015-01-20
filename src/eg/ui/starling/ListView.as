package eg.ui.starling
{
	import flash.geom.Rectangle;
	
	import eg.mgr.egLogicMgr;
	import eg.mgr.egRenderMgr;
	import eg.module.egResModule;
	import eg.module.egScriptModule;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	// 因为clipRect，必须用Sprite
	public class ListView extends Sprite
	{
		private var splitLineText:Texture;
		private var rightText:Texture;
		private var backText:Texture;
		private var lists:Array = [];
		private var funcs:Array = [];
		public var w:int;
		public var h:int;
		private var curY:int = 0;
		
		public function ListView(w:int,h:int)
		{
			super();
			this.w = w; this.h = h;
			this.clipRect = new Rectangle(0,0,w,h);
			setLineName("line");
			setRightName("right");
			setBackName("listback");
		}
		public function setBackName(name:String):void{
			var res:egResModule = egLogicMgr.get().getModule("res") as egResModule;
			backText = res.getTexByName(name);
		}
		public function setRightName(name:String):void{
			var res:egResModule = egLogicMgr.get().getModule("res") as egResModule;
			rightText = res.getTexByName(name);
		}
		public function setLineName(name:String):void{
			var res:egResModule = egLogicMgr.get().getModule("res") as egResModule;
			splitLineText = res.getTexByName(name);
		}
		public function addText(text:TextField,touchFunc:String):void{
			if(lists.length > 0 && splitLineText != null)
			{
				var line:Image = new Image(splitLineText);
				line.width = this.w;
				line.y = curY;
				line.touchable = false;
				curY += line.height;
				this.addChild(line);
			}
			var right:Image = new Image(rightText);
			var back:Image = new Image(backText);
			back.name = text.text;
			back.y = curY;
			back.width = this.w;
			back.height = right.height;
			back.addEventListener(TouchEvent.TOUCH,onTouch);
			text.y = curY + 10;
			text.touchable = false;
			this.addChild(back);
			this.addChild(text);
			if(touchFunc.length > 0)
			{
				right.x = this.w - right.width;
				right.y = curY;
				right.touchable = false;
				this.addChild(right);
			}
			curY += right.height;
			lists.push(back);
			funcs.push(touchFunc);
		}
		public function onTouch(e:TouchEvent):void{
			var touch:Touch = e.getTouch(this);
			if(touch && touch.phase == TouchPhase.ENDED)
			{
				for(var i:int = 0;i<lists.length;i++)
				{
					if(touch.isTouching(lists[i]) && funcs[i])
					{
						var script:egScriptModule = egLogicMgr.get().getModule("script") as egScriptModule;
						script.call(funcs[i],i);
						break;
					}
				}
			}
		}
	}
}