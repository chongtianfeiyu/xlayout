package
{
	import flash.utils.setTimeout;
	
	import feathers.core.FeathersControl;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	
	import xlayoutPanel.XBox;
	import xlayoutPanel.XPanelAttr;
	import xlayoutPanel.XPanelLayout;
	import xlayoutPanel.XPanelTreeSel;
	
	import xlayoutSubUI.Attr;
	import xlayoutSubUI.LabelTextInput;
	import xlayoutSubUI.XLayoutGroup;

	public class G
	{
		private static var _SkipEvent:Boolean;
		public static var res:AssetManager;
		public static var dragData:Object = null;
		public static var dropTargets:Array = [];

		public static function get SkipEvent():Boolean
		{
			return _SkipEvent;
		}

		public static function set SkipEvent(v:Boolean):void
		{
			_SkipEvent = v;
			if(v){
				setTimeout(function():void{
					_SkipEvent = false;
				},111);
			}
		}
		public static function getOBName(f:DisplayObject):Array
		{
			XPanelTreeSel.one.sel(f);
			XBox.sel(f as DisplayObjectContainer,true);
			var w:int = 302;
			var w2:int = 250;
			var h1:int = 22;
			var w3:int = 110;
			var arr:Array = [];
			function setProSelf(key:String,val:String,isNumber:Boolean):void
			{
				if(val=="") return;
				XBox.sel(f as DisplayObjectContainer,true);
				if(isNumber){
					f[key] = parseFloat(val);
				}else{
					f[key] = val;
				}
				XPanelTreeSel.one.update();
			}
			var theName:LabelTextInput = new LabelTextInput(null,w2,h1,w3,"name",setProSelf,false,LabelTextInput.TYPE_TXT);
			wrap(theName);
			function wrap(ob):void{
				theName.textInput.text = f.name+"";
			}
			arr.push(theName);
			return arr;
		}
		public static function showAttr(ob:DisplayObject):void
		{
			var arr:Array = getOBName(ob);
			var attr:Attr = ob as Attr;
			if(attr){
				var arr2:Array = attr.arr();
				for (var i:int = 0; i < arr2.length; i++){
					arr.push(arr2[i]);
				}
			}
			XPanelAttr.one.showAttr(arr);
		}
		public static function showLayoutAttr(ob:DisplayObject):void
		{
			XPanelTreeSel.one.sel(ob);
			
			XBox.sel(ob as DisplayObjectContainer,true);
			
			var f:FeathersControl = ob as FeathersControl;
			if(!f){
				return;
			}
			XPanelLayout.one.visible = true;
			
			var arr:Array;
			arr = XLayoutGroup.getLayoutSelf(ob);
			XPanelLayout.one.showAttrSelf(arr);
			
			arr = XLayoutGroup.getLayoutSub(ob);
			XPanelLayout.one.showAttrSub(arr);
		}
	}
}