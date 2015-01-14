package xlayoutPanel
{
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	import xlayoutSubUI.EgTxt;
	import xlayoutSubUI.XDragPanel;
	import xlayoutSubUI.XDragSprite;
	import xlayoutSubUI.XImgToXML;
	import xlayoutSubUI.XLayoutGroup;

	public class XPanelCtrl extends XDragPanel
	{
		public static var one:XPanelCtrl;
		private var res:AssetManager;
		private var atlasNow:TextureAtlas;

		private var txtBtn:Button;
		public function XPanelCtrl(titleStr:String,limit:Rectangle=null)
		{
			one = this;
			super(titleStr,limit);
			this.setSize(452,305);
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 0;
			layout.gap = 1;
			this.layout = layout;
			res = new AssetManager();
			
			var sectionWidth:int = 302;
			var ctrlWidth:int = 250;
			var ctrlHeight:int = 22;
			var mid:int = 40;
			
			txtBtn = new Button();
			txtBtn.label = "txt";
			addChild(txtBtn);
			
			addEventListener(TouchEvent.TOUCH,onT);
		}
		
		private function onT(e:TouchEvent):void{
			var t:Touch = e.getTouch(this,TouchPhase.ENDED);
			if(t){
				if(t.isTouching(txtBtn)){
					if(!isContainer()) return;
					var drag:XDragSprite = new EgTxt();
					addToStage(drag);
				}
			}
			function isContainer():Boolean{
				var c:XLayoutGroup = XBox.lastSelObject as XLayoutGroup;
				if(!c){
					XAlert.show(XPanelPicSel.canNotAdd);
					return false;
				}
				return true;
			}
		}
		
		private function addToStage(drag:XDragSprite):void{
			drag.x = int(100+Math.random()*100);
			drag.y = int(100+Math.random()*100);
			drag.dragEndFunction = dragEndFunction;
			var c:XLayoutGroup = XBox.lastSelObject as XLayoutGroup;
			if(!c){
				XAlert.show(XPanelPicSel.canNotAdd);
				return;
			}
			c.addChild(drag);
			XPanelTreeSel.one.update();
		}
		private function dragEndFunction(drag:XDragSprite):void
		{
			XBox.draw(drag);
			XBox.sel(drag,true);
		}
	}
}