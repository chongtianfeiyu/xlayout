package
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class DragCursor extends Sprite
	{
		public function DragCursor()
		{
			super();
			var img:Image = new Image(XLayoutEditor.theme.atlas.getTexture("picker-list-icon-disabled"));
			img.x = 10;
			img.y = 18;
			addChild(img);
			this.visible = false;
		}
	}
}