package xlayoutSubUI
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Panel;
	import feathers.controls.ScrollBar;
	import feathers.core.IFeathersControl;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class XDragPanel extends Panel
	{
		private var isDrag:Boolean;
		private var p:Point = new Point();

		private var limit:Rectangle;

		private var mini:Button;
		private var hasMini:Boolean;

		private var miniGlobalPos:Point;

		private var dragX:Number;
		private var dragY:Number;
		private var theHeader:Header;
		public function XDragPanel(titleStr:String,limit:Rectangle=null)
		{
			super();
			this.limit = limit;
			this.headerProperties.title = titleStr;
			this.name = titleStr;
			var me:XDragPanel = this;
			this.headerFactory = function():Header
			{
				theHeader = new Header();
				var gx:int = 0;
				var gy:int = 0;
				function mimiMove(e:TouchEvent):void{
					var t:Touch;
					t = null;
					t = e.getTouch(mini,TouchPhase.BEGAN);
					if(t && t.isTouching(mini)){
						_drag=true;
						gx = t.globalX;
						gy = t.globalY;
					}
					t = null;
					t = e.getTouch(mini,TouchPhase.MOVED);
					if(t && t.isTouching(mini)){
						if(_drag && hasMini){
							var p:Point = t.getMovement(stage);
							mini.x += p.x;
							mini.y += p.y;
						}
					}
					t = null;
					t = e.getTouch(mini,TouchPhase.ENDED);
					if(t && t.isTouching(mini)){
						var t2:Point = new Point(t.globalX,t.globalY);
						var t1:Point = new Point(gx,gy);
						if(Point.distance(t1,t2)<3){
							onMini();
						}else{
							dragX = mini.x;
							dragY = mini.y;
						}
						_drag=false;
					}
				}
				var _drag:Boolean;
				mini = new Button();
				mini.addEventListener(TouchEvent.TOUCH, mimiMove);
				mini.label = "-";
				mini.setSize(33,20);
				mini.alpha = .7;
				theHeader.rightItems = new <DisplayObject>[ mini ];
				theHeader.addEventListener(TouchEvent.TOUCH,function(e:TouchEvent):void{
					
					var t:Touch;
					t = e.getTouch(theHeader,TouchPhase.BEGAN);
					if(t){
						me.parent.addChild(me);
						isDrag = true;
					}
					
					t = null;
					t = e.getTouch(theHeader,TouchPhase.MOVED);
					if(t && isDrag && limit){
						t.getMovement(me.parent,p);
						me.x += p.x;
						me.y += p.y;
						checkLimit();
					}
					
					t = null;
					t = e.getTouch(theHeader,TouchPhase.ENDED);
					if(t){
						isDrag = false;
					}
				});
				return theHeader;
			}
		}
		
		private function onMini():void
		{
			hasMini = !hasMini;
			var len:int = this.numRawChildren;
			if(hasMini){
				miniGlobalPos = mini.localToGlobal(new Point(0,0));
				stage.addChild(mini);
				mini.label = this.name;
				if(isNaN(dragX)){
					mini.x = miniGlobalPos.x;
					mini.y = miniGlobalPos.y;
				}else{
					mini.x = miniGlobalPos.x;
					mini.y = miniGlobalPos.y;
					var tween:Tween = new Tween(mini,.3,Transitions.EASE_OUT);
					tween.moveTo(dragX,dragY);
					Starling.current.juggler.add(tween);
				}
				theHeader.rightItems.splice(0,1);
			}else{
				mini.x=0;
				mini.y=0;
				mini.label = "-";
				mini.width = 33;
				theHeader.rightItems = new <DisplayObject>[ mini ];
			}
			this.visible = !hasMini;
		}
		public function autoHeight(panel:Panel,parentPanel:Panel=null,delay:int=66):void
		{
			setTimeout(function():void{
				var max:int;
				for (var i:int = 0; i < panel.numChildren; i++){
					var ob:DisplayObject = panel.getChildAt(i);
					var h:Number = ob.y+ob.height;
					if(h>max) max = h;
				}
				panel.height = max+50;
				if(parentPanel)autoHeight(parentPanel,null,delay);
			},delay);
		}
		public function newSection(f:DisplayObjectContainer,titleStr:String="",rowLayout:Boolean=true):Panel
		{
			var p:Panel = new Panel();
			p.headerProperties.title = titleStr;
			p.headerProperties.alpha = 0.5;
			p.headerFactory = function():IFeathersControl
			{
				var backButton:Button = new Button(); backButton.width = 44;
				backButton.label = "clear";
				backButton.addEventListener( Event.TRIGGERED, clearButton );
				var header:Header = new Header();
				header.rightItems = new <DisplayObject>
					[
						backButton
					];
				return header;
			};
			if(rowLayout){
				var v:TiledRowsLayout = new TiledRowsLayout();
				v.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
				v.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
				v.verticalGap = 0;
				v.horizontalGap = 0;
				v.padding = 1;
				v.gap = 1;
				v.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
				v.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;
				v.useSquareTiles = false;
				p.layout = v;
			}else{
				var vv:VerticalLayout = new VerticalLayout();
				p.verticalScrollPolicy = Panel.SCROLL_POLICY_OFF;
				vv.padding = 1;
				vv.gap = 1;
				vv.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
				vv.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
				p.layout = vv;
			}
			f.addChild(p);
			return p;
		}
		private function checkLimit():void
		{
			if(limit){
				if(x > limit.width) 	x =limit.width;
				if(x < limit.x) 		x =limit.x;
				if(y > limit.height) 	y =limit.height;
				if(y < limit.y) 		y =limit.y;
			}
		}
		
		private function clearButton(e:Event):void
		{
			var p:Panel = (e.target as Button).parent.parent as Panel;
			var ob:DisplayObject;
			for (var i:int = 0; i < p.numChildren; i++){
				ob = p.getChildAt(i);
				var txt:LabelTextInput = ob as LabelTextInput;
				if(txt) txt.textInput.text = "";
			}
			for (var j:int = 0; j < p.numChildren; j++){
				ob = p.getChildAt(j);
				var list:LabelPickList = ob as LabelPickList;
				if(list) list.pickList.selectedIndex = 0;
			}
		}
	}
}