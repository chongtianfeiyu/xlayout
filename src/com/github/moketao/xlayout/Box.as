package com.github.moketao.xlayout
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class Box extends Sprite
	{
		private var bg:Quad;
		private var bg0:Quad;//上边
		private var bg1:Quad;//右边
		private var bg2:Quad;//下边
		private var bg3:Quad;//左边
		private var color:uint;
		public var borderColor:uint;
		private var _borderSize:uint=2;

		private var boderContainer:Sprite;
		public static var container:Sprite;
		
		public function get borderSize():uint
		{
			return _borderSize;
		}

		public function set borderSize(v:uint):void
		{
			_borderSize = v;
		}

		public function Box(p:DisplayObjectContainer,width:Number, height:Number, color:uint=0x000000, borderColor:uint=0x00ff00)
		{
			this.borderColor = borderColor;
			this.color = color;
			bg = new Quad(width, height, color);
			boderContainer = new Sprite(); addChild(boderContainer);
			boderContainer.addChild(bg);
			creacteBorder(borderColor);
			bg.alpha = .1;
			boderContainer.alpha = .5;
			resize(width,height);
			p.addChild(this);
			this.touchable = false;
		}
		
		public function creacteBorder(c:uint):void
		{
			bg0 = new Quad(_borderSize, _borderSize, c);
			bg1 = new Quad(_borderSize, _borderSize, c);
			bg2 = new Quad(_borderSize, _borderSize, c);
			bg3 = new Quad(_borderSize, _borderSize, c);
			
			boderContainer.addChild(bg0);
			boderContainer.addChild(bg1);
			boderContainer.addChild(bg2);
			boderContainer.addChild(bg3);
		}
		public function clearBorder():void
		{
			bg0.removeFromParent(true);
			bg1.removeFromParent(true);
			bg2.removeFromParent(true);
			bg3.removeFromParent(true);
			bg0 = null;
			bg1 = null;
			bg2 = null;
			bg3 = null;
		}
		public function resize(ww:int,hh:int):void
		{
			bg.width = ww;
			bg.height = hh;
			layoutBorder();
		}
		
		public function layoutBorder():void
		{
			var w:Number = bg.width;
			var h:Number = bg.height;
			bg0.width = w;
			bg1.height = h; bg1.x=w-_borderSize;
			bg2.width = w; bg2.y=h-_borderSize;
			bg3.height = h;
		}
		public override function get width():Number
		{
			return super.width;
		}

		public override function set width(v:Number):void
		{
			bg.width = v;
			layoutBorder();
		}
		
		public override function get height():Number { 
			return bg.height;
		}
		
		public override function set height(v:Number):void
		{
			bg.height = v;
			layoutBorder();
		}

		public static var helpPoint:Point = new Point();
		public static var dic:Dictionary = new Dictionary();
		public var hasSel:Boolean;
		public static function draw(ob:DisplayObject):void
		{
			if(!container){
				var boxContainer:Sprite = new Sprite();
				Box.container = boxContainer;
			}
			Starling.current.stage.addChild(container);
			var w:Number = ob.width;
			var h:Number = ob.height;
			if(w<=0 || h<=0) return;
			var box:Box = dic[ob] as Box;
			var needResize:Boolean = true;
			if(!box){
				needResize = false;
				box = new Box(container,w,h);
				dic[ob] = box; 
			}
			helpPoint.x = ob.x;
			helpPoint.y = ob.y;
			var res:Point = ob.parent.localToGlobal(helpPoint);
			box.x = res.x;
			box.y = res.y;
			if(needResize)box.resize(ob.width,ob.height);
		}
		
		public static function remove(ob:DisplayObject):void
		{
			var box:Box = dic[ob] as Box;
			if(box){
				dic[ob] = null;
				delete dic[ob];
				box.removeFromParent(true);
			}			
		}
		
		public static function sel(ob:DisplayObject):void
		{
			var box:Box = dic[ob] as Box;
			if(box){
				if(!box.hasSel){
					box.hasSel = true;
					box.clearBorder();
					box.creacteBorder(0xff0000);
					box.layoutBorder();
				}else{
					box.hasSel = false;
					box.clearBorder();
					box.creacteBorder(box.borderColor);
					box.layoutBorder();
				}
			}
		}
	}
}