package
{
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Panel;
	import feathers.layout.AnchorLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LayoutTest extends Sprite
	{
		private var p:Panel;

		public static var theme:MetalWorksDesktopTheme;

		public function LayoutTest()
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
			
			var layout:AnchorLayout = new AnchorLayout();
			ui.layout = layout;
			
			var tool:PixelSetting = new PixelSetting("绝对值布局",new Rectangle(-200,-10,stage.stageWidth-10,stage.stageHeight-10));
			tool.x = 560; 
			tool.y = 120;
			stage.addChild(tool);
			
		}
		
	}
}