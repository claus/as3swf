package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.actions.IAction;
	import com.codeazur.as3swf.data.SWFButtonRecord;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.data.SWFShapeWithStyle;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineButton extends Tag implements ITag
	{
		public static const TYPE:uint = 7;
		
		public var buttonId:uint;

		protected var _characters:Vector.<SWFButtonRecord>;
		protected var _actions:Vector.<IAction>;
		
		public function TagDefineButton() {
			_characters = new Vector.<SWFButtonRecord>();
			_actions = new Vector.<IAction>();
		}
		
		public function get characters():Vector.<SWFButtonRecord> { return _characters; }
		public function get actions():Vector.<IAction> { return _actions; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			buttonId = data.readUI16();
			var record:SWFButtonRecord;
			while ((record = data.readBUTTONRECORD()) != null) {
				_characters.push(record);
			}
			var action:IAction;
			while ((action = data.readACTIONRECORD()) != null) {
				_actions.push(action);
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineButton"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + buttonId;
			var i:uint;
			if (_characters.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Characters:";
				for (i = 0; i < _characters.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _characters[i].toString();
				}
			}
			if (_actions.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Actions:";
				for (i = 0; i < _actions.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _actions[i].toString(indent + 4);
				}
			}
			return str;
		}
	}
}
