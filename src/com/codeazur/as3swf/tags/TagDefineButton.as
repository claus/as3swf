package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFButtonRecord;
	import com.codeazur.as3swf.data.actions.IAction;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.Dictionary;
	
	public class TagDefineButton extends Tag implements IDefinitionTag
	{
		public static const TYPE:uint = 7;
		
		public static const STATE_UP:String = "up"; 
		public static const STATE_OVER:String = "over"; 
		public static const STATE_DOWN:String = "down"; 
		public static const STATE_HIT:String = "hit"; 
		
		protected var _characterId:uint;
		protected var _characters:Vector.<SWFButtonRecord>;
		protected var _actions:Vector.<IAction>;
		
		protected var _frames:Dictionary;
		
		public function TagDefineButton() {
			_characters = new Vector.<SWFButtonRecord>();
			_actions = new Vector.<IAction>();
			_frames = new Dictionary();
		}
		
		public function get characterId():uint { return _characterId; }
		public function get characters():Vector.<SWFButtonRecord> { return _characters; }
		public function get actions():Vector.<IAction> { return _actions; }
		
		public function parse(data:SWFData, length:uint, version:uint):void {
			_characterId = data.readUI16();
			var record:SWFButtonRecord;
			while ((record = data.readBUTTONRECORD()) != null) {
				_characters.push(record);
			}
			var action:IAction;
			while ((action = data.readACTIONRECORD()) != null) {
				_actions.push(action);
			}
			processRecords();
		}
		
		public function publish(data:SWFData, version:uint):void {
			var i:uint;
			var body:SWFData = new SWFData();
			body.writeUI16(characterId);
			for(i = 0; i < characters.length; i++) {
				data.writeBUTTONRECORD(characters[i]);
			}
			data.writeUI8(0);
			for(i = 0; i < actions.length; i++) {
				data.writeACTIONRECORD(actions[i]);
			}
			data.writeUI8(0);
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}
		
		public function getRecordsByState(state:String):Vector.<SWFButtonRecord> {
			return _frames[state] as Vector.<SWFButtonRecord>;
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "DefineButton"; }
		override public function get version():uint { return 1; }
		
		protected function processRecords():void {
			var upState:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
			var overState:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
			var downState:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
			var hitState:Vector.<SWFButtonRecord> = new Vector.<SWFButtonRecord>();
			for(var i:uint = 0; i < characters.length; i++) {
				var record:SWFButtonRecord = characters[i];
				if(record.stateUp) { upState.push(record); }
				if(record.stateOver) { overState.push(record); }
				if(record.stateDown) { downState.push(record); }
				if(record.stateHitTest) { hitState.push(record); }
			}
			_frames[STATE_UP] = upState.sort(sortByDepthCompareFunction);
			_frames[STATE_OVER] = overState.sort(sortByDepthCompareFunction);
			_frames[STATE_DOWN] = downState.sort(sortByDepthCompareFunction);
			_frames[STATE_HIT] = hitState.sort(sortByDepthCompareFunction);
		}
		
		protected function sortByDepthCompareFunction(a:SWFButtonRecord, b:SWFButtonRecord):Number {
			if(a.placeDepth < b.placeDepth) {
				return -1;
			} else if(a.placeDepth > b.placeDepth) {
				return 1;
			} else {
				return 0;
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent) +
				"ID: " + _characterId;
			var i:uint;
			if (_characters.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Characters:";
				for (i = 0; i < _characters.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _characters[i].toString(indent + 4);
				}
			}
			if (_actions.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Actions:";
				for (i = 0; i < _actions.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _actions[i].toString(indent + 4);
				}
			}
			return str;
		}
	}
}
