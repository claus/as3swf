package com.codeazur.as3swf.data.actions.swf5
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.actions.*;
	import com.codeazur.utils.StringUtils;
	
	public class ActionWith extends Action implements IAction
	{
		public var withBody:Vector.<IAction>;
		
		public function ActionWith(code:uint, length:uint) {
			super(code, length);
			withBody = new Vector.<IAction>();
		}
		
		override public function parse(data:SWFData):void {
			var codeSize:uint = data.readUI16();
			var bodyEndPosition:uint = data.position + codeSize;
			while (data.position < bodyEndPosition) {
				withBody.push(data.readACTIONRECORD());
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = "[ActionWith]";
			for (var i:uint = 0; i < withBody.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + withBody[i].toString(indent + 4);
			}
			return str;
		}
	}
}
