package xlayoutSubUI
{
	import starling.display.Button;
	import starling.display.Quad;
	import starling.text.TextField;

	public class EgBtn extends XBase
	{
		public function EgBtn() 
		{
			super();
			classType = "btn";
			init();
			bg = new Quad(50,30,0xff0000);
			addChild(bg);
			txt = new TextField(20,20,"   ");
		}
		override public function init():void{
			super.init();
			var txt:int = LabelTextInput.TYPE_TXT;
			var num:int = LabelTextInput.TYPE_NUMBER;
			var clr:int = LabelTextInput.TYPE_COLOR;
			var tex:int = LabelTextInput.TYPE_TXT_TEXTURE;
			parr.push([txt,"defaultValue"]);
			parr.push([tex,"resName"]);
			parr.push([tex,"resName2"]);
		}
		private var bt:Button;
		private var txt:TextField;
		private var _defaultValue:String;
		public function get defaultValue():String{
			return _defaultValue;
		}
		public function set defaultValue(v:String):void{
			_defaultValue = v;
			build();
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
			if(resName!="" && resName2==""){
				bt = new Button(G.res.getTexture(resName),defaultValue);
			}else if(resName!="" && resName2!=""){
				bt = new Button(G.res.getTexture(resName),defaultValue,G.res.getTexture(resName2));
			}
			addChild(bt);
			if(bg){
				bg.removeFromParent(true);
				bg = null;
			}
		}
		public var _resName2:String = "";
		public function get resName2():String{
			return _resName2;
		}
		public function set resName2(v:String):void{
			_resName2 = v;
			build();
		}
	}
}
