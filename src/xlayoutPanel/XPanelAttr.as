package xlayoutPanel
{
	import flash.geom.Rectangle;
	import feathers.layout.VerticalLayout;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import xlayoutSubUI.XDragPanel;
	public class XPanelAttr extends XDragPanel
	{
		public static var one:XPanelAttr;
		private var pngShower:XPicShower;
		private var res:AssetManager;
		private var atlasNow:TextureAtlas;
		public function XPanelAttr(titleStr:String,limit:Rectangle=null)
		{
			one = this;
			super(titleStr,limit);
			this.setSize(320,170);
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 0;
			layout.gap = 1;
			this.layout = layout;
			
			res = new AssetManager();
			
			var sectionWidth:int = 302;
			var ctrlWidth:int = 250;
			var ctrlHeight:int = 22;
			var mid:int = 40;
			
			
		}
		
		public function showAttr(arr:Array):void
		{
			removeChildren(0,-1,true);
			for (var i:int = 0; i < arr.length; i++){
				addChild(arr[i]);
			}
			autoHeight(this);
		}
	}
}