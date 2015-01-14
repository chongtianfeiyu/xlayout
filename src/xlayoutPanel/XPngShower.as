package xlayoutPanel
{
	import flash.geom.Rectangle;
	
	import feathers.layout.TiledRowsLayout;
	import xlayoutSubUI.XDragPanel;
	
	public class XPngShower extends XDragPanel
	{
		public function XPngShower(titleStr:String, limit:Rectangle=null)
		{
			super(titleStr, limit);
			var l:TiledRowsLayout = new TiledRowsLayout();
			l.gap = 2;
			l.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
			l.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;
			l.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
			l.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
			l.useSquareTiles = false;
			layout = l;
		}
	}
}