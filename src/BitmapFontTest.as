package
{
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class BitmapFontTest extends Sprite
	{
		[Embed(source = "text-outline.png")]
		public static const FontTexture:Class;
		
		[Embed(source="text.fnt", mimeType="application/octet-stream")]
		public static const FontXml:Class;
		
		public static var GameFontName:String = "MicrosoftYaHei";
		public function BitmapFontTest()
		{
			var texture:Texture = Texture.fromBitmap(new FontTexture());
			var xml:XML = XML(new FontXml());
			TextField.registerBitmapFont(new BitmapFont(texture, xml));
			
			var txt:TextField = new TextField(500,110,"<font color='#FF0000'>测试</font>ABCdefg12390","Verdana",18);
//			var txt:TextField = new TextField(500,110,"<font color='#FFFFFF'>测试</font>ABCdefg12390",GameFontName,18);
//			var txt:TextField = new TextField(100,30,"测试ABCdefg12390",GameFontName,18);
				txt.color = Color.WHITE;
//				txt.color = Color.RED;
			txt.isHtmlText = true;
			addChild(txt);
		}
	}
}