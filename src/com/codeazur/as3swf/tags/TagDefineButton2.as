package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFButtonCondAction;
	import com.codeazur.as3swf.data.SWFButtonRecord;
	import com.codeazur.utils.StringUtils;
	
	public class TagDefineButton2 extends Tag implements IDefinitionTag
	{
		public static const TYPE:uint = 34;
		
		public var trackAsMenu:Boolean;
		
		protected var _characterId:uint;
		protected var _characters:Vector.<SWFButtonRecord>;
		protected var _condActions:Vector.<SWFButtonCondAction>;
		
		public function TagDefineButton2() {
			_characters = new Vector.<SWFButtonRecord>();
			_condActions = new Vector.<SWFButtonCondAction>();
		}
		
		public function get characterId():uint { return _characterId; }
		public function get characters():Vector.<SWFButtonRecord> { return _characters; }
		public function get condActions():Vector.<SWFButtonCondAction> { return _condActions; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			_characterId = data.readUI16();
			trackAsMenu = ((data.readUI8() & 0x01) != 0);
			var actionOffset:uint = data.readUI16();
			var record:SWFButtonRecord;
			while ((record = data.readBUTTONRECORD(2)) != null) {
				characters.push(record);
			}
			if (actionOffset != 0) {
				var condActionSize:uint;
				do {
					condActionSize = data.readUI16();
					condActions.push(data.readBUTTONCONDACTION());
				} while(condActionSize != 0);
			}
		}
		
		public function publish(data:SWFData, version:uint):void {
			var i:uint;
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			body.writeUI8(trackAsMenu ? 0x01 : 0);
			var hasCondActions:Boolean = (condActions.length > 0); 
			var buttonRecordsBytes:SWFData = new SWFData();
			for(i = 0; i < characters.length; i++) {
				buttonRecordsBytes.writeBUTTONRECORD(characters[i], 2);
			}
			buttonRecordsBytes.writeUI8(0);
			body.writeUI16(hasCondActions ? buttonRecordsBytes.length : 0);
			body.writeBytes(buttonRecordsBytes);
			if(hasCondActions) {
				for(i = 0; i < condActions.length; i++) {
					var condActionBytes:SWFData = new SWFData();
					condActionBytes.writeBUTTONCONDACTION(condActions[i]);
					body.writeUI16(condActionBytes.length);
					body.writeBytes(condActionBytes);
				}
			}
			body.writeUI8(0);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineButton2"; }
		override public function get version():uint { return 3; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + characterId + ", TrackAsMenu: " + trackAsMenu;
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
