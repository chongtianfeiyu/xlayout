package eg.ui.starling
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class CheckBox extends Button
	{
		public function CheckBox(upState:Texture, checkState:Texture, downState:Texture=null)
		{
			super(upState, "", downState);
			checkImage = new Image(checkState);
			addChild(checkImage);
			checkImage.visible = checked;
			
			this.scaleWhenDown = 1.0;
			this.addEventListener(Event.TRIGGERED,onTrigger);
		}
		
		private var checkImage:Image;
		private var checked:Boolean = false;
		
		public function set check(b:Boolean):void{
			checked = b;
			if(checkImage)
				checkImage.visible = checked;
		}
		public function get check():Boolean
		{
			return checked;
		}
		private function onTrigger(e:*):void{
			check = !check;
		}
		override public function dispose():void{
			if(checkImage) {checkImage.dispose(); checkImage = null;}
			super.dispose();
		}
	}
}