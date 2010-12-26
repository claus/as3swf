package com.codeazur.as3swf.tags
{
	public interface IDefinitionTag extends ITag
	{
		function get characterId():uint;
		function set characterId(value:uint):void;
		
		function get characterClass():String;
		function set characterClass(value:String):void;
	}
}