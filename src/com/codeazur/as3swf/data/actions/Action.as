package com.codeazur.as3swf.data.actions
{
	import com.codeazur.as3swf.SWFData;
	
	public class Action implements IAction
	{
		protected var _code:uint;
		protected var _length:uint;
		protected var _pos:uint;
		
		public function Action(code:uint, length:uint, pos:uint) {
			_code = code;
			_length = length;
			_pos = pos;
		}

		public function get code():uint { return _code; }
		public function get length():uint { return _length; }
		public function get lengthWithHeader():uint { return _length + (_code >= 0x80 ? 3 : 1); }
		public function get pos():uint { return _pos; }
		
		public function parse(data:SWFData):void {
			// Do nothing. Many Actions don't have a payload. 
			// For the ones that have one we override this method.
		}
		
		public function publish(data:SWFData):void {
			write(data);
		}
		
		public function clone():IAction {
			return new Action(code, length, pos);
		}
		
		protected function write(data:SWFData, body:SWFData = null):void {
			data.writeUI8(code);
			if (code >= 0x80) {
				if (body != null && body.length > 0) {
					_length = body.length;
					data.writeUI16(_length);
					data.writeBytes(body);
				} else {
					_length = 0;
					throw(new Error("Action body null or empty."));
				}
			} else {
				_length = 0;
			}
		}
		
		public function toString(indent:uint = 0):String {
			return "[Action] Code: " + _code.toString(16) + ", Length: " + _length;
		}
		
		public static function resolveOffsets(actions:Vector.<IAction>):void {
			var action:IAction;
			var n:uint = actions.length;
			for (var i:uint = 0; i < n; i++) {
				action = actions[i];
				if (action is IActionBranch) {
					var j:int;
					var found:Boolean = false;
					var actionBranch:IActionBranch = action as IActionBranch;
					var targetPos:uint = actionBranch.pos + actionBranch.lengthWithHeader + actionBranch.branchOffset;
					if (targetPos <= actionBranch.pos) {
						for (j = i; j >= 0; j--) {
							if (targetPos == actions[j].pos) {
								found = true;
								break;
							}
						}
					} else {
						for (j = i + 1; j < n; j++) {
							if (targetPos == actions[j].pos) {
								found = true;
								break;
							}
						}
						if (!found) {
							action = actions[j - 1];
							if (targetPos == action.pos + action.lengthWithHeader) {
								j = -1; // End of execution block
								found = true;
							}
						}
					}
					actionBranch.branchIndex = found ? j : -2;
				}
			}
		}
	}
}
