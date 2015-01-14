package xlayoutPanel
{
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.controls.Radio;
	import feathers.controls.ToggleButton;
	import feathers.core.FeathersControl;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	import xlayoutSubUI.LabelPickList;
	import xlayoutSubUI.LabelSlider;
	import xlayoutSubUI.LabelTextInput;
	import xlayoutSubUI.TreeItem;
	import xlayoutSubUI.UI;
	import xlayoutSubUI.XDragPanel;
	import xlayoutSubUI.XDragSprite;

	public class XPanelTreeSel extends XDragPanel
	{
		private var m2:Panel;

		private var dic1:Dictionary;
		private var dic2:Dictionary;

		private var mode1:LabelPickList;
		private var mode2:LabelPickList;

		private var m1:Panel;
		public static var one:XPanelTreeSel;

		private var pngShower:XPngShower;

		private var pngDir:LabelTextInput;
		private var bgDir:LabelTextInput;

		private var pngFilter:LabelTextInput;

		private var res:AssetManager;
		private var atlasNow:TextureAtlas;

		private var btn_sml:ToggleButton;

		private var btn_remove:Button;

		private var btn_addToStage:Button;

		private var btn_xml:Button;

		private var bg:XDragSprite;

		public var alpha_slider:LabelSlider;

		private var radio1:Radio;

		private var radio2:Radio;
		public function XPanelTreeSel(titleStr:String,limit:Rectangle=null)
		{
			one = this;
			super(titleStr,limit);
			this.setSize(320,370);
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 0;
			layout.gap = 1;
			this.layout = layout;
			res = new AssetManager();
			setTimeout(update,1333);
		}
		public function sel(ob:DisplayObject):void{
			var f:FeathersControl = ob as FeathersControl;
			if(!f){
				XPanelLayout.one.visible = false;
			}else{
				XPanelLayout.one.visible = true;
			}
			for (var i:int = 0; i < this.numChildren; i++){
				var o:TreeItem = this.getChildAt(i) as TreeItem;
				if(o.ob!=ob){
					o.bt.isSelected = false;
				}else{
					o.bt.isSelected = true;
				}
			}
		}
		public function update():void
		{
			removeChildren(0,-1,true);
			var sectionWidth:int = 302;
			var ctrlWidth:int = 250;
			var ctrlHeight:int = 22;
			var mid:int = 40;
			var me:XPanelTreeSel = this;
			function redrawOneBtn(ob:UI,deep):void{
				var item:TreeItem = new TreeItem(me,ob as DisplayObject,deep-3,200,25);
			}
			function searchDisplayObjectContainer(p:DisplayObjectContainer,deep=0):void{
				deep++;
				if(p is UI){
					redrawOneBtn(p as UI,deep);
				}
				if(p is DisplayObjectContainer){
					for (var i:int = 0; i < p.numChildren; i++){
						var sub:DisplayObjectContainer = p.getChildAt(i) as DisplayObjectContainer;
						if(sub) searchDisplayObjectContainer(sub,deep);
					}
				}
			}
			searchDisplayObjectContainer(stage);
			sel(XBox.lastSelObject);
		}
	}
}