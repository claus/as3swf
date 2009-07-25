package com.codeazur.as3swf.factories
{
	import com.codeazur.as3swf.data.actions.*;
	import com.codeazur.as3swf.data.actions.swf3.*;
	import com.codeazur.as3swf.data.actions.swf4.*;
	import com.codeazur.as3swf.data.actions.swf5.*;
	import com.codeazur.as3swf.data.actions.swf6.*;
	import com.codeazur.as3swf.data.actions.swf7.*;
	
	public class SWFActionFactory
	{
		public static function create(code:uint, length:uint):IAction
		{
			switch(code)
			{
				case 0x04: return new ActionNextFrame(code, length);
				case 0x05: return new ActionPreviousFrame(code, length);
				case 0x06: return new ActionPlay(code, length);
				case 0x07: return new ActionStop(code, length);
				case 0x08: return new ActionToggleQuality(code, length);
				case 0x09: return new ActionStopSounds(code, length);
				case 0x0a: return new ActionAdd(code, length);
				case 0x0b: return new ActionSubtract(code, length);
				case 0x0c: return new ActionMultiply(code, length);
				case 0x0d: return new ActionDivide(code, length);
				case 0x0e: return new ActionEquals(code, length);
				case 0x0f: return new ActionLess(code, length);
				case 0x10: return new ActionAnd(code, length);
				case 0x11: return new ActionOr(code, length);
				case 0x12: return new ActionNot(code, length);
				case 0x13: return new ActionStringEquals(code, length);
				case 0x14: return new ActionStringLength(code, length);
				case 0x15: return new ActionStringExtract(code, length);
				case 0x17: return new ActionPop(code, length);
				case 0x18: return new ActionToInteger(code, length);
				case 0x1c: return new ActionGetVariable(code, length);
				case 0x1d: return new ActionSetVariable(code, length);
				case 0x20: return new ActionSetTarget2(code, length);
				case 0x21: return new ActionStringAdd(code, length);
				case 0x22: return new ActionGetProperty(code, length);
				case 0x23: return new ActionSetProperty(code, length);
				case 0x24: return new ActionCloneSprite(code, length);
				case 0x25: return new ActionRemoveSprite(code, length);
				case 0x26: return new ActionTrace(code, length);
				case 0x27: return new ActionStartDrag(code, length);
				case 0x28: return new ActionEndDrag(code, length);
				case 0x29: return new ActionStringLess(code, length);
				case 0x2a: return new ActionThrow(code, length);
				case 0x2b: return new ActionCastOp(code, length);
				case 0x2c: return new ActionImplementsOp(code, length);
				case 0x30: return new ActionRandomNumber(code, length);
				case 0x31: return new ActionMBStringLength(code, length);
				case 0x32: return new ActionCharToAscii(code, length);
				case 0x33: return new ActionAsciiToChar(code, length);
				case 0x34: return new ActionGetTime(code, length);
				case 0x35: return new ActionMBStringExtract(code, length);
				case 0x36: return new ActionMBCharToAscii(code, length);
				case 0x37: return new ActionMBAsciiToChar(code, length);
				case 0x3a: return new ActionDelete(code, length);
				case 0x3b: return new ActionDelete2(code, length);
				case 0x3c: return new ActionDefineLocal(code, length);
				case 0x3d: return new ActionCallFunction(code, length);
				case 0x3e: return new ActionReturn(code, length);
				case 0x3f: return new ActionModulo(code, length);
				case 0x40: return new ActionNewObject(code, length);
				case 0x41: return new ActionDefineLocal2(code, length);
				case 0x42: return new ActionInitArray(code, length);
				case 0x43: return new ActionInitObject(code, length);
				case 0x44: return new ActionTypeOf(code, length);
				case 0x45: return new ActionTargetPath(code, length);
				case 0x46: return new ActionEnumerate(code, length);
				case 0x47: return new ActionAdd2(code, length);
				case 0x48: return new ActionLess2(code, length);
				case 0x49: return new ActionEquals2(code, length);
				case 0x4a: return new ActionToNumber(code, length);
				case 0x4b: return new ActionToString(code, length);
				case 0x4c: return new ActionPushDuplicate(code, length);
				case 0x4d: return new ActionStackSwap(code, length);
				case 0x4e: return new ActionGetMember(code, length);
				case 0x4f: return new ActionSetMember(code, length);
				case 0x50: return new ActionIncrement(code, length);
				case 0x51: return new ActionDecrement(code, length);
				case 0x52: return new ActionCallMethod(code, length);
				case 0x53: return new ActionNewMethod(code, length);
				case 0x54: return new ActionInstanceOf(code, length);
				case 0x55: return new ActionEnumerate2(code, length);
				case 0x60: return new ActionBitAnd(code, length);
				case 0x61: return new ActionBitOr(code, length);
				case 0x62: return new ActionBitXor(code, length);
				case 0x63: return new ActionBitLShift(code, length);
				case 0x64: return new ActionBitRShift(code, length);
				case 0x65: return new ActionBitURShift(code, length);
				case 0x66: return new ActionStrictEquals(code, length);
				case 0x67: return new ActionGreater(code, length);
				case 0x68: return new ActionStringGreater(code, length);
				case 0x69: return new ActionExtends(code, length);
				case 0x81: return new ActionGotoFrame(code, length);
				case 0x83: return new ActionGetURL(code, length);
				case 0x87: return new ActionStoreRegister(code, length);
				case 0x88: return new ActionConstantPool(code, length);
				case 0x8a: return new ActionWaitForFrame(code, length);
				case 0x8b: return new ActionSetTarget(code, length);
				case 0x8c: return new ActionGotoLabel(code, length);
				case 0x8d: return new ActionWaitForFrame2(code, length);
				case 0x8e: return new ActionDefineFunction2(code, length);
				case 0x8f: return new ActionTry(code, length);
				case 0x94: return new ActionWith(code, length);
				case 0x96: return new ActionPush(code, length);
				case 0x99: return new ActionJump(code, length);
				case 0x9a: return new ActionGetURL2(code, length);
				case 0x9b: return new ActionDefineFunction(code, length);
				case 0x9d: return new ActionIf(code, length);
				case 0x9e: return new ActionCall(code, length);
				case 0x9f: return new ActionGotoFrame2(code, length);
				default: return new ActionUnknown(code, length);
			}
		}
	}
}
