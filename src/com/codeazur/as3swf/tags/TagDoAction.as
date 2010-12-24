package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.actions.IAction;
	import com.codeazur.utils.StringUtils;
	
	public class TagDoAction implements ITag
	{
		public static const TYPE:uint = 12;
		
		protected var _actions:Vector.<IAction>;
		
		public function TagDoAction() {
			_actions = new Vector.<IAction>();
		}
		
		public function get actions():Vector.<IAction> { return _actions; }
		
		public function parse(data:SWFData, length:uint, version:uint, async:Boolean = false):void {
			var action:IAction;
			while ((action = data.readACTIONRECORD()) != null) {
				_actions.push(action);
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			for (var i:uint = 0; i < _actions.length; i++) {
				body.writeACTIONRECORD(_actions[i]);
			}
			body.writeUI8(0);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		public function get type():uint { return TYPE; }
		public function get name():String { return "DoAction"; }
		public function get version():uint { return 3; }
		public function get level():uint { return 1; }
	
		public function toString(indent:uint = 0):String {
			var str:String = Tag.toStringCommon(type, name, indent);
			for (var i:uint = 0; i < _actions.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + _actions[i].toString(indent + 2);
			}
			return str;
		}
	}
}
