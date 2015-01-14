package xlayoutPanel
{
	import feathers.controls.Alert;
	import feathers.data.ListCollection;

	public class XAlert
	{
		public static function show(s:String):void
		{
			Alert.show(s,"提示", new ListCollection([ { label: "OK" }]));
		}
	}
}