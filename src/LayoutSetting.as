package
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.core.IFeathersControl;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class LayoutSetting extends XDragPanel
	{
		private var add_btn:Button;
		private var del_btn:Button;

		private var m2:Panel;

		private var dic1:Dictionary;
		private var dic2:Dictionary;

		private var mode1:LabelPickList;
		private var mode2:LabelPickList;

		private var m1:Panel;
		public static var one:LayoutSetting;
		public function LayoutSetting(titleStr:String,limit:Rectangle=null)
		{
			one = this;
			super(titleStr,limit);
			verticalScrollPolicy = Panel.SCROLL_POLICY_OFF;
			this.setSize(320,580);
			var layout:VerticalLayout = new VerticalLayout();
			layout.padding = 0;
			layout.gap = 1;
			this.layout = layout;
			
			var w:int = 302;
			var w2:int = 250;
			var h1:int = 22;
			var w3:int = 110;
			
			dic1 = new Dictionary();
			dic2 = new Dictionary();
			m1 = newSection(this,"自身布局属性",false);
			m1.setSize(w,70);
			mode1 = new LabelPickList(m1,w2,h1,w3,"自身属性",["无","停靠","横向","纵向"]);
			mode1.pickList.addEventListener(Event.CHANGE,function(e:*):void{
				showAndHide1();
			});
			var percentWidth:LabelTextInput = new LabelTextInput(m1,w2,h1,w3,"percentWidth");
			var percentHeight:LabelTextInput = new LabelTextInput(m1,w2,h1,w3,"percentHeight");
			var top:LabelTextInput = new LabelTextInput(m1,w2,h1,w3,"top");
			var right:LabelTextInput = new LabelTextInput(m1,w2,h1,w3,"right");
			var bottom:LabelTextInput = new LabelTextInput(m1,w2,h1,w3,"bottom");
			var left:LabelTextInput = new LabelTextInput(m1,w2,h1,w3,"left");
			var horizontalCenter:LabelTextInput = new LabelTextInput(m1,w2,h1,w3,"horizontalCenter");
			var verticalCenter:LabelTextInput = new LabelTextInput(m1,w2,h1,w3,"verticalCenter");
			dic1["无"] = [];
			dic1["停靠"] = [
				top,
				right,
				bottom,
				left,
				horizontalCenter,
				verticalCenter,
			];
			dic1["横向"] = [
				percentWidth,
				percentHeight,
			];
			dic1["纵向"] = [
				percentWidth,
				percentHeight,
			];
			showAndHide1();
			
			
			m2 = newSection(this,"子对象布局设置",false);
			m2.width = w;
			m2.height = 270;
				
			mode2 = new LabelPickList(m2,w2,h1,w3,"子对象排列",["无","停靠","横向","纵向","横向多行","纵向多列"]);
			mode2.pickList.addEventListener(Event.CHANGE,function(e:*):void{
				showAndHide2();
			});
			var gap:LabelTextInput = new LabelTextInput(m2,w2,h1,w3,"gap");
			var padding:LabelTextInput = new LabelTextInput(m2,w2,h1,w3,"padding");
			var paddingTop:LabelTextInput = new LabelTextInput(m2,w2,h1,w3,"paddingTop");
			var paddingRight:LabelTextInput = new LabelTextInput(m2,w2,h1,w3,"paddingRight");
			var paddingBottom:LabelTextInput = new LabelTextInput(m2,w2,h1,w3,"paddingBottom");
			var paddingLeft:LabelTextInput = new LabelTextInput(m2,w2,h1,w3,"paddingLeft");
			dic2["无"] = [];
			dic2["停靠"] = [
				
			];
			dic2["横向"] = [
				gap,
				padding,
				paddingTop,
				paddingRight,
				paddingBottom,
				paddingLeft,	
			];
			dic2["纵向"] = [
				gap,
				padding,
				paddingTop,
				paddingRight,
				paddingBottom,
				paddingLeft,
			];
			dic2["横向多行"] = [
				gap,
				padding,
				paddingTop,
				paddingRight,
				paddingBottom,
				paddingLeft,		
			];
			dic2["纵向多列"] = [
				gap,
				padding,
				paddingTop,
				paddingRight,
				paddingBottom,
				paddingLeft,
			];
			showAndHide2();
			
			var m3:Panel = newSection(this,"命令");
				m3.setSize(w,70);
				
				
			add_btn = new Button();
			add_btn.label="添加布局";
			m3.addChild(add_btn);
			
			del_btn = new Button();
			del_btn.label="删除布局";
			m3.addChild(del_btn);
			
			addEventListener(TouchEvent.TOUCH,onT);
		}
		
		private function showAndHide1():void
		{
			var sel:Object = mode1.pickList.selectedItem;
			var arr:Array = dic1[sel];
			m1.removeChildren(0,-1);
			m1.addChild(mode1);
			if(!arr) return;
			for (var j:int = 0; j < arr.length; j++){
				m1.addChild(arr[j]);
			}
			setTimeout(function():void{
				var max:int;
				for (var i:int = 0; i < m1.numChildren; i++){
					var ob:DisplayObject = m1.getChildAt(i);
					var h:Number = ob.y+ob.height;
					if(h>max) max = h;
				}
				m1.height = max+50;
				showAndHide3();
			},1);			
		}
		
		private function showAndHide3():void
		{
			setTimeout(function():void{
				var max:int;
				for (var i:int = 0; i < one.numChildren; i++){
					var ob:DisplayObject = one.getChildAt(i);
					if(ob is Panel) {
						var h:Number = ob.y+ob.height;
						if(h>max) max = h;
					}
				}
				one.height = max+50;
			},111);
		}
		private function showAndHide2():void
		{
			var sel:Object = mode2.pickList.selectedItem;
			var arr:Array = dic2[sel];
			m2.removeChildren(0,-1);
			m2.addChild(mode2);
			if(!arr) return;
			for (var j:int = 0; j < arr.length; j++){
				m2.addChild(arr[j]);
			}
			setTimeout(function():void{
				var max:int;
				for (var i:int = 0; i < m2.numChildren; i++){
					var ob:DisplayObject = m2.getChildAt(i);
					var h:Number = ob.y+ob.height;
					if(h>max) max = h;
				}
				m2.height = max+50;
			},1);
			showAndHide3();
		}
		
		private function newSection(f:DisplayObjectContainer,titleStr:String="",rowLayout:Boolean=true):Panel
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
		private function onT(e:TouchEvent):void
		{
			var t:Touch;
			t = e.getTouch(this,TouchPhase.ENDED);
			if(t){
				if(t.isTouching(add_btn)){
					trace("add");
				}
			}
			
			t = null;
			t = e.getTouch(this,TouchPhase.BEGAN);
			if(t){
				
			}
			
		}
	}
}