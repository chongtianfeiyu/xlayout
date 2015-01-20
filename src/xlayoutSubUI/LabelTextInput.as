package xlayoutSubUI
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import feathers.controls.TextInput;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import xlayoutPanel.XBox;
	import xlayoutPanel.XPanelAttr;
	import xlayoutPanel.XPanelColorPicker;
	
	public class LabelTextInput extends LayoutGroupListItemRenderer implements IDrog
	{

		public var label:TextField;
		public var textInput:TextInput;
		
		/**Label和Input的分界线X坐标（中间线）**/
		private var mid:int;
		/**Label和Input相加的宽度**/
		private var w:int;
		private var h:int;
		private var saveTxt:String;
		private var labelStr:String;

		private var f:Function;

		private var save:Boolean;

		public var type:int;
		public static const TYPE_NUMBER:int = 1;
		public static const TYPE_TXT:int = 0;
		public static const TYPE_COLOR:int = 2;
		public static const TYPE_TXT_TEXTURE:int = 3;
		
		public static var lastSel:LabelTextInput;
		public var dragD:Point = new Point();
		private var lableDragging:Boolean;
		public var min:Number=-9999999;
		public var max:Number=9999999;
		
		public function LabelTextInput(p:DisplayObjectContainer,w:int,h:int,mid:int,labelStr:String,f:Function=null,save:Boolean=false,type:int=TYPE_NUMBER)
		{
			super();
			this.type = type;
			this.save = save;
			this.f = f;
			this.h = h;
			this.w = w;
			this.labelStr = labelStr;
			this.mid = mid;
			textInput = new TextInput();
			if(save)saveTxt = SO(labelStr);
			if(saveTxt) textInput.text = saveTxt;
			if(p)p.addChild(this);
		}
		public static function SO(key:String, val:*=null):*
		{
			var so:SharedObject = SharedObject.getLocal("xlayout");
			if(val!=null) so.data[key] = val;
			return so.data[key];
		}
		public function doDrog(ob:*):void
		{
			textInput.text = ob.name;
		}
		public function containsDrog(xx:int,yy:int):Boolean
		{
			var p:Point = this.localToGlobal(new Point())
			var r:Rectangle = new Rectangle(p.x,p.y,this.w,this.h);
			return r.contains(xx,yy);
		}
		override protected function initialize():void
		{
			super.initialize();
			layout = new AnchorLayout();
			
			var a2:AnchorLayoutData = new AnchorLayoutData();
			a2.left = mid;
			a2.verticalCenter = 0;
			textInput.layoutData = a2;
			textInput.setSize(w-mid,h);
			addChild(textInput);
			
			label = new TextField(mid,h,labelStr,"微软雅黑",Math.round(h*.55),0xaaaaaa);
			label.hAlign = HAlign.RIGHT;
			label.text = labelStr;
			label.x = 0;
			label.y = 0;
			if(type == TYPE_TXT_TEXTURE){
				G.dropTargets.push(this);
			}
			if(type==TYPE_NUMBER)label.addEventListener(TouchEvent.TOUCH,onLabelDrag);
			addChild(label);
			
			textInput.addEventListener(FeathersEventType.FOCUS_OUT,onFocusOut);
			textInput.addEventListener(FeathersEventType.FOCUS_IN,onFocusIn);
			textInput.addEventListener(Event.CHANGE,onChange);
		}
		public override function dispose():void{
			var index:int = G.dropTargets.indexOf(this);
			if(index>=0) G.dropTargets.splice(index,1);
			super.dispose();
		}
		private function onLabelDrag(e:TouchEvent):void{
			var t:Touch;
			t = null;
			t = e.getTouch(label,TouchPhase.BEGAN);
			if(t){
				lableDragging = true;
			}
			t = null;
			t = e.getTouch(label,TouchPhase.MOVED);
			if(t && lableDragging ){
				var step:Number = step;
				var n:Number = parseFloat(textInput.text);
				step = n>1?   1 : 0.01;
				t.getMovement(this,dragD);
				if(Math.abs(dragD.x)>Math.abs(dragD.y)){
					if(dragD.x<0) step*=-1;
				}else{
					if(dragD.y>0) step*=-1;
				}
				var out:Number = n + step;
				if(out>max) out = max;
				if(out<min) out = min;
				textInput.text = out.toFixed(3);
			}
			t = null;
			t = e.getTouch(label,TouchPhase.ENDED);
			if(t){
				lableDragging = false;
			}
		}
		
		private function onChange():void
		{
			if(f) f(labelStr,textInput.text,type);
			if(type == TYPE_COLOR){
				setColor();
			}
			if(!(this.parent.parent is XPanelAttr)) return;
			var b:XBase = XBox.lastSelObject as XBase;
			if(!b) return;
			if(type == TYPE_NUMBER){
				b[labelStr] = parseFloat(textInput.text); return;
			}
			if(type == TYPE_TXT || type == TYPE_TXT_TEXTURE ){
				b[labelStr] = textInput.text; return;
			}
		}
		public function setColor():void{
			var txt:EgTxt = XBox.lastSelObject as EgTxt;
			if(txt){
				var tmp:String = textInput.text;
				if(tmp.indexOf("0x")!=0) tmp="0x"+tmp;
				txt.color = tmp;
			}
		}
		private function onFocusIn(e:*):void
		{
			lastSel = this;
			if(type == TYPE_COLOR){
				XPanelColorPicker.one.show(textInput);
			}else{
				XPanelColorPicker.one.hide();
			}
		}
		private function onFocusOut(e:*):void
		{
			Mouse.cursor = MouseCursor.AUTO;
			if(labelStr,textInput.text!="" && save)SO(labelStr,textInput.text);
		}
	}
}