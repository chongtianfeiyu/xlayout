package eg.ui.starling
{
	import flash.display.Stage;
	import flash.events.SoftKeyboardEvent;
	import flash.geom.Rectangle;
	import flash.text.ReturnKeyLabel;
	import flash.text.StageText;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class StarlingInput
	{
		public static const InputTypeAll:int = 1;
		public static const InputTypeEmail:int = 2;
		public static const InputTypeEnglish:int = 3;
		
		private var st:StageText;
		
		private var x:int;
		private var y:int;
		private var w:int;
		private var h:int;
		private var scale:Number;
		private var maxChars:int;
		private var back:DisplayObject;
		
		public function StarlingInput(s:String,
								back:DisplayObject,
								flashStage:flash.display.Stage,scale:Number = 1)
		{
			if(back)
			{
				this.x = back.x;this.y = back.y;
				this.w = back.width;this.h = back.height;
				this.scale = back.scaleX;
				this.back = back;
				back.addEventListener(TouchEvent.TOUCH,onTouch);
			}
			else
			{
				this.x = 100;this.y = 100;
				this.w = 200;this.h = 50;
				this.scale = scale;
			}

			st = new StageText();
			st.text = s;
			prop();
			st.viewPort = new Rectangle(scale*x,scale*y,scale*w,scale*h);

			if(flashStage)
			{
				st.stage = flashStage;
			}
			st.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE,onActive);
			st.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE,onDeactive);
		}
		private function onTouch(e:TouchEvent):void{
			var touch:Touch = e.getTouch(back);
			if(touch && touch.phase == TouchPhase.BEGAN)
			{
				assignFocus();
			}
		}
		private function onActive(e:SoftKeyboardEvent):void
		{
			
		}
		// 在输入文本完成后会进行切割
		private function onDeactive(e:SoftKeyboardEvent):void
		{
			var temp:String = st.text;
			st.text = temp.slice(0,this.maxChars);
		}
		public function addEventListener(type:String,listen:Function):void{
			st.addEventListener(type,listen);
		}
		
		public function prop(fontName:String = null,fontSize:int = 36,fontColor:uint = 0x000000,
							 maxChars:int = 6,inputType:int = InputTypeAll,isPassword:Boolean = false):void{
			st.editable = true;
			st.fontFamily = fontName;
			st.fontSize = fontSize * scale;
			st.color = fontColor;
			this.maxChars = maxChars;
			st.maxChars = maxChars * 5;
			st.returnKeyLabel = ReturnKeyLabel.DONE;
			if(inputType == InputTypeEmail)
			{
				st.restrict = "a-z A-Z 0-9 @._";
				st.softKeyboardType = "email" ;
			}
			else if(inputType == InputTypeEnglish)
			{
				st.restrict = "\u0021-\u007E";
			}
			
			if(isPassword)
				st.displayAsPassword = true;
			else
				st.displayAsPassword = false;
		}
		public function set stage(flashStage:flash.display.Stage):void{
			st.stage = flashStage;
		}
		public function set viewPort(view:Rectangle):void
		{
			st.viewPort = view;
		}
		public function remove():void
		{
			st.stage = null;
		}
		public function dispose():void{
			//trace("StarlingInput dispose");
			remove();
			if(st) st.dispose();
			st = null;
		}
		public function set text(s:String):void{
			if(st)
				st.text = s;
		}
		public function get text():String
		{
			if(st)
				return st.text;
			else
				return "Error";
		}
		public function assignFocus():void{
			if(st)
				st.assignFocus();
		}
	}
}