package com.codeazur.as3swf.exporters
{
	import com.akamon.evo3flash.lang.util.ByteArrayUtils;
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagDefineBitsJPEG2;
	import com.codeazur.as3swf.tags.TagDefineBitsLossless;

	import flash.display.Bitmap;

	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;

	import flash.utils.Dictionary;

	public class ImageDecoderAsync
	{
		private var swf:SWF;
		private var tags:Vector.<ITag>;
		private var items:Dictionary = new Dictionary();

		public function ImageDecoderAsync(swf:SWF)
		{
			this.swf = swf;
			this.tags = swf.tags.slice();
		}

		public function getBitmapDataFromCharacterId(id:int):BitmapData
		{
			//if (!items.hasOwnProperty(String(id))) throw(new Error("Can't find "));
			return items[id];
		}

		private function parseHeadersAsync(onDone:Function):void
		{
			while (this.tags.length > 0)
			{
				var tag:ITag = this.tags.shift();

				if (tag is TagDefineBitsJPEG2)
				{
					parseTagDefineBitsJPEG2Async(TagDefineBitsJPEG2(tag), function():void { parseHeadersAsync(onDone); });
					return;
				}
				else if (tag is TagDefineBitsLossless)
				{
					parseTagDefineBitsLosslessAsync(TagDefineBitsLossless(tag), function():void { parseHeadersAsync(onDone); });
					return;
				}
				else
				{
					continue;
				}
			}

			onDone();
		}

		private function parseTagDefineBitsJPEG2Async(tagDefineBitsJPEG2:TagDefineBitsJPEG2, onDone:Function):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				items[tagDefineBitsJPEG2.characterId] = Bitmap(LoaderInfo(e.target).content).bitmapData;
				onDone();
			})
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event):void {
				onDone();
			});
			loader.loadBytes(tagDefineBitsJPEG2.bitmapData);
		}

		private function parseTagDefineBitsLosslessAsync(tagDefineBitsLossless:TagDefineBitsLossless, onDone:Function):void
		{
			var bitmapDataByteArray:ByteArray = ByteArrayUtils.clone(tagDefineBitsLossless.zlibBitmapData);
			bitmapDataByteArray.uncompress(CompressionAlgorithm.ZLIB);
			var bitmapData:BitmapData = new BitmapData(tagDefineBitsLossless.bitmapWidth, tagDefineBitsLossless.bitmapHeight, true, 0x00000000);
			bitmapData.setPixels(bitmapData.rect, bitmapDataByteArray);
			items[tagDefineBitsLossless.characterId] = bitmapData;
			onDone();
		}

		static public function decodeAsync(swf:SWF, onDone:Function/*<ImageDecoderAsync>*/):void
		{
			var imageDecoderAsync:ImageDecoderAsync = new ImageDecoderAsync(swf);
			imageDecoderAsync.parseHeadersAsync(function():void {
				onDone(imageDecoderAsync);
			});
		}
	}
}
