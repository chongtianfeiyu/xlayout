package xlayoutSubUI 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import feathers.controls.LayoutGroup;
	import feathers.core.FeathersControl;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	
	import xlayoutPanel.XBox;
	
	public class XLayoutGroup extends LayoutGroup implements ToXML,UI
	{
		public static var rootBox:XLayoutGroup; 
		public function toXML():String{
			return "LayoutGroupBox\n";
		}
		public function XLayoutGroup(p:DisplayObjectContainer,isRoot:Boolean=false,_resizer:Resizer=null)
		{
			super();
			if(_resizer!=null)resizer = _resizer;
			this.isRoot = isRoot;
			p.addChild(this);
		}
		public static function getLayoutSelf(ob:Object):Array{
			var w:int = 302;
			var w2:int = 250;
			var h1:int = 22;
			var w3:int = 110;
			var arr:Array = [];
			if(ob is FeathersControl){
				var f:FeathersControl = ob as FeathersControl;
				function onChangeSubMode(key:String):void
				{
					switch(key)
					{
						case "无":
						{
							f.layoutData = null;
							break;
						}
						case "停靠":
						{
							f.layoutData = new AnchorLayoutData();
							break;
						}
						case "横向":
						{
							f.layoutData = new HorizontalLayoutData();
							break;
						}
						case "纵向":
						{
							f.layoutData = new VerticalLayoutData();
							break;
						}
						default:
						{
							break;
						}
					}
					setTimeout(function():void{
						if(G.SkipEvent) return;
						G.showLayoutAttr(f);
					},50);
				}
				function setProSelf(key:String,val:String,isNumber:Boolean):void
				{
					if(val=="") return;
					XBox.sel(f,true);
					f.layoutData[key] = parseFloat(val);
				}
				var subModeSel:LabelPickList = new LabelPickList(null,w2,h1,w3,"自身布局属性",["无","停靠","横向","纵向","横向多行","纵向多列"],onChangeSubMode);
				var l1:HorizontalLayoutData = f.layoutData as HorizontalLayoutData;
				var l2:VerticalLayoutData = f.layoutData as VerticalLayoutData;
				var l3:AnchorLayoutData = f.layoutData as AnchorLayoutData;
				arr.push(subModeSel);
				var percentWidth:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"percentWidth",setProSelf);
				var percentHeight:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"percentHeight",setProSelf);
				function wrap(ob):void{
					if(ob is AnchorLayoutData){
						if(!isNaN(ob.top)) top.textInput.text = ob.top+"";
						if(!isNaN(ob.right)) right.textInput.text = ob.right+"";
						if(!isNaN(ob.bottom)) bottom.textInput.text = ob.bottom+"";
						if(!isNaN(ob.left)) left.textInput.text = ob.left+"";
						if(!isNaN(ob.horizontalCenter)) horizontalCenter.textInput.text = ob.horizontalCenter+"";
						if(!isNaN(ob.verticalCenter)) verticalCenter.textInput.text = ob.verticalCenter+"";
					}
					if(!isNaN(ob.percentWidth)) percentWidth.textInput.text = ob.percentWidth+"";
					if(!isNaN(ob.percentHeight)) percentHeight.textInput.text = ob.percentHeight+"";
				}
				if(l1 || l2){
					if(l1){
						G.SkipEvent = true;
						subModeSel.pickList.selectedItem = "横向";
						wrap(l1);
					}
					if(l2){
						G.SkipEvent = true;
						subModeSel.pickList.selectedItem = "纵向";
						wrap(l2);
					}
					arr.push(percentWidth,percentHeight);
					return arr;
				}
				if(l3){
					G.SkipEvent = true;
					subModeSel.pickList.selectedItem = "停靠";
					var top:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"top",setProSelf);
					var right:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"right",setProSelf);
					var bottom:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"bottom",setProSelf);
					var left:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"left",setProSelf);
					var horizontalCenter:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"horizontalCenter",setProSelf);
					var verticalCenter:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"verticalCenter",setProSelf);
					wrap(l3);
					arr.push(top,right,bottom,left,horizontalCenter,verticalCenter,percentWidth,percentHeight);
					return arr;
				}
			}
			return arr;
		}
		public static function getLayoutSub(ob:Object):Array{
			var w:int = 302;
			var w2:int = 250;
			var h1:int = 22;
			var w3:int = 110;
			var arr:Array = [];
			if(ob is LayoutGroup){
				var g:LayoutGroup = ob as LayoutGroup;
				function onChangeSubMode(key:String):void
				{
					switch(key)
					{
						case "无":
						{
							g.layout = null;
							break;
						}
						case "停靠":
						{
							g.layout = new AnchorLayout();
							break;
						}
						case "横向":
						{
							g.layout = new HorizontalLayout();
							break;
						}
						case "纵向":
						{
							g.layout = new VerticalLayout();
							break;
						}
						case "横向多行":
						{
							g.layout = new TiledRowsLayout();
							break;
						}
						case "纵向多列":
						{
							g.layout = new TiledColumnsLayout();
							break;
						}
						default:
						{
							break;
						}
					}
					setTimeout(function():void{
						if(G.SkipEvent) return;
						G.showLayoutAttr(g);
					},50);
				}
				function setProSub(key:String,val:String,isNumber:Boolean):void
				{
					if(val=="") return;
					g.layout[key] = parseFloat(val);
				}
				var subModeSel:LabelPickList = new LabelPickList(null,w2,h1,w3,"子对象排列",["无","停靠","横向","纵向","横向多行","纵向多列"],onChangeSubMode);
				var l1:HorizontalLayout = g.layout as HorizontalLayout;
				var l2:VerticalLayout = g.layout as VerticalLayout;
				var l3:AnchorLayout = g.layout as AnchorLayout;
				var l4:TiledRowsLayout = g.layout as TiledRowsLayout;
				var l5:TiledColumnsLayout = g.layout as TiledColumnsLayout;
				arr.push(subModeSel);
				if(!l1 && !l2 && !l3 && !l4 && !l5)
					return arr;
				if(l3){
					G.SkipEvent = true;
					subModeSel.pickList.selectedItem = "停靠";
					return arr;
				}
				var gap:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"gap",setProSub);
				var padding:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"padding",setProSub);
				var paddingTop:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"paddingTop",setProSub);
				var paddingRight:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"paddingRight",setProSub);
				var paddingBottom:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"paddingBottom",setProSub);
				var paddingLeft:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"paddingLeft",setProSub);
				function wrap(ob:Object):void{
					if(!isNaN(ob.gap)) gap.textInput.text = ob.gap+"";
					if(!isNaN(ob.padding)) padding.textInput.text = ob.padding+"";
					if(!isNaN(ob.paddingTop)) paddingTop.textInput.text = ob.paddingTop+"";
					if(!isNaN(ob.paddingRight)) paddingRight.textInput.text = ob.paddingRight+"";
					if(!isNaN(ob.paddingBottom)) paddingBottom.textInput.text = ob.paddingBottom+"";
					if(!isNaN(ob.paddingLeft)) paddingLeft.textInput.text = ob.paddingLeft+"";
				}
				arr.push(subModeSel,gap,padding,paddingTop,paddingRight,paddingBottom,paddingLeft);
				if(l1){
					G.SkipEvent = true;
					subModeSel.pickList.selectedItem = "横向";
					wrap(l1);
				}
				if(l2){
					G.SkipEvent = true;
					subModeSel.pickList.selectedItem = "纵向";
					wrap(l2);
				}
				if(l4){
					G.SkipEvent = true;
					subModeSel.pickList.selectedItem = "横向多行";
					wrap(l4);
				}
				if(l5){
					G.SkipEvent = true;
					subModeSel.pickList.selectedItem = "纵向多列";
					wrap(l5);
				}
				return arr;
			}
			return [];
		}

		public function drawBox():void
		{
			XBox.draw(this);
		}
		override public function dispose():void
		{
			super.dispose();
		}
		override protected function draw():void
		{
			super.draw();
			drawBox();
			var itemCount:int = this.items.length;
			for(var i:int = 0; i < itemCount; i++)
			{
				if(items[i].name!="skip")XBox.draw(this.items[i] as DisplayObjectContainer);
			}
		}
		private var _isRoot:Boolean;

		public static var resizer:Resizer;
		private var me:DisplayObjectContainer;

		public function set isRoot(v:Boolean):void
		{
			this._isRoot = v; 
			if(v){
				rootBox = this;
//				autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;
//				if(!stage){
//					addEventListener(starling.events.Event.ADDED_TO_STAGE,onAdd);
//				}else{
//					onAdd();
//				}
				resizer.addEventListener("改变尺寸",onResize);
				resize(resizer.x,resizer.y);
				me = this;
				setTimeout(function():void{XBox.draw(me);},39);
			}
		}
		private function onAdd(e:starling.events.Event=null):void
		{
			stage.addEventListener(flash.events.Event.RESIZE,onResize);
		}
		private function onResize(e:starling.events.Event):void
		{
			resize(e.data.x,e.data.y);
		}
		
		public function resize(ww:int, hh:int ,scale:Number=1):void
		{
			trace(this.width,this.height);
//			stage.stageWidth = ww*(1/scale);
//			stage.stageHeight = hh*(1/scale);
//			Starling.current.viewPort = new Rectangle(0,0,ww,hh);
			width = ww;
			height = hh;
			scaleX = scale;
			scaleY = scale;
		}
		public function get isRoot():Boolean
		{ 
			return this._isRoot;
		}
	}
}