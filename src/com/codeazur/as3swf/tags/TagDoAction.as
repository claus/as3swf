package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.actions.IAction;
	import com.codeazur.utils.StringUtils;
	
	public class TagDoAction extends Tag implements ITag
	{
		public static const TYPE:uint = 12;
		
		protected var _records:Vector.<IAction>;
		
		public function TagDoAction() {
			_records = new Vector.<IAction>();
		}
		
		public function get records():Vector.<IAction> { return _records; }
		
		public function parse(data:SWFData, length:uint):void {
			cache(data, length);
			var action:IAction;
			while ((action = data.readACTIONRECORD()) != null) {
				_records.push(action);
			}
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DoAction"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent);
			for (var i:uint = 0; i < _records.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + _records[i].toString(indent + 2);
			}
			return str;
		}
	}
}
