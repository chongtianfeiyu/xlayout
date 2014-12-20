package
{
	import com.github.moketao.xlayout.Box;
	import com.github.moketao.xlayout.UIStage;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LayoutTest extends Sprite
	{
		public function LayoutTest()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		private function onAdd(e:*):void
		{
			var ui:UIStage = new UIStage(this);
			
			var box:Box = new Box(ui,ui.width,ui.height);
			
			var box1:Box = new Box(ui,100,100);
			box1.x = 10;
			box1.y = 10;
			
			var box2:Box = new Box(ui,200,100,0xff00ff,0x00ff00);
			box2.x = 220;
			box2.y = 110;
		}
	}
}