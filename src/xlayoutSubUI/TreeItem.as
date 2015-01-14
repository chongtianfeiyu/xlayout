package xlayoutSubUI
{
	import flash.utils.getQualifiedClassName;
	
	import feathers.controls.ToggleButton;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class TreeItem extends LayoutGroupListItemRenderer
	{

		public var ob:DisplayObject;
		public var bt:ToggleButton;
		public function TreeItem(p:DisplayObjectContainer,ob:DisplayObject,deep:int,w:int,h:int)
		{
			super();
			this.ob = ob;
			p.addChild(this);
			var pad:Number = deep*20;
			setSize(w+pad,h);
			layout = new AnchorLayout();
			var className:String = flash.utils.getQualifiedClassName(ob);
			if(className.indexOf("::")>=0) className = className.split("::").pop();
			bt = new ToggleButton();
			bt.setSize(w,h);
			bt.label = ob.name+" : "+className;
			var d:AnchorLayoutData = new AnchorLayoutData();
			d.left = pad;
			bt.layoutData = d;
			addChild(bt);
			bt.addEventListener(TouchEvent.TOUCH,onChange);
		}
		
		private function onChange(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(bt,TouchPhase.ENDED);
			if(t){
				bt.isSelected = true;
				G.SkipEvent = true;
				G.showAttr(ob);
				G.showLayoutAttr(ob);
			}
		}
		
		override public function dispose():void
		{
			ob = null;
			super.dispose();
		}
		override protected function initialize():void
		{
			super.initialize();
			
		}
	}
}