package xlayoutSubUI
{
	import flash.net.SharedObject;
	
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class LabelSlider extends LayoutGroupListItemRenderer
	{

		public var label:TextField;
		public var slider:Slider;
		
		/**Label和Input的分界线X坐标（中间线）**/
		private var mid:int;
		/**Label和Input相加的宽度**/
		private var w:int;
		private var h:int;
		public var saveVal:Number;
		private var labelStr:String;

		private var f:Function;


		public function LabelSlider(p:DisplayObjectContainer,w:int,h:int,mid:int,labelStr:String,min:Number,max:Number,step:Number,f:Function,defaultVal:Number=1)
		{
			super();
			this.f = f;
			this.h = h;
			this.w = w;
			this.labelStr = labelStr;
			this.mid = mid;
			saveVal = SO(labelStr);
			slider = new Slider();
			slider.minimum = min;
			slider.maximum = max;
			slider.step = step;
			slider.value = defaultVal;
			slider.addEventListener( Event.CHANGE, slider_changeHandler );
			this.addChild( slider );
			p.addChild(this);
		}
		
		private function slider_changeHandler():void
		{
			if(f)f(slider.value);
		}
		public function get value():Number{
			return slider.value;
		}
		public static function SO(key:String, val:*=null):*
		{
			var so:SharedObject = SharedObject.getLocal("xlayout");
			if(val!=null) so.data[key] = val;
			return so.data[key];
		}
		override protected function initialize():void
		{
			super.initialize();
			layout = new AnchorLayout();
			
			var a2:AnchorLayoutData = new AnchorLayoutData();
			a2.left = mid;
			a2.verticalCenter = 0;
			slider.layoutData = a2;
			slider.setSize(w-mid,h);
			if(saveVal) slider.value = saveVal;
			addChild(slider);
			
			label = new TextField(mid,h,labelStr,"微软雅黑",Math.round(h*.55),0xaaaaaa);
			label.hAlign = HAlign.RIGHT;
			label.text = labelStr;
			label.x = 0;
			label.y = 0;
			addChild(label);
			
			slider.addEventListener(Event.CHANGE,onFocusOut);
		}
		private function onFocusOut(e:*):void
		{
			SO(labelStr,slider.value);
		}
	}
}