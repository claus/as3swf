package com.codeazur.swfalizer.tags
{
	import com.codeazur.swfalizer.ISWFDataInput;
	import com.codeazur.swfalizer.actions.IAction;
	import com.codeazur.utils.StringUtils;
	
	public class TagDoAction extends Tag implements ITag
	{
		public static const TYPE:uint = 12;
		
		protected var _records:Vector.<IAction>;
		
		public function TagDoAction() {
			_records = new Vector.<IAction>();
		}
		
		public function get records():Vector.<IAction> { return _records; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			var action:IAction;
			while ((action = data.readACTIONRECORD()) != null) {
				_records.push(action);
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagDoAction]";
			for (var i:uint = 0; i < _records.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + _records[i].toString(indent + 2);
			}
			return str;
		}
	}
}
