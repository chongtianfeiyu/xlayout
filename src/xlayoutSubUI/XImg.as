package xlayoutSubUI
{
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class XImg extends Sprite
	{
		private var lastX:Number;
		private var lastY:Number;
		private var selIcon:Image;
		private var bg:Quad;
		private var alphaUnSel:Number = .3;
		private var alphaSel:Number = 1;
		public var hasSel:Boolean;
		public var frame:Rectangle;
		public var r:Rectangle;
		public var t:Texture;

		private var image:Image;

		private var b:Number;

		public var max:int;

		public static var DOUBLE_CLICK:String = "双击";
		public var isRotaion:Boolean;
		private var lastSelTime:int;
		public function clone(maxWidth:int):XImg
		{
			return new XImg(t,name,frame,r,maxWidth);
		}
		public function XImg(t:Texture,_name:String,frame:Rectangle,r:Rectangle,max:int=90,isRotaion:Boolean=false)
		{
			this.isRotaion = isRotaion;
			this.max = max;
			if(isRotaion){
				var tmp:Number = frame.width;
				frame.width = frame.height;
				frame.height = tmp;
			}
			this.t = t;
			this.r = r;
			this.frame = frame;
			var c:Sprite = new Sprite();
			if(isRotaion){
				bg = new Quad(r.height,r.width,0xff0000);
			}else{
				bg = new Quad(r.width,r.height,0xff0000);
			}
			bg.x = -frame.x;
			bg.y = -frame.y;
			bg.alpha = alphaUnSel;
			c.addChild(bg);
			
			
			image = new Image(t);
			c.addChild(image);
			
			var clip:Rectangle = new Rectangle();
			if(isRotaion){
				clip.width = r.height;
				clip.height = r.width;				
			}else{
				clip.width = r.width;
				clip.height = r.height;				
			}
			
			
			c.x = frame.x;
			c.y = frame.y;
			
			
			this.clipRect = clip;
			this.name = _name;
			if(r.width>max || r.height>max){
				
				if(frame.width>frame.height){
					b = max/frame.width;
				}else{
					b = max/frame.height;
				}
				scaleX = b;
				scaleY = b;
			}
			
			addChild(c);
			addEventListener(TouchEvent.TOUCH,onT);
		}
		
		private function onT(e:TouchEvent):void
		{
			var t:Touch;
			t = e.getTouch(this,TouchPhase.BEGAN);
			if(t){
				lastX = t.globalX;
				lastY = t.globalY;
				return;
			}
			t = null;
			t = e.getTouch(this,TouchPhase.ENDED);
			if(t){
				if(Math.abs(t.globalX-lastX)<10){
					if(Math.abs(t.globalY-lastY)<10){
						var now:int = getTimer();
						if(now-lastSelTime<600) dispatchEventWith(DOUBLE_CLICK,false,this);
						lastSelTime = now;
						if(hasSel){
							sel(false);
						}else{
							sel(true);
						}
					}
				}
			}
		}
		
		public function sel(yes:Boolean):void
		{
			this.hasSel = yes;
			if(!selIcon){
				selIcon = new Image(XLayoutEditor.theme.atlas.getTexture("button-back-down-skin"));
				if(b<0.3){
					var bb:Number = 0.3/b;
					selIcon.scaleX *= bb;
					selIcon.scaleY *= bb;
				}
				selIcon.x = bg.width-selIcon.width;
				selIcon.y = bg.height-selIcon.height;
				addChild(selIcon);
			}
			selIcon.visible = yes? true:false;
			bg.alpha = yes? alphaSel:alphaUnSel;
			image.alpha = yes? 0.8:1;
		}
	}
}