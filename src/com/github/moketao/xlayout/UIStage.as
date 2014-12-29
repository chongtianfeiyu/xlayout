package com.github.moketao.xlayout
{
	import starling.display.DisplayObjectContainer;
	
	public class UIStage extends LayoutGroupBox
	{
		private var p:DisplayObjectContainer;

		public function UIStage(p:DisplayObjectContainer)
		{
			super(p);
			isRoot = true;
		}
	}
}