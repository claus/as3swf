package com.codeazur.as3swf.events {

import flash.events.Event;

public class SWFPublishEvent extends Event {

	public static const PUBLISHING_PROGRESS:String = "publishingProgress";
	public static const TAGS_PUBLISHED:String = "tagsPublished";
	public static const PUBLISH_COMPLETE:String = "publishComplete";

	private var _tagsPublished:uint;
	private var _tagsTotal:uint;

	public function SWFPublishEvent(type:String, tagsPublished:uint, tagsTotal:uint, bubbles:Boolean = false, cancelable:Boolean = false) {
		super(type, bubbles, cancelable);
		_tagsPublished = tagsPublished;
		_tagsTotal = tagsTotal;
	}

	public function get tagsPublished():uint {
		return _tagsPublished;
	}

	public function get tagsTotal():uint {
		return _tagsTotal;
	}

	override public function clone():Event {
		return new SWFPublishEvent(type, tagsPublished, tagsTotal, bubbles, cancelable);
	}
}

}
