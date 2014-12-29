package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;

	[SWF(width="1024",height="800")]
	public class Main extends Sprite
	{
		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.color = 0x000000;
			var s:Starling = new Starling(LayoutTest,stage);
			s.start();
		}
	}
}