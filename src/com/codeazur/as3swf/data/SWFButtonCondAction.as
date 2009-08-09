package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.actions.IAction;
	import com.codeazur.utils.StringUtils;
	
	public class SWFButtonCondAction
	{
		public var condActionSize:uint;
		public var condIdleToOverDown:Boolean;
		public var condOutDownToIdle:Boolean;
		public var condOutDownToOverDown:Boolean;
		public var condOverDownToOutDown:Boolean;
		public var condOverDownToOverUp:Boolean;
		public var condOverUpToOverDown:Boolean;
		public var condOverUpToIdle:Boolean;
		public var condIdleToOverUp:Boolean;
		public var condOverDownToIdle:Boolean;
		public var condKeyPress:uint;

		protected var _actions:Vector.<IAction>;
		
		public function SWFButtonCondAction(data:SWFData = null) {
			_actions = new Vector.<IAction>();
			if (data != null) {
				parse(data);
			}
		}
		
		public function get actions():Vector.<IAction> { return _actions; }
		
		public function parse(data:SWFData):void {
			condActionSize = data.readUI16();
			var flags:uint = (data.readUI8() << 8) | data.readUI8();
			condIdleToOverDown = ((flags & 0x8000) != 0);
			condOutDownToIdle = ((flags & 0x4000) != 0);
			condOutDownToOverDown = ((flags & 0x2000) != 0);
			condOverDownToOutDown = ((flags & 0x1000) != 0);
			condOverDownToOverUp = ((flags & 0x0800) != 0);
			condOverUpToOverDown = ((flags & 0x0400) != 0);
			condOverUpToIdle = ((flags & 0x0200) != 0);
			condIdleToOverUp = ((flags & 0x0100) != 0);
			condOverDownToIdle = ((flags & 0x0001) != 0);
			condKeyPress = (flags & 0xff) >> 1;
			var action:IAction;
			while ((action = data.readACTIONRECORD()) != null) {
				_actions.push(action);
			}
		}
		
		public function toString(indent:uint = 0):String {
			var a:Array = [];
			if (condIdleToOverDown) { a.push("idleToOverDown"); }
			if (condOutDownToIdle) { a.push("outDownToIdle"); }
			if (condOutDownToOverDown) { a.push("outDownToOverDown"); }
			if (condOverDownToOutDown) { a.push("overDownToOutDown"); }
			if (condOverDownToOverUp) { a.push("overDownToOverUp"); }
			if (condOverUpToOverDown) { a.push("overUpToOverDown"); }
			if (condOverUpToIdle) { a.push("overUpToIdle"); }
			if (condIdleToOverUp) { a.push("idleToOverUp"); }
			if (condOverDownToIdle) { a.push("overDownToIdle"); }
			var str:String = "Cond: (" + a.join(",") + "), KeyPress: " + condKeyPress;
			for (var i:uint = 0; i < _actions.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + _actions[i].toString(indent + 2);
			}
			return str;
		}
	}
}
