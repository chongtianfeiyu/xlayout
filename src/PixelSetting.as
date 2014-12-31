package
{
	
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Panel;
	import feathers.core.IFeathersControl;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class PixelSetting extends XDragPanel
	{
		private var m2:Panel;

		private var dic1:Dictionary;
		private var dic2:Dictionary;

		private var mode1:LabelPickList;
		private var mode2:LabelPickList;

		private var m1:Panel;
		public static var one:PixelSetting;

		private var pngShower:XPngShower;

		private var pngDir:LabelTextInput;

		private var pngFilter:LabelTextInput;

		private var res:AssetManager;
		private var atlasNow:TextureAtlas;
		public function PixelSetting(titleStr:String,limit:Rectangle=null)
		{
			one = this;
			super(titleStr,limit);
			//verticalScrollPolicy = Panel.SCROLL_POLICY_OFF;
			this.setSize(320,630);
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 0;
			layout.gap = 1;
			this.layout = layout;
			
			res = new AssetManager();
			
			var sectionWidth:int = 302;
			var ctrlWidth:int = 250;
			var ctrlHeight:int = 22;
			var mid:int = 40;
			
			dic1 = new Dictionary();
			dic2 = new Dictionary();
			m1 = newSection(this,"贴图路径设置",false);
			m1.setSize(sectionWidth,100);
			
			pngDir = new LabelTextInput(m1,ctrlWidth,ctrlHeight,mid,"路径");
			pngDir.textInput.addEventListener(Event.CHANGE,loadTexture);
			
			pngFilter = new LabelTextInput(m1,ctrlWidth,ctrlHeight,mid,"过滤");
			pngFilter.textInput.addEventListener(Event.CHANGE,showAtlas);
			
			
			var m3:Panel = newSection(this,"命令");
				m3.setSize(sectionWidth,120);
			
			var addToStage_btn:Button = new Button();
			addToStage_btn.label="添加到场景";
			addToStage_btn.addEventListener(Event.TRIGGERED,addPngToStage);
			m3.addChild(addToStage_btn);
			
			var remove_btn:Button = new Button();
			remove_btn.label="从场景移除";
			remove_btn.addEventListener(Event.TRIGGERED,remove);
			m3.addChild(remove_btn);
			
			var xml_btn:Button = new Button();
			xml_btn.label="导出XML";
			xml_btn.addEventListener(Event.TRIGGERED,xml);
			m3.addChild(xml_btn);
				
			pngShower = new XPngShower("图片选择"); this.addChild(pngShower);
			pngShower.setSize(302,360);
			
		}
		private function xml(e:*):void
		{
			var r:XLayoutGroup = XLayoutGroup.rootBox;
			var xmlstr:String = search(r);
			trace(xmlstr);
			function search(s:ToXML,deep:int=0):String{
				var str:String = "";
				var ss:XLayoutGroup = s as XLayoutGroup;
				if(ss){
					for (var i:int = 0; i < ss.numChildren; i++){
						var c:ToXML = ss.getChildAt(i) as ToXML;
						if(c){
							str += search(c,deep);
						}
					}
				}else{
					var d:String = "";
					for (var j:int = 0; j < deep; j++){
						d+="\t";
					}
					
					var tmp:String = d+s.toXML();
					str += tmp;
				}
				++deep;
				return str;
			}
		}
		private function remove(e:*):void
		{
			if(XBox.lastSelObject){
				XBox.lastSelObject.removeFromParent(true);
				XBox.remove(XBox.lastSelObject);
				XBox.lastSelObject = null;
			}
		}
		private function addPngToStage(e:*):void
		{
			for (var i:int = 0; i < pngShower.numChildren; i++){
				var img:XImg = pngShower.getChildAt(i) as XImg;
				if(img.hasSel)addOnePngToStage(img);
			}
		}
		
		private function addOnePngToStage(img:XImg):void
		{
			if(img){
				img.sel(false);
				var drag:XDragSprite = new XImgToXML(img);
				drag.x = int(100+Math.random()*100);
				drag.y = int(100+Math.random()*100);
				drag.dragEndFunction = dragEndFunction;
				XLayoutGroup.rootBox.addChild(drag);
			}
		}
		private function dragEndFunction(drag:XDragSprite):void
		{
			XBox.draw(drag);
			XBox.sel(drag,true);
		}
		private function loadTexture(e:*):void
		{
			var png:String = pngDir.textInput.text;
			var xml:String = png.replace(".png",".xml");
			var f:File = new File(png);
			if(!f.exists){
				return;
			}
			var f2:File = new File(xml);
			if(!f2.exists){
				return;
			}
			var fileName:String = f.name.replace(".png","");
			if(png==""){
				Alert.show("PngUrl必须填写","提示", new ListCollection([ { label: "OK" }])); return;
			}
			res.enqueue(xml);
			res.enqueue(png);
			res.loadQueue(function(r:Number):void{
				if(r==1){
					var a:TextureAtlas = res.getTextureAtlas(fileName);
					atlasNow = a;
					showAtlas();
				}
			});
		}
		private function showAtlas():void
		{
			if(!atlasNow){
				return;
			}
			pngShower.removeChildren(0,-1,true);
			var nam:Vector.<String> = new Vector.<String>;
			atlasNow.getNames("",nam);
			var f:String = pngFilter.textInput.text;
			for (var i:int = 0; i < nam.length; i++) {
				if(f!=""){
					if(nam[i].indexOf(f)<0) continue;
				}
				var n:String = nam[i];
				var t:Texture = atlasNow.getTexture(n);
				var frame:Rectangle = atlasNow.getFrame(n);
				var r:Rectangle = atlasNow.getRegion(n);
				if(frame==null){
					frame = new Rectangle();
					frame.width = r.width;
					frame.height = r.height;
				}
				var rot:Boolean = atlasNow.getRotation(n);
				var xImg:XImg = new XImg(t,nam[i],frame,r,80,rot);
				xImg.addEventListener(XImg.DOUBLE_CLICK,onDClick);
				pngShower.addChild(xImg);
			}
			pngShower.validate();
		}
		
		private function onDClick(e:Event):void
		{
			var img:XImg = e.data as XImg;
			if(img){
				addOnePngToStage(img);
			}
		}
		private function newSection(f:DisplayObjectContainer,titleStr:String="",rowLayout:Boolean=true):Panel
		{
			var p:Panel = new Panel();
			p.headerProperties.title = titleStr;
			p.headerProperties.alpha = 0.5;
			p.headerFactory = function():IFeathersControl
			{
			    var backButton:Button = new Button(); backButton.width = 44;
			    backButton.label = "clear";
			    backButton.addEventListener( Event.TRIGGERED, clearButton );
				    var header:Header = new Header();
			    header.rightItems = new <DisplayObject>
			    [
				        backButton
				];
			    return header;
			};
			if(rowLayout){
				var v:TiledRowsLayout = new TiledRowsLayout();
				v.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
				v.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
				v.verticalGap = 0;
				v.horizontalGap = 0;
				v.padding = 1;
				v.gap = 1;
				v.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
				v.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;
				v.useSquareTiles = false;
				p.layout = v;
			}else{
				var vv:VerticalLayout = new VerticalLayout();
				p.verticalScrollPolicy = Panel.SCROLL_POLICY_OFF;
				vv.padding = 1;
				vv.gap = 1;
				vv.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
				vv.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
				p.layout = vv;
			}
			f.addChild(p);
			return p;
		}
		
		private function clearButton(e:Event):void
		{
			var p:Panel = (e.target as Button).parent.parent as Panel;
			var ob:DisplayObject;
			for (var i:int = 0; i < p.numChildren; i++){
				ob = p.getChildAt(i);
				var txt:LabelTextInput = ob as LabelTextInput;
				if(txt) txt.textInput.text = "";
			}
			for (var j:int = 0; j < p.numChildren; j++){
				ob = p.getChildAt(j);
				var list:LabelPickList = ob as LabelPickList;
				if(list) list.pickList.selectedIndex = 0;
			}
		}
	}
}