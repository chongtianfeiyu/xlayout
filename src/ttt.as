package
{
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	
	public class ttt extends XDragSprite
	{
		public function ttt(subObject:DisplayObject, moveInX:Boolean=true, moveInY:Boolean=true, limit:Rectangle=null, dragObject:DisplayObject=null)
		{
			super(subObject, moveInX, moveInY, limit, dragObject);
		}
	}
}