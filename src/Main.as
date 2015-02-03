package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import starling.core.Starling;
	
	import xlayoutPanel.XBox;

	[SWF(width="1270",height="960")]
	public class Main extends Sprite
	{
		public function Main()
		{
			stage.frameRate = 60;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.color = 0x000000;
			var s:Starling = new Starling(XLayoutEditor,stage);
			s.start();
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel, false, 0 , true);
		}
		
		protected function onMouseWheel(e:MouseEvent):void{
			if(XLayoutEditor.one){
				if(XLayoutEditor.one.parent){
					XLayoutEditor.one.y += e.delta*10;
					if(XBox.lastSelObject)XBox.draw(XBox.lastSelObject);
				}
			}
		}
	}
}