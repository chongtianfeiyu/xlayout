package
{
	import flash.geom.Rectangle;
	
	import starling.display.Image;

	public class XImgToXML extends XDragSprite implements ToXML
	{
		public function XImgToXML(img:XImg) 
		{
			var image:Image = new Image(img.t);
			this.name = img.name;
			super(image, true, true, new Rectangle(0,0,9999,9999));
		}
		public function toXML():String{
			return '<ui type="img" name="'+name+'" res="'+name+'" x="'+x+'" y="'+y+'" />\n';
		}
	}
}