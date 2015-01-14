package xlayoutSubUI
{
	import flash.net.SharedObject;
	
	import feathers.controls.PickerList;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class LabelPickList extends LayoutGroupListItemRenderer
	{

		public var label:TextField;
		public var pickList:PickerList;
		
		/**Label和Input的分界线X坐标（中间线）**/
		private var mid:int;
		/**Label和Input相加的宽度**/
		private var w:int;
		private var h:int;
		private var defaultTxt:String;
		private var saveTxt:String;
		private var labelStr:String;
		private var arr:Array;
		private var f:Function;
		public function LabelPickList(p:DisplayObjectContainer,w:int,h:int,mid:int,labelStr:String,arr:Array,f:Function=null)
		{
			super();
			this.f = f;
			this.arr = arr;
			this.h = h;
			this.w = w;
			this.labelStr = labelStr;
			this.mid = mid;
			pickList = new PickerList();
			pickList.dataProvider = new ListCollection(arr);
			if(p)p.addChild(this);
			pickList.addEventListener(Event.CHANGE,function(e:*):void{
				if(G.SkipEvent) return;
				if(f) f(pickList.selectedItem);
			})
		}
		override protected function initialize():void
		{
			super.initialize();
			layout = new AnchorLayout();
			
			var a2:AnchorLayoutData = new AnchorLayoutData();
			a2.left = mid;
			a2.verticalCenter = 0;
			pickList.layoutData = a2;
			pickList.setSize(w-mid,h);
			addChild(pickList);
			
			label = new TextField(mid,h,labelStr,"微软雅黑",Math.round(h*.55),0xaaaaaa);
			label.hAlign = HAlign.RIGHT;
			label.text = labelStr;
			label.x = 0;
			label.y = 0;
			addChild(label);
		}
	}
}