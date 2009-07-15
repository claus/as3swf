package com.codeazur.swfalizer.data
{
	import com.codeazur.swfalizer.actions.IAction;
	
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
		
		public function SWFButtonCondAction(size:uint = 0, flags:uint = 0)
		{
			condActionSize = size;
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
			
			_actions = new Vector.<IAction>();
		}
		
		public function get actions():Vector.<IAction> { return _actions; }
		
		public function toString():String {
			return "[BUTTONCONDACTION]";
		}
	}
}
