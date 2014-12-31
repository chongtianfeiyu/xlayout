package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.controls.Header;
	import feathers.controls.Panel;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class XDragPanel extends Panel
	{
		private var isDrag:Boolean;
		private var p:Point = new Point();

		private var limit:Rectangle;
		public function XDragPanel(titleStr:String,limit:Rectangle=null)
		{
			super();
			this.limit = limit;
			this.headerProperties.title = titleStr;
			var me:XDragPanel = this;
			this.headerFactory = function():Header
			{
				var header:Header = new Header();
				header.addEventListener(TouchEvent.TOUCH,function(e:TouchEvent):void{
					
					var t:Touch;
					t = e.getTouch(header,TouchPhase.BEGAN);
					if(t){
						isDrag = true;
					}
					
					t = null;
					t = e.getTouch(header,TouchPhase.MOVED);
					if(t && isDrag && limit){
						t.getMovement(me.parent,p);
						me.x += p.x;
						me.y += p.y;
						checkLimit();
					}
					
					t = null;
					t = e.getTouch(header,TouchPhase.ENDED);
					if(t){
						isDrag = false;
					}
				});
				return header;
			}
		}
		private function checkLimit():void
		{
			if(limit){
				if(x > limit.width) 	x =limit.width;
				if(x < limit.x) 		x =limit.x;
				if(y > limit.height) 	y =limit.height;
				if(y < limit.y) 		y =limit.y;
			}
		}
	}
}