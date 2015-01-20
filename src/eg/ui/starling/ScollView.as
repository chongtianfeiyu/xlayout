package eg.ui.starling
{
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.text.TextField;
	// 因为clipRect，必须用Sprite
	public class ScollView extends Sprite
	{
		public function ScollView(w:int,h:int,maxChild:int = 20)
		{
			super();
			this.w = w; this.h = h;
			this.maxChild = maxChild;
			this.clipRect = new Rectangle(0,0,w,h);
		}
		public var w:int;
		public var h:int;
		private var currentY:int = 0;
		private var childs:Array = [];
		private var maxChild:int;
		override public function dispose():void{
			var display:DisplayObject;
			while(childs.length > 0){
				display = childs.pop();
				this.removeChild(display);
				display.dispose();
			}
			super.dispose();
		}
		public function addText(text:TextField,offsetY:int = 0):void{
			childs.push(text);
			this.addChild(text);
			// 更新当前Y
			currentY += text.height;
			fixShow();
		}
		private function fixShow():void{
			var baseY:int = h;
			var display:DisplayObject;
			var noFixBaseY:int = 0;
			var needFix:Boolean = false;
			for(var j:int = 0;j < childs.length;j++)
			{
				display = childs[j];
				display.y = noFixBaseY;
				noFixBaseY += display.height;
				if(noFixBaseY > baseY) {
					needFix = true;
					break;
				}
			}
			
			if(needFix)
			{
				for(var i:int = childs.length - 1;i>=0;i--)
				{
					display = childs[i];
					display.y = baseY - display.height;
					baseY = display.y;
					if(baseY < -display.height) break;
					//trace("x:"+display.x+",y:"+display.y+",str:"+(display as TextField).text);
				}
				var delIndex:int = 0;
				while(delIndex <= i && i >= 0){
					display = childs[i];
					this.removeChild(display);
					display.dispose();
					delIndex++;
				}
				if(delIndex > 0)	childs.splice(0,delIndex);
			}
		}
	}
}