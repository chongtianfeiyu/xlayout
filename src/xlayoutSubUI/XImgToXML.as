package xlayoutSubUI
{
	import starling.display.Image;

	public class XImgToXML extends XBase
	{
		private var res:String;
		public function XImgToXML(img:XImg) 
		{
			super();
			classType = "img";
			var image:Image = new Image(img.t);
			this.res = img.name;
			add(image);
		}
//		override public function toXML():String{
//			return '<ui type="img" name="'+name+'" res="'+res+'" x="'+x+'" y="'+y+'" />\n';
//		}
	}
}