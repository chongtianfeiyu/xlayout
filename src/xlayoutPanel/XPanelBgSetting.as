package xlayoutPanel
{
	
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Radio;
	import feathers.controls.ToggleButton;
	import feathers.core.ToggleGroup;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	import xlayoutSubUI.LabelPickList;
	import xlayoutSubUI.LabelSlider;
	import xlayoutSubUI.LabelTextInput;
	import xlayoutSubUI.XDragPanel;
	import xlayoutSubUI.XDragSprite;

	public class XPanelBgSetting extends XDragPanel
	{
		private var m2:Panel;

		private var dic1:Dictionary;
		private var dic2:Dictionary;

		private var mode1:LabelPickList;
		private var mode2:LabelPickList;

		private var m1:Panel;
		public static var one:XPanelBgSetting;

		private var pngShower:XPicShower;

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
		public function XPanelBgSetting(titleStr:String,limit:Rectangle=null)
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
			
			bgDir = new LabelTextInput(this,ctrlWidth,ctrlHeight,mid,"图片",loadBg,true,LabelTextInput.TYPE_TXT);
			alpha_slider = new LabelSlider(this,ctrlWidth,ctrlHeight,mid,"透明",0,1,0.01,slider_changeHandler,1);
			
			var canSel:Label = new Label();
			canSel.text = "\n可选或不可选";
			addChild(canSel);
			
			var group:ToggleGroup = new ToggleGroup();
			group.addEventListener( Event.CHANGE, group_changeHandler );
			
			radio1 = new Radio();
			radio1.label = "可选";
			radio1.toggleGroup = group;
			addChild( radio1 );
			
			radio2 = new Radio();
			radio2.label = "不可选";
			radio2.toggleGroup = group;
			addChild( radio2 );
			
			loadBg("",bgDir.textInput.text,false);
		}
		
		private function group_changeHandler():void
		{
			if(bg) bg.touchable = radio1.isSelected;
		}
		
		private function slider_changeHandler(b:Number):void
		{
			if(bg){
				bg.alpha = b;
			}
		}
		private function loadBg(key:String,txt:String,isNumber:Boolean):void
		{
			var bgdir:String = txt;
			if(bgdir=="")return;
			try{
				var f:File = new File(bgdir);
				if(!f.exists)return;
			}catch(error:Error){
				return;
			}
			if(f.isDirectory)return;
			var fname:String = f.name.replace(".png","").replace(".jpg","");
			res.enqueue(bgdir);
			res.loadQueue(function(b:Number):void{
				if(b==1){
					var t:Texture = res.getTexture(fname);
					var bbb:Image = new Image(t);
					bg = new XDragSprite(bbb,true,true,new Rectangle(0,0,9999,9999));
					XLayoutEditor.layer0.removeChildren(0,-1,true);
					XLayoutEditor.layer0.addChildAt(bg,0);
					radio2.isSelected = true;
					bg.alpha = alpha_slider.value;
				}
			});
		}
	}
}