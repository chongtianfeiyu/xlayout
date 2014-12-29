package
{
	import com.github.moketao.xlayout.LayoutGroupBox;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.layout.AnchorLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LayoutTest extends Sprite
	{
		private var p:Panel;

		public var tool:LayoutSetting;
		public function LayoutTest()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		private function onAdd(e:*):void
		{
			var theme:MetalWorksDesktopTheme = new MetalWorksDesktopTheme();
			
			var ui:LayoutGroupBox = new LayoutGroupBox(this,true);
			ui.name="uiRoot";
			
			var d1:HorizontalLayoutData = new HorizontalLayoutData();
			d1.percentWidth = 100;
			d1.percentHeight = 100;
			ui.layoutData = d1;
			
			var layout:AnchorLayout = new AnchorLayout();
			ui.layout = layout;
			
			tool = new LayoutSetting("布局面板",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			tool.x = tool.y = 3;
			stage.addChild(tool);
		}
		
	}
}