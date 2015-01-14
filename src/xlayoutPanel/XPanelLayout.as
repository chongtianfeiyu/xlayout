package xlayoutPanel
{
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	
	import xlayoutSubUI.XDragPanel;
	import xlayoutSubUI.XLayoutGroup;

	public class XPanelLayout extends XDragPanel
	{
		private var add_btn:Button;
		private var del_btn:Button;
		private var m2:Panel;
		private var m1:Panel;
		public static var one:XPanelLayout;
		public function XPanelLayout(titleStr:String,limit:Rectangle=null)
		{
			one = this;
			super(titleStr,limit);
			verticalScrollPolicy = Panel.SCROLL_POLICY_OFF;
			this.setSize(320,580);
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 0;
			layout.gap = 1;
			this.layout = layout;
			
			var w:int = 302;
			
			m1 = newSection(this,"自身布局属性",false);
			m1.setSize(w,70);
			autoHeight(m1,this);
			
			
			m2 = newSection(this,"子对象布局设置",false);
			m2.width = w;
			m2.height = 270;
			autoHeight(m2,this);
			
			var m3:Panel = newSection(this,"命令");
				m3.setSize(w,70);
				
				
			add_btn = new Button();
			add_btn.label="添加布局";
			add_btn.addEventListener(Event.TRIGGERED,addLayout);
			m3.addChild(add_btn);
			
			del_btn = new Button();
			del_btn.label="删除布局";
			del_btn.addEventListener(Event.TRIGGERED,removeLayout);
			m3.addChild(del_btn);
		}
		private function addLayout():void
		{
			var p:LayoutGroup = XBox.lastSelObject as LayoutGroup;
			if(p){
				var sub:XLayoutGroup = new XLayoutGroup(p);
				update();
				setTimeout(function():void{
					G.SkipEvent = true;
					G.showLayoutAttr(sub);
				},55);
			}else{
				Alert.show("选择的对象"+XBox.lastSelObject+"不是LayoutGroup，\n不能在此对象中添加布局，\n请在Panel、ScrollContainer或者LayoutGroup中\n添加布局","提示", new ListCollection([ { label: "OK" }]))
			}
		}
		
		public function update():void
		{
			XPanelTreeSel.one.update();
			XBox.draw(XBox.lastSelObject);
		}
		
		private function removeLayout():void
		{
			var x:XLayoutGroup = XBox.lastSelObject as XLayoutGroup;
			if(!x) return;
			if(x.isRoot){
				XAlert.show("root层不能被remove");
				return;
			}
			XBox.remove(x);
		}
		
		public function showAttrSelf(arr:Array):void
		{
			m1.removeChildren(0,-1,true);
			for (var i:int = 0; i < arr.length; i++){
				m1.addChild(arr[i]);
			}
			autoHeight(m1,this);
		}
		
		public function showAttrSub(arr:Array):void
		{
			m2.removeChildren(0,-1,true);
			for (var i:int = 0; i < arr.length; i++){
				m2.addChild(arr[i]);
			}
			autoHeight(m2,this,77);
		}
	}
}