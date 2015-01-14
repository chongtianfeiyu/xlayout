package xlayoutSubUI
{
	import starling.text.TextField;

	public class XTxtToXML extends XBase
	{
		private var res:String;
		public function XTxtToXML() 
		{
			super();
			var t:TextField = new TextField(50,50,Math.random().toFixed(2));
			add(t);
		}
		override public function toXML():String{
			return '<ui type="img" name="'+name+'" res="'+res+'" x="'+x+'" y="'+y+'" />\n';
		}
	}
}