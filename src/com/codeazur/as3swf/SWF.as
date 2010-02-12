package com.codeazur.as3swf
{
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.factories.SWFTagFactory;
	import com.codeazur.as3swf.tags.IDefinitionTag;
	import com.codeazur.as3swf.tags.IDisplayListTag;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagPlaceObject;
	import com.codeazur.as3swf.tags.TagRemoveObject;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class SWF
	{
		public var version:int = 10;
		public var fileLength:uint = 0;
		public var fileLengthCompressed:uint = 0;
		public var frameSize:SWFRectangle;
		public var frameRate:Number = 50;
		public var frameCount:uint = 1;

		public var compressed:Boolean;
		
		protected var _tags:Vector.<ITag>;
		protected var _dictionary:Dictionary;
		protected var _frames:Vector.<SWFFrame>;
		protected var _layers:Vector.<Array>;
		
		protected var currentFrame:SWFFrame;
		
		public function SWF(data:ByteArray = null) {
			_tags = new Vector.<ITag>();
			_dictionary = new Dictionary();
			_frames = new Vector.<SWFFrame>();
			if (data != null) {
				loadBytes(data);
			} else {
				frameSize = new SWFRectangle();
			}
		}
		
		public function get tags():Vector.<ITag> { return _tags; }
		
		public function get dictionary():Dictionary { return _dictionary; }
		
		public function get frames():Vector.<SWFFrame> { return _frames; }
		
		public function get layers():Vector.<Array> { return _layers; }
		
		public function getTagByCharacterId(characterId:uint):ITag {
			return tags[dictionary[characterId]];
		}
		
		public function loadBytes(data:ByteArray):void {
			var swfData:SWFData = new SWFData();
			data.position = 0;
			data.readBytes(swfData, 0, data.length);
			swfData.position = 0;
			parse(swfData);
		}
		
		public function parse(data:SWFData):void {
			compressed = false;
			var signatureByte:uint = data.readUI8();
			if (signatureByte == 0x43) {
				compressed = true;
			} else if (signatureByte != 0x46) {
				throw(new Error("Not a SWF. First signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x43 or 0x46)"));
			}
			signatureByte = data.readUI8();
			if (signatureByte != 0x57) {
				throw(new Error("Not a SWF. Second signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x57)"));
			}
			signatureByte = data.readUI8();
			if (signatureByte != 0x53) {
				throw(new Error("Not a SWF. Third signature byte is 0x" + signatureByte.toString(16) + " (expected: 0x53)"));
			}
			version = data.readUI8();
			fileLength = data.readUI32();
			fileLengthCompressed = data.length;
			if (compressed) {
				// The following data (up to end of file) is compressed, if header has CWS signature
				data.swfUncompress();
			}
			frameSize = data.readRECT();
			frameRate = data.readFIXED8();
			frameCount = data.readUI16();

			tags.length = 0;
			frames.length = 0;
			_dictionary = new Dictionary();
			currentFrame = new SWFFrame();
			
			var raw:ByteArray;
			var header:SWFRecordHeader;
			var tag:ITag;
			var pos:uint;
			
			while (true)
			{
				raw = data.readRawTag();
				header = data.readTagHeader();
				tag = SWFTagFactory.create(header.type);
				pos = data.position;
				// We currently persist the raw tag to be able to publish  
				// tags that don't have publish() implemented yet.
				// This will probably go away once feature complete.
				tag.raw = raw;
				try {
					tag.parse(data, header.length, version);
				} catch(e:Error) {
					trace(e);
					// If we get here there was a problem parsing this particular tag.
					// Possible SWF exploit, or obfuscated SWF.
					// TODO: register errors and warnings
				}
				// Register parsed tag, build dictionary and display list etc
				processTag(tag);
				// Check for End tag, bail out if found.
				if (header.type == TagEnd.TYPE) {
					break;
				}
				// Adjust position (just in case the parser under- or overflows)
				if(data.position != header.length + pos) {
					trace("WARNING: excess bytes: " + (data.position - (header.length + pos)));
					data.position = header.length + pos;
				}
			}
			
			buildLayers();
		}
		
		public function publish(data:SWFData):void {
			data.writeUI8(compressed ? 0x43 : 0x46);
			data.writeUI8(0x57);
			data.writeUI8(0x53);
			data.writeUI8(version);
			var fileLengthPos:uint = data.position;
			data.writeUI32(0);
			data.writeRECT(frameSize);
			data.writeFIXED8(frameRate);
			data.writeUI16(frameCount); // TODO: get the real number of frames from the tags
			for (var i:uint = 0; i < tags.length; i++) {
				try {
					tags[i].publish(data, version);
				}
				catch (e:Error) {
					var tag:ITag = tags[i];
					trace(i,tag.name,e);
					if (tag.raw != null) {
						data.writeTagHeader(tag.type, tag.raw.length);
						data.writeBytes(tag.raw);
					} else {
						throw(e);
					}
				}
			}
			fileLength = fileLengthCompressed = data.length;
			if (compressed) {
				data.position = 8;
				data.swfCompress();
				fileLengthCompressed = data.length;
			}
			var endPos:uint = data.position;
			data.position = fileLengthPos;
			data.writeUI32(fileLength);
			data.position = endPos;
		}
		
		protected function processTag(tag:ITag):void {
			var currentTagIndex:uint = tags.length;
			// Register tag
			tags.push(tag);
			// Register definition tag in dictionary (key: character id, value: tag index)
			if(tag is IDefinitionTag) {
				var definitionTag:IDefinitionTag = tag as IDefinitionTag;
				if(definitionTag.characterId > 0) {
					dictionary[definitionTag.characterId] = currentTagIndex;
				}
			}
			// Register display list tag  
			if(tag is IDisplayListTag) {
				switch(tag.name) {
					case "ShowFrame":
						currentFrame.tagIndexEnd = currentTagIndex;
						frames.push(currentFrame);
						currentFrame = currentFrame.clone();
						currentFrame.frameNumber = frames.length;
						currentFrame.tagIndexStart = currentTagIndex + 1; 
						break;
					case "PlaceObject":
					case "PlaceObject2":
					case "PlaceObject3":
						var placeObject:TagPlaceObject = tag as TagPlaceObject;
						currentFrame.placeObject(currentTagIndex, placeObject.depth, placeObject.characterId);
						break;
					case "RemoveObject":
					case "RemoveObject2":
						var removeObject:TagRemoveObject = tag as TagRemoveObject;
						currentFrame.removeObject(removeObject.depth, removeObject.characterId);
						break;
				}
			}
		}
		
		protected function buildLayers():void {
			var i:uint;
			var depth:String;
			var depthInt:uint;
			var depths:Dictionary = new Dictionary();
			var depthsAvailable:Array = [];
			for(i = 0; i < frames.length; i++) {
				var frame:SWFFrame = frames[i];
				for(depth in frame.objects) {
					depthInt = parseInt(depth);
					if(depthsAvailable.indexOf(depthInt) > -1) {
						(depths[depth] as Array).push(frame.frameNumber);
					} else {
						depths[depth] = [frame.frameNumber];
						depthsAvailable.push(depthInt);
					}
				}
			}
			depthsAvailable.sort(Array.NUMERIC);
			_layers = new Vector.<Array>();
			for(i = 0; i < depthsAvailable.length; i++) {
				_layers.push(depths[depthsAvailable[i]]);
			}
			for(i = 0; i < frames.length; i++) {
				var frameObjs:Dictionary = frames[i].objects;
				for(depth in frameObjs) {
					SWFFrameObject(frameObjs[depth]).layer = depthsAvailable.indexOf(parseInt(depth));
				}
			}	
		}
		
		public function toString():String {
			var i:uint;
			var str:String = "[SWF]\n" +
				"  Header:\n" +
				"    Version: " + version + "\n" +
				"    FileLength: " + fileLength + "\n" +
				"    FileLengthCompressed: " + fileLengthCompressed + "\n" +
				"    FrameSize: " + frameSize.toStringSize() + "\n" +
				"    FrameRate: " + frameRate + "\n" +
				"    FrameCount: " + frameCount;
			if (tags.length > 0) {
				str += "\n  Tags:";
				for (i = 0; i < tags.length; i++) {
					str += "\n" + tags[i].toString(4);
				}
			}
			if (frames.length > 0) {
				str += "\n  Frames:";
				for (i = 0; i < frames.length; i++) {
					str += "\n" + frames[i].toString(4);
				}
			}
			/*
			if (layers.length > 0) {
				str += "\n  Layers:";
				for (i = 0; i < layers.length; i++) {
					str += "\n    [" + i + "] Frames " + layers[i].join(", ");
				}
			}
			*/
			return str;
		}
	}
}
