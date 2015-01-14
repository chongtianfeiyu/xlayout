package xlayoutSubUI
{
	import flash.geom.Rectangle;

	public class XBase extends XDragSprite implements ToXML,UI,Attr
	{
		private var res:String;
		public function XBase() 
		{
			super(null, true, true, new Rectangle(0,0,9999,9999));
		}
		public function toXML():String{
			return '<ui type="base" name="'+name+'" res="'+res+'" x="'+x+'" y="'+y+'" />\n';
		}
		public function arr():Array{
			return [];
		}
		
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