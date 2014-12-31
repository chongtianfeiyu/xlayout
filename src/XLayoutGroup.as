package 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import feathers.controls.LayoutGroup;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	
	public class XLayoutGroup extends LayoutGroup implements ToXML
	{
		public static var rootBox:XLayoutGroup; 
		public function toXML():String{
			return "LayoutGroupBox\n";
		}
		public function XLayoutGroup(p:DisplayObjectContainer,isRoot:Boolean=false)
		{
			super();
			this.isRoot = isRoot;
			p.addChild(this);
			bg = new Quad(5,5,0x000000);
			bg.name = "skip";
			addChild(bg);
		}
		public function drawBox():void
		{
			XBox.draw(this);
		}
		override public function dispose():void
		{
			super.dispose();
			XBox.remove(this);
		}
		override protected function draw():void
		{
			super.draw();
			bg.width=this.width;
			bg.height=this.height;
			drawBox();
			var itemCount:int = this.items.length;
			for(var i:int = 0; i < itemCount; i++)
			{
				if(items[i].name!="skip")XBox.draw(this.items[i] as DisplayObjectContainer);
			}
		}
		private var _isRoot:Boolean;

		private var bg:Quad;
		public function set isRoot(v:Boolean):void
		{
			this._isRoot = v; 
			if(v){
				rootBox = this;
				autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;
				if(!stage){
					addEventListener(starling.events.Event.ADDED_TO_STAGE,onAdd);
				}else{
					onAdd();
				}
			}
		}
		private function onAdd(e:starling.events.Event=null):void
		{
			stage.addEventListener(flash.events.Event.RESIZE,onResize);
		}
		private function onResize(e:ResizeEvent):void
		{
			trace(this.width,this.height);
			stage.stageWidth = e.width;
			stage.stageHeight = e.height;
			Starling.current.viewPort = new Rectangle(0,0,e.width,e.height);
		}
		public function get isRoot():Boolean
		{ 
			return this._isRoot;
		}
	}
}