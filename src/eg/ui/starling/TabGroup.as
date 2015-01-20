package eg.ui.starling
{
	import eg.mgr.egLogicMgr;
	import eg.module.egResModule;
	
	import starling.display.DisplayObjectContainer;
	import starling.textures.Texture;
	
	public class TabGroup extends DisplayObjectContainer
	{
		public function TabGroup(texts:Array = null,
								 normal:String = "",select:String = "",
								 defaultSelect:Boolean = true)
		{
			super();
			var res:egResModule = egLogicMgr.get().getModule("res") as egResModule;
			if(normal == "") normal = "l1btn_normal";
			normalTexture = res.getTexByName(normal);
			if(select == "") select = "l1btn_select";
			selectTexture = res.getTexByName(select);
			
			if(texts)
			for(var i:int = 0; i < texts.length; i++)
			{
				var text:String = texts[i];
				var btn:RadioButton = new RadioButton(normalTexture,text,selectTexture);
				this.addChild(btn);
				btns.push(btn);
			}
			
			if(defaultSelect && btns.length > 0)
				selectIndex(0);
		}
		
		public var normalTexture:Texture;
		public var selectTexture:Texture;
		private var btns:Array = [];
		
		// 选择某个按钮
		public function selectIndex(index:int):void{
			var btn:RadioButton;
			if(index < 0 || index >= btns.length) {trace("[Error] TabGroup selectIndex:"+index);return;}
			for(var i:int = 0; i < btns.length; i++)
			{
				btn = btns[i];
				if(index == i)
					btn.select = true;
				else
					btn.select = false;
			}
		}
		// 选择某个按钮
		public function selectName(name:String):void{
			var btn:RadioButton;
			for(var i:int = 0; i < btns.length; i++)
			{
				btn = btns[i];
				if(name == btn.name)
					btn.select = true;
				else
					btn.select = false;
			}
		}
	}
}