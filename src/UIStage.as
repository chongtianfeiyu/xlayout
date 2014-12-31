package 
{
	import starling.display.DisplayObjectContainer;
	
	public class UIStage extends XLayoutGroup
	{
		private var p:DisplayObjectContainer;

		public function UIStage(p:DisplayObjectContainer)
		{
			super(p);
			isRoot = true;
		}
	}
}