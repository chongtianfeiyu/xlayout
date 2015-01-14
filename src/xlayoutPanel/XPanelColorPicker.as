package xlayoutPanel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.controls.TextInput;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	import xlayoutSubUI.LabelTextInput;
	import xlayoutSubUI.XDragPanel;

	public class XPanelColorPicker extends XDragPanel
	{
		public static var one:XPanelColorPicker;
		private var res:AssetManager;
		private var atlasNow:TextureAtlas;
		[Embed(source = "../pickcolor.png")]
		private static var Pic_Class:Class;

		private var bd:BitmapData;

		private var bg:Image;

		private var o:Image;

		private var container:Sprite;

		private var ppp:Point = new Point();
		private var picking:Boolean;
		public function XPanelColorPicker(titleStr:String,limit:Rectangle=null)
		{
			one = this;
			super(titleStr,limit);
			this.setSize(452,305);
			container = new Sprite();
			addChild(container);
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 0;
			layout.gap = 1;
			this.layout = layout;
			res = new AssetManager();
			
			bd = (new Pic_Class() as Bitmap).bitmapData;
			var t:Texture = Texture.fromBitmapData(bd);
			bg = new Image(t);
			bg.addEventListener(TouchEvent.TOUCH,onT);
			container.addChild(bg);
			
			o = new Image(XLayoutEditor.theme.atlas.getTexture("focus-indicator-skin"));
			o.pivotX = 5;
			o.pivotY = 5;
			o.x = 5;
			o.y = 5;
			o.touchable = false;
			container.addChild(o);
			
			var sectionWidth:int = 302;
			var ctrlWidth:int = 250;
			var ctrlHeight:int = 22;
			var mid:int = 40;
		}
		
		private function onT(e:TouchEvent):void{
			var t:Touch;
			t = null;
			t = e.getTouch(bg,TouchPhase.BEGAN);
			if(t){
				picking = true;
			}
			t = null;
			t = e.getTouch(bg,TouchPhase.MOVED);
			if(t && picking){
				t.getLocation(bg,ppp);
				changeColor();
			}
			t = null;
			t = e.getTouch(bg,TouchPhase.ENDED);
			if(t){
				picking = false;
				t.getLocation(bg,ppp);
				changeColor();
			}
		}
		
		private function changeColor():void{
			if(LabelTextInput.lastSel){
				if(LabelTextInput.lastSel.type == LabelTextInput.TYPE_COLOR){
					o.x = ppp.x;
					o.y = ppp.y;
					var c:String = bd.getPixel(ppp.x,ppp.y).toString(16);
					if(o.x<0) o.x = 0;
					if(o.y<0) o.y = 0;
					if(o.y>bd.height) o.y = bd.height;
					if(o.x>bd.width) o.x = bd.width;
					LabelTextInput.lastSel.textInput.text = c;
				}
			}
		}
		
		public function show(t:TextInput):void{
			var p:Point = t.localToGlobal(new Point(0,t.height+3));
			this.x = p.x;
			this.y = p.y;
			this.visible = true;
			this.parent.addChild(this);
		}
		
		public function hide():void{
			this.visible = false;
		}
	}
}