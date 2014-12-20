package com.github.moketao.xlayout
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.ResizeEvent;
	
	public class UIStage extends Sprite
	{
		private var p:DisplayObjectContainer;
		public function UIStage(p:DisplayObjectContainer)
		{
			this.p = p;
			addEventListener(starling.events.Event.ADDED_TO_STAGE,onAdd);
			p.addChild(this);
		}
		
		private function onAdd(e:starling.events.Event):void
		{
			stage.addEventListener(flash.events.Event.RESIZE,onResize);
		}
		
		private function onResize(e:ResizeEvent):void
		{
			trace(e.width,e.height);
			stage.stageWidth = e.width;
			stage.stageHeight = e.height;
			Starling.current.viewPort = new Rectangle(0,0,e.width,e.height);
		}
		
		public override function get width():Number
		{
			return p.stage.stageWidth;
		}
		
		public override function get height():Number { 
			return p.stage.stageHeight;
		}
	}
}