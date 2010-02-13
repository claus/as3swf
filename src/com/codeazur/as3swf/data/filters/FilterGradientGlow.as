package com.codeazur.as3swf.data.filters
{
	import com.codeazur.as3swf.SWFData;
	
	public class FilterGradientGlow extends Filter implements IFilter
	{
		public var numColors:uint;
		public var glowColor:uint;
		public var blurX:Number;
		public var blurY:Number;
		public var strength:Number;
		public var innerShadow:Boolean;
		public var knockout:Boolean;
		public var compositeSource:Boolean;
		public var onTop:Boolean;
		public var passes:uint;
		
		protected var _gradientColors:Vector.<uint>;
		protected var _gradientRatios:Vector.<uint>;
		
		public function FilterGradientGlow(id:uint) {
			super(id);
			_gradientColors = new Vector.<uint>();
			_gradientRatios = new Vector.<uint>();
		}
		
		public function get gradientColors():Vector.<uint> { return _gradientColors; }
		public function get gradientRatios():Vector.<uint> { return _gradientRatios; }
		
		override public function parse(data:SWFData):void {
			numColors = data.readUI8();
			var i:uint;
			for (i = 0; i < numColors; i++) {
				_gradientColors.push(data.readRGBA());
			}
			for (i = 0; i < numColors; i++) {
				_gradientRatios.push(data.readUI8());
			}
			blurX = data.readFIXED();
			blurY = data.readFIXED();
			strength = data.readFIXED8();
			var flags:uint = data.readUI8();
			innerShadow = ((flags & 0x80) != 0);
			knockout = ((flags & 0x40) != 0);
			compositeSource = ((flags & 0x20) != 0);
			onTop = ((flags & 0x20) != 0);
			passes = flags & 0x0f;
		}
		
		override public function publish(data:SWFData):void {
			numColors = data.readUI8();
			data.writeUI8(numColors);
			var i:uint;
			for (i = 0; i < numColors; i++) {
				data.writeRGBA(gradientColors[i]);
			}
			for (i = 0; i < numColors; i++) {
				data.writeUI8(gradientRatios[i]);
			}
			data.writeFIXED(blurX);
			data.writeFIXED(blurY);
			data.writeFIXED8(strength);
			var flags:uint = (passes & 0x0f);
			if(innerShadow) { flags |= 0x80; }
			if(knockout) { flags |= 0x40; }
			if(compositeSource) { flags |= 0x20; }
			if(onTop) { flags |= 0x10; }
			data.writeUI8(flags);
		}
	}
}
