package eg.ui.starling
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class WebView extends DisplayObjectContainer
	{
		private var webView:StageWebView
		private var _url:String;
		private var bitmapData:BitmapData;
		private var text:Texture;
		private var img:Image;
		public function WebView(x:int,y:int,w:int,h:int,stage:Stage)
		{
			super();
			webView = new StageWebView();
			webView.stage = stage;
			webView.viewPort = new Rectangle(x, y, w, h);
			webView.addEventListener(Event.COMPLETE,handleLoad);
			
			bitmapData = new BitmapData(webView.viewPort.width, webView.viewPort.height);
			// show loading
		}
		public function set url(s:String):void{
			_url = s;
			if(webView)
				webView.loadURL(_url);
		}
		public function get url():String{
			return _url;
		}
		public function handleLoad(e:Event):void
		{
			trace("url loaded:"+url);
			if(img)
			{
				this.removeChild(img);
				img.dispose();
			}
			if(text)	text.dispose();
			
			webView.drawViewPortToBitmapData(bitmapData);
			text = Texture.fromBitmapData(bitmapData,false);
			img = Image(text);
			addChild(img);
		}
	}
}