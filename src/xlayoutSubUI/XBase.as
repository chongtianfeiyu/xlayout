package xlayoutSubUI
{
	import flash.geom.Rectangle;
	
	import xlayoutPanel.XBox;

	public class XBase extends XDragSprite implements ToXML,UI,Attr
	{
		private var res:String;
		public function XBase() 
		{
			super(null, true, true, new Rectangle(0,0,9999,9999));
			init()
		}
		public function init():void{
			var txt:int = LabelTextInput.TYPE_TXT;
			var num:int = LabelTextInput.TYPE_NUMBER;
			var clr:int = LabelTextInput.TYPE_COLOR;
			parr = [
				[num,"xbase",0,1],
				[num,"ybase",0,1],
			]
		}
		public function toXML():String{
			var ww:Number = this.parent.width;
			var hh:Number = this.parent.height;
			var ox:Number = this.x-ww*_xbase;
			var oy:Number = this.y-hh*_ybase;
			var str1:String = '<ui type="'+classType+'" name="'+name+'" x="'+ox+'" y="'+oy+'"';
			var str2:String = '';
			for (var i:int = 0; i < parr.length; i++){
				str2+=' '+parr[i][1]+'="' +this[parr[i][1]]+ '"';
			}
			var str3:String = ' />\n';
			
			return str1+str2+str3;
		}
		public function arr():Array{
			return parse(parr);
		}
		public var _xbase:Number = 0;
		public function get xbase():Number{
			return _xbase;
		}
		public function set xbase(v:Number):void{
			var ww:Number = this.parent.width;
			this.x = ww*v;
			_xbase = v;
			XBox.draw(this);
		}
		public var _ybase:Number = 0;
		public function get ybase():Number{
			return _ybase;
		}
		public function set ybase(v:Number):void{
			var hh:Number = this.parent.height;
			this.y = hh*v;
			_ybase = v;
			XBox.draw(this);
		}
		public var parr:Array;
		public var classType:String = "";
		public function parse(tmp:Array):Array
		{
			var w:int = 302;
			var w2:int = 250;
			var h1:int = 22;
			var w3:int = 110;
			var arr:Array = [];
			function setPropCallBack(key:String,val:String,isNumber:Boolean):void
			{
				if(val=="") return;
				if(isNumber){
					this[key] = parseFloat(val);
				}else{
					this[key] = val;
				}
			}
			for (var i:int = 0; i < tmp.length; i++){
				var item:Array = tmp[i];
				var a_prop:LabelTextInput = new LabelTextInput(null,w2,h1,w3,item[1],setPropCallBack,false,item[0]);
				a_prop.textInput.text = this[item[1]]+"";
				if(item[0]!=0){//type==数值
					a_prop.min = item[2];
					a_prop.max = item[3];
				}
				arr.push(a_prop);
			}
			return arr;
		}
	}
}