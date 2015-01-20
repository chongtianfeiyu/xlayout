// 省略了TabGroup，让RadioButton在xml中配置里，就可以区分组
package eg.ui.starling
{
	import flash.utils.Dictionary;
	
	import eg.mgr.egLogicMgr;
	import eg.module.egTxtModule;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class RadioButton extends Button
	{
		public function RadioButton(upState:Texture, text:String, downState:Texture,name:String = "",defselect:Boolean = false)
		{
			// save prop
			normalTexture = upState;
			selectTexture = downState;
			this.t = text;
			this.defselect = defselect;
			var m:egTxtModule = egLogicMgr.get().getModule("txt") as egTxtModule;
			
			super(upState, m.getText(text), downState);
			
			this.name = name;
			this.scaleWhenDown = 1.0;
			this.addEventListener(Event.TRIGGERED,onTrigger);
			
			backImg = new Image(selectTexture);
			this.addChild(backImg);
			this.swapChildrenAt(0,this.numChildren-1);
			backImg.visible = false;
		}
		public static var Normal:int = 0;
		public static var AddBack:int = 1;
		
		private var _scaleWhenSelect:Number = 1.0;
		private var _renderModle:int = 0;
		
		private var t:String;
		private var normalTexture:Texture;
		private var selectTexture:Texture;
		private var isSelect:Boolean = false;
		private var backImg:Image = null;
		private var defselect:Boolean = false;
		private var groupName:String;
		static private var groups:Dictionary = new Dictionary;
		
		public function set renderModle(m:int):void{
			_renderModle = m;
			if(_renderModle == RadioButton.AddBack){
				if(isSelect)
					this.text = t;
				else
					this.text = "";
			}
		}
		public function get scaleWhenSelect():Number{
			return _scaleWhenSelect;
		}
		
		public function set scaleWhenSelect(s:Number):void{
			_scaleWhenSelect = s;
			if(_scaleWhenSelect != 1.0){
				this.pivotX = int(this.width * 0.5);
				this.pivotY = int(this.height * 0.5);
			}
		}
		public function get renderModle():int{
			return _renderModle;
		}
		
		public function set group(name:String):void{
			groupName = name;
			var rbtnArray:Array = groups[name];
			if(rbtnArray == null)
			{
				rbtnArray = new Array();
				groups[name] = rbtnArray;
			}
			if(rbtnArray.indexOf(this) == -1)
				rbtnArray.push(this);
			
			if(rbtnArray.length == 1 && defselect)
				(rbtnArray[0] as RadioButton).select = true;
		}
		
		public function set select(b:Boolean):void{
			isSelect = b;
			//trace("RadioButton:"+name+",select:"+isSelect);
			var contain:Sprite;
			var i:int;
			if(isSelect)
			{
				this.scaleX = scaleWhenSelect;
				this.scaleY = scaleWhenSelect;
				if(this.renderModle == RadioButton.Normal)
					this.upState = selectTexture;
				else if(this.renderModle == RadioButton.AddBack)
				{
					contain = this.getChildAt(1) as Sprite;
					for(i = 0; i<contain.numChildren;i++){
						if(contain.getChildAt(i) is Image){
							contain.getChildAt(i).visible = false;
						}
					}
					this.text = t;
					backImg.visible = true;
				}
			}
			else
			{
				this.scaleX = 1.0;
				this.scaleY = 1.0;
				if(this.renderModle == RadioButton.Normal)
					this.upState = normalTexture;
				else if(this.renderModle == RadioButton.AddBack)
				{
					contain = this.getChildAt(1) as Sprite;
					for(i = 0; i<contain.numChildren;i++){
						if(contain.getChildAt(i) is Image){
							contain.getChildAt(i).visible = true;
						}
					}
					this.text = "";
					backImg.visible = false;
				}
			}
		}
		
		public function get select():Boolean{
			return isSelect;
		}
		static public function selectIndex(groupName:String,index:int):void{
			var rbtnArray:Array = groups[groupName];
			if(rbtnArray)
				for(var i:int = 0;i<rbtnArray.length;i++)
				{
					if(i == index)
						(rbtnArray[i] as RadioButton).select = true;
					else
						(rbtnArray[i] as RadioButton).select = false;
				}
		}
		static public function unselectAll(groupName:String):void{
			var rbtnArray:Array = groups[groupName];
			if(rbtnArray)
				for(var i:int = 0;i<rbtnArray.length;i++)
				{
					(rbtnArray[i] as RadioButton).select = false;
				}
		}
		private function onTrigger(e:*):void{
			var rbtnArray:Array = groups[groupName];
			for(var i:int = 0;i<rbtnArray.length;i++)
			{
				var btnPtr:RadioButton = (rbtnArray[i] as RadioButton);
				if(btnPtr == this)
					btnPtr.select = true;
				else
					btnPtr.select = false;
			}
		}
	}
}