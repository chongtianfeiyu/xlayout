package
{
	import flash.geom.Point;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import xlayoutSubUI.LabelTextInput;
	
	public class Resizer extends Sprite
	{
		private var mover:Image;
		private var dragging:Boolean;
		private var pos:Point = new Point();
		private var me:Resizer;
		private var ww:LabelTextInput;
		private var hh:LabelTextInput;
		public function Resizer(p:DisplayObjectContainer,w:int,h:int)
		{
			x = w;
			y = h;
			mover = new Image(XLayoutEditor.theme.atlas.getTexture("focus-indicator-skin"));
			addChild(mover);
			addEventListener(TouchEvent.TOUCH,onT);
			p.addChild(this);
			me = this;
			function setWH(key:String,val:String,isNumber:Boolean):void
			{
				if(val=="") return;
				if(key=="w:")me.x = parseFloat(val);
				if(key=="h:")me.y = parseFloat(val);
				me.dispatchEventWith("改变尺寸",false,{x:x,y:y});
			}
			ww = new LabelTextInput(this,200,20,18,"w:",setWH,false);
			hh = new LabelTextInput(this,200,20,18,"h:",setWH,false);
			var gao:int = 25;
			ww.y = gao;
			hh.y = gao*2;
		}
		
		private function onT(e:TouchEvent):void{
			var t:Touch = e.getTouch(this);
			if(t==null) return;
			if(t.phase == TouchPhase.BEGAN){
				dragging = true;
			}
			if(t.phase == TouchPhase.MOVED){
				if(dragging && parent){
					t.getMovement(parent,pos);
					ww.textInput.text = int(x + pos.x)+"";
					hh.textInput.text = int(y + pos.y)+"";
				}
			}
			if(t.phase == TouchPhase.ENDED){
				dragging = false;
			}
		}
	}
}