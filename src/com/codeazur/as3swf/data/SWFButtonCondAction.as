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
		
		public function publish(data:SWFData):void {
			var flags1:uint = 0;
			if(condIdleToOverDown) { flags1 |= 0x80; }
			if(condOutDownToIdle) { flags1 |= 0x40; }
			if(condOutDownToOverDown) { flags1 |= 0x20; }
			if(condOverDownToOutDown) { flags1 |= 0x10; }
			if(condOverDownToOverUp) { flags1 |= 0x08; }
			if(condOverUpToOverDown) { flags1 |= 0x04; }
			if(condOverUpToIdle) { flags1 |= 0x02; }
			if(condIdleToOverUp) { flags1 |= 0x01; }
			data.writeUI8(flags1);
			var flags2:uint = condKeyPress << 1;
			if(condOverDownToIdle) { flags2 |= 0x01; }
			data.writeUI8(flags2);
			for(var i:uint = 0; i < actions.length; i++) {
				data.writeACTIONRECORD(actions[i]);
			}
			data.writeUI8(0);
		}
		
		public function clone():SWFButtonCondAction {
			var condAction:SWFButtonCondAction = new SWFButtonCondAction();
			condAction.condActionSize = condActionSize;
			condAction.condIdleToOverDown = condIdleToOverDown;
			condAction.condOutDownToIdle = condOutDownToIdle;
			condAction.condOutDownToOverDown = condOutDownToOverDown;
			condAction.condOverDownToOutDown = condOverDownToOutDown;
			condAction.condOverDownToOverUp = condOverDownToOverUp;
			condAction.condOverUpToOverDown = condOverUpToOverDown;
			condAction.condOverUpToIdle = condOverUpToIdle;
			condAction.condIdleToOverUp = condIdleToOverUp;
			condAction.condOverDownToIdle = condOverDownToIdle;
			condAction.condKeyPress = condKeyPress;
			for(var i:uint = 0; i < actions.length; i++) {
				condAction.actions.push(actions[i].clone());
			}
			return condAction;
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
