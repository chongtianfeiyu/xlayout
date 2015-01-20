package xlayoutPanel
{
	import flash.geom.Rectangle;
	
	import feathers.controls.Label;
	import feathers.layout.TiledRowsLayout;
	
	import xlayoutSubUI.XDragPanel;
	
	public class XPicShower extends XDragPanel
	{
		public static var one:XPicShower;
		public var imgNameLabel:Label;
		public function XPicShower(titleStr:String, limit:Rectangle=null)
		{
			one=this;
			super(titleStr, limit);
			var l:TiledRowsLayout = new TiledRowsLayout();
			l.gap = 2;
			l.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
			l.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;
			l.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
			l.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
			l.useSquareTiles = false;
			layout = l;
			imgNameLabel = new Label();
			addRawChild(imgNameLabel);
		}
		public function showImgName(nn:String=null,xx:Number=0,yy:Number=0):void{
			if(nn==null){
				imgNameLabel.visible = false;
			}else{
				imgNameLabel.visible = true;
			}
			imgNameLabel.text = nn;
			imgNameLabel.x = xx;
			imgNameLabel.y = yy;
		}
	}
}