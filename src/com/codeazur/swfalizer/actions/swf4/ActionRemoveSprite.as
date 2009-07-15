package com.codeazur.swfalizer.actions.swf4
{
	import com.codeazur.swfalizer.actions.*;
	
	public class ActionRemoveSprite extends Action implements IAction
	{
		public function ActionRemoveSprite(code:uint, length:uint) {
			super(code, length);
		}
		
		public function toString(indent:uint = 0):String {
			return "[ActionRemoveSprite]";
		}
	}
}
