package conponents
{
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	public class SQLManager extends EventDispatcher
	{
		private static var _instance:SQLManager;
		public static function instance():SQLManager {
			if(!_instance){
				_instance = new SQLManager();
			}
			return _instance;
		}
		
		public function SQLManager(target:IEventDispatcher=null)
		{
			super(target);
			connectSQL();
		}
		
		
		private var _con:SQLConnection;
		private var _statement:SQLStatement;
		private function connectSQL():void {
			new SQLConnection();
			_con.addEventListener(SQLEvent.OPEN , detectOpen);
			_con.addEventListener(SQLErrorEvent.ERROR , detectError);
			_con.addEventListener(SQLEvent.CLOSE , detectClose);
			var dataFile:File = File.applicationDirectory.resolvePath("sqlData.db");
			try{
				_con.open(dataFile,SQLMode.CREATE);
			}catch(e:SQLError){
				trace(e);
			}
		}
		
		protected function detectClose(event:SQLEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function detectError(event:SQLErrorEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function detectOpen(event:SQLEvent):void
		{
			// TODO Auto-generated method stub
			if(!_statement){
				_statement = new SQLStatement();
				_statement.sqlConnection = _con;
			}
		}
	}
}