package algorithems
{
	public interface IRender
	{
		function set data(dt:Object):void;
		function get data():Object;
		function render():void;
		function update():void;
		function dispose():void;
	}
}