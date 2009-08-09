package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.actions.IAction;
	import com.codeazur.as3swf.data.SWFButtonCondAction;
	import com.codeazur.as3swf.data.SWFButtonRecord;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineButton2 extends Tag implements ITag
	{
		public static const TYPE:uint = 34;
		
		public var buttonId:uint;
		public var trackAsMenu:Boolean;
		
		protected var _characters:Vector.<SWFButtonRecord>;
		protected var _condActions:Vector.<SWFButtonCondAction>;
		
		public function TagDefineButton2() {
			_characters = new Vector.<SWFButtonRecord>();
			_condActions = new Vector.<SWFButtonCondAction>();
		}
		
		public function get characters():Vector.<SWFButtonRecord> { return _characters; }
		public function get condActions():Vector.<SWFButtonCondAction> { return _condActions; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			buttonId = data.readUI16();
			trackAsMenu = ((data.readUI8() & 0x01) != 0);
			var actionOffset:uint = data.readUI16();
			var record:SWFButtonRecord;
			while ((record = data.readBUTTONRECORD(2)) != null) {
				_characters.push(record);
			}
			if (actionOffset != 0) {
				while (true) {
					var condAction:SWFButtonCondAction = data.readBUTTONCONDACTION();
					_condActions.push(condAction);
					if (condAction.condActionSize == 0) {
						break;
					}
				}
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			throw(new Error("TODO: implement publish()"));
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineButton2"; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + buttonId + ", TrackAsMenu: " + trackAsMenu;
			var i:uint;
			if (_characters.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Characters:";
				for (i = 0; i < _characters.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _characters[i].toString();
				}
			}
			if (_condActions.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "CondActions:";
				for (i = 0; i < _condActions.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _condActions[i].toString(indent + 4);
				}
			}
			return str;
		}
	}
}
