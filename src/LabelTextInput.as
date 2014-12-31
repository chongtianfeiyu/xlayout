package
{
	import flash.net.SharedObject;
	
	import feathers.controls.TextInput;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class LabelTextInput extends LayoutGroupListItemRenderer
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


		public function LabelTextInput(p:DisplayObjectContainer,w:int,h:int,mid:int,labelStr:String)
		{
			super();
			this.h = h;
			this.w = w;
			this.labelStr = labelStr;
			this.mid = mid;
			saveTxt = SO(labelStr);
			textInput = new TextInput();
			p.addChild(this);
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
			textInput.layoutData = a2;
			textInput.setSize(w-mid,h);
			if(saveTxt) textInput.text = saveTxt;
			addChild(textInput);
			
			label = new TextField(mid,h,labelStr,"微软雅黑",Math.round(h*.55),0xaaaaaa);
			label.hAlign = HAlign.RIGHT;
			label.text = labelStr;
			label.x = 0;
			label.y = 0;
			addChild(label);
			
			textInput.addEventListener(FeathersEventType.FOCUS_OUT,onFocusOut);
		}
		private function onFocusOut(e:*):void
		{
			SO(labelStr,textInput.text);
		}
	}
}