package xlayoutSubUI
{
	import starling.text.TextField;
	
	import xlayoutPanel.XBox;

	public class EgTxt extends XBase
	{
		private var res:String;
		public static var lastFontName:String = "微软雅黑";
		public static var lastFontSize:int = 23;
		public static var lastColor:uint = 0x888888;
		public static var lastW:uint = 200;
		public static var lastH:uint = 26;
		private var txt:TextField;
		public function EgTxt() 
		{
			super();
			classType = "txt";
			init();
			var str:String = Math.random().toFixed(2);
			txt = new TextField(lastW,lastH,str,lastFontName,lastFontSize,lastColor);
			addChild(txt);
		}
		
		public override function init():void{
			super.init();
			var txt:int = LabelTextInput.TYPE_TXT;
			var num:int = LabelTextInput.TYPE_NUMBER;
			var clr:int = LabelTextInput.TYPE_COLOR;
			var tex:int = LabelTextInput.TYPE_TXT_TEXTURE;
			parr.push([txt,"defaultValue"]);
			parr.push([txt,"font"]);
			parr.push([num,"fontsize",1,300]);
			parr.push([num,"w",1,9999]);
			parr.push([num,"h",1,9999]);
			parr.push([clr,"color",0,0xffffff]);
			parr.push([num,"xbase",0,1]);
			parr.push([num,"ybase",0,1]);
		}
		override public function toXML():String{
			var ww:Number = this.parent.width;
			var hh:Number = this.parent.height;
			var ox:Number = this.x-ww*_xbase;
			var oy:Number = this.y-hh*_ybase;
			var str1:String = '<ui type="txt" name="'+name+'" x="'+ox+'" y="'+oy+'"';
			var str2:String = '';
			for (var i:int = 0; i < parr.length; i++){
				str2+=' '+parr[i][1]+'="' +this[parr[i][1]]+ '"';
			}
			var str3:String = ' />\n';
			
			return str1+str2+str3;
		}
		public function get defaultValue():String{
			return txt.text;
		}
		public function set defaultValue(v):void{
			txt.text = v;
		}
		public function get font():String{
			return txt.fontName;
		}
		public function set font(v:String):void{
			txt.fontName = v;
		}
		public function get fontsize():Number{
			return txt.fontSize;
		}
		public function set fontsize(v:Number):void{
			txt.fontSize = v;
		}
		public function get w():Number{
			return txt.width;
		}
		public function set w(v:Number):void{
			txt.width = v;
			XBox.draw(this);
		}
		public function get h():Number{
			return txt.height;
		}
		public function set h(v:Number):void{
			txt.height = v;
			XBox.draw(this);
		}
		public function get color():String{
			return txt.color.toString(16);
		}
		public function set color(v:String):void{
			txt.color = uint(v);
		}

	}
}
