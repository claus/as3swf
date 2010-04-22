package com.codeazur.as3swf
{
	import com.codeazur.as3swf.data.SWFRecordHeader;
	import com.codeazur.as3swf.factories.SWFTagFactory;
	import com.codeazur.as3swf.tags.IDefinitionTag;
	import com.codeazur.as3swf.tags.IDisplayListTag;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagPlaceObject;
	import com.codeazur.as3swf.tags.TagRemoveObject;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class SWFTimeline
	{
		protected var _tags:Vector.<ITag>;
		protected var _dictionary:Dictionary;
		protected var _frames:Vector.<SWFFrame>;
		protected var _layers:Vector.<Array>;
		
		protected var currentFrame:SWFFrame;
		
		public function SWFTimeline()
		{
			_tags = new Vector.<ITag>();
			_dictionary = new Dictionary();
			_frames = new Vector.<SWFFrame>();
			_layers = new Vector.<Array>();
		}
		
		public function get tags():Vector.<ITag> { return _tags; }
		public function get dictionary():Dictionary { return _dictionary; }
		public function get frames():Vector.<SWFFrame> { return _frames; }
		public function get layers():Vector.<Array> { return _layers; }
		
		public function getTagByCharacterId(characterId:uint):ITag {
			return tags[dictionary[characterId]];
		}
		
		public function parse(data:SWFData, version:uint):void
		{
			tags.length = 0;
			frames.length = 0;
			layers.length = 0;
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
					// If we get here there was a problem parsing this particular tag.
					// Possible SWF exploit, or obfuscated SWF.
					// TODO: register errors and warnings
					trace("WARNING: parse error: " + e.message + " (tag: " + tag.name + ", index: " + tags.length + ")");
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
		
		public function publish(data:SWFData, version:uint):void
		{
			for (var i:uint = 0; i < tags.length; i++)
			{
				try {
					tags[i].publish(data, version);
				}
				catch (e:Error) {
					var tag:ITag = tags[i];
					trace("WARNING: publish error: " + e.message + " (tag: " + tag.name + ", index: " + i + ")");
					if (tag.raw != null) {
						data.writeTagHeader(tag.type, tag.raw.length);
						data.writeBytes(tag.raw);
					} else {
						throw(e);
					}
				}
			}
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
		
		public function toString(indent:uint = 0):String {
			var i:uint;
			var str:String = "";
			if (tags.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Tags:";
				for (i = 0; i < tags.length; i++) {
					str += "\n" + tags[i].toString(indent + 4);
				}
			}
			if (frames.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Frames:";
				for (i = 0; i < frames.length; i++) {
					str += "\n" + frames[i].toString(indent + 4);
				}
			}
			/*
			if (layers.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Layers:";
				for (i = 0; i < layers.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) +
						"[" + i + "] Frames " +
						layers[i].join(", ");
				}
			}
			*/
			return str;
		}
	}
}
