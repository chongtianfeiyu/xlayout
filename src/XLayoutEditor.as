package
{
	
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import feathers.controls.Panel;
	import feathers.layout.AnchorLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	import xlayoutPanel.XBox;
	import xlayoutPanel.XPanelAttr;
	import xlayoutPanel.XPanelBgSetting;
	import xlayoutPanel.XPanelColorPicker;
	import xlayoutPanel.XPanelCtrl;
	import xlayoutPanel.XPanelLayout;
	import xlayoutPanel.XPanelPicSel;
	import xlayoutPanel.XPanelTreeSel;
	
	import xlayoutSubUI.XLayoutGroup;
	
	public class XLayoutEditor extends Sprite
	{
		private var p:Panel;

		public static var theme:MetalWorksDesktopTheme;

		public static var layer0:Sprite;

		public static var layer1:Sprite;

		public function XLayoutEditor()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		private function onAdd(e:*):void
		{
			theme = new MetalWorksDesktopTheme();
			
			var ui:XLayoutGroup = new XLayoutGroup(this,true);
			ui.name="uiRoot";
			
			var d1:HorizontalLayoutData = new HorizontalLayoutData();
			d1.percentWidth = 100;
			d1.percentHeight = 100;
			ui.layoutData = d1;
			
			//var layout:AnchorLayout = new AnchorLayout();
			//ui.layout = layout;
			
			layer0 = new Sprite(); addChild(layer0);
			layer1 = new Sprite(); addChild(layer1);
			
			var x1:XPanelPicSel = new XPanelPicSel("图库",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			x1.x = 560; 
			x1.y = 120;
			layer1.addChild(x1);
			
			var x0:XPanelLayout = new XPanelLayout("布局",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			x0.x = 620; 
			x0.y = 510;
			layer1.addChild(x0);
			
			var x2:XPanelBgSetting = new XPanelBgSetting("参考背景",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			x2.x = 360;
			x2.y = 320;
			layer1.addChild(x2);
			
			var x3:XPanelTreeSel = new XPanelTreeSel("选择",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			x3.x = 160;
			x3.y = 520;
			layer1.addChild(x3);
			
			var x4:XPanelAttr = new XPanelAttr("属性",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			x4.x = 360;
			x4.y = 420;
			layer1.addChild(x4);
			
			var x5:XPanelColorPicker = new XPanelColorPicker("颜色",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			x5.x = 530;
			x5.y = 220;
			layer1.addChild(x5);
			
			var x6:XPanelCtrl = new XPanelCtrl("控件",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			x6.x = 530;
			x6.y = 220;
			layer1.addChild(x6);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
		}
		protected function stage_keyDownHandler(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.TAB)
			{
				var v:Boolean = layer0.visible;
				layer0.visible = !v;
				layer1.visible = !v;
				XBox.container.visible = !v;
				return;
			}
			if(e.keyCode == Keyboard.UP)
			{
				moveOB(0,-1);
				return;
			}
			if(e.keyCode == Keyboard.DOWN)
			{
				moveOB(0,1);
				return;
			}
			if(e.keyCode == Keyboard.LEFT)
			{
				moveOB(-1,0);
				return;
			}
			if(e.keyCode == Keyboard.RIGHT)
			{
				moveOB(1,0);
				return;
			}
		}
		
		private function moveOB(xx:int, yy:int):void
		{
			var ob:DisplayObjectContainer = XBox.lastSelObject;
			if(ob && ob.stage){
				if(ob is XLayoutGroup){
					if((ob as XLayoutGroup).isRoot) return;
				}
				ob.x += xx;
				ob.y += yy;
				XBox.draw(ob);
			}
		}
	}
}