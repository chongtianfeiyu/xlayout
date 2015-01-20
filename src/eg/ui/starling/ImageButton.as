package eg.ui.starling
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class ImageButton extends starling.display.Button
	{
		public function ImageButton(upState:Texture, image:Texture, downState:Texture=null, overState:Texture=null, disabledState:Texture=null)
		{
			this.image = image;
			super(upState, "", downState, overState, disabledState);
			var img:Image = new Image(image);
			this.overlay.addChild(img);
			img.x = int((upState.width - img.width)*0.5);
			img.y = int((upState.height - img.height)*0.5);
		}
		private var image:Texture;
	}
}