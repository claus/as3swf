package com.codeazur.as3swf.data.actions.swf4
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFActionValue;
	import com.codeazur.as3swf.data.actions.*;
	import com.codeazur.utils.StringUtils;
	
	public class ActionPush extends Action implements IAction
	{
		public var values:Vector.<SWFActionValue>;
		
		public function ActionPush(code:uint, length:uint) {
			super(code, length);
			values = new Vector.<SWFActionValue>();
		}
		
		override public function parse(data:SWFData):void {
			var endPosition:uint = data.position + _length;
			while (data.position != endPosition) {
				values.push(data.readACTIONVALUE());
			}
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionPush] " + values.join(", ");
		}
	}
}
