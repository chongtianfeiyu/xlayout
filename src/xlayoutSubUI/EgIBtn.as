package xlayoutSubUI
{
	import eg.ui.starling.ImageButton;
	
	import starling.display.Quad;

	public class EgIBtn extends XBase
	{
		public function EgIBtn() 
		{
			super();
			classType = "ibtn";
			init();
			bg = new Quad(50,30,0xff0000);
			addChild(bg);
		}
		override public function init():void{
			super.init();
			var txt:int = LabelTextInput.TYPE_TXT;
			var num:int = LabelTextInput.TYPE_NUMBER;
			var clr:int = LabelTextInput.TYPE_COLOR;
			var tex:int = LabelTextInput.TYPE_TXT_TEXTURE;
			parr.push([tex,"resName"]);
			parr.push([tex,"resName2"]);
		}
		private var bg:Quad;
		public var _resName:String = "";
		public function get resName():String{
			return _resName;
		}
		public function set resName(v:String):void{
			_resName = v;
			build();
		}
		private function build():void{
			if(bt) bt.removeFromParent(true);
			if(resName!="" && resName2!=""){
				bt = new ImageButton(G.res.getTexture(resName),G.res.getTexture(resName2));
				addChild(bt);
				if(bg){
					bg.removeFromParent(true);
					bg = null;
				}
			}
		}
		public var _resName2:String = "";
		private var bt:ImageButton;
		public function get resName2():String{
			return _resName2;
		}
		public function set resName2(v:String):void{
			_resName2 = v;
			build();
		}
	}
}
