package com.codeazur.as3swf.data.filters
{
	public class FilterGradientBevel extends FilterGradientGlow implements IFilter
	{
		public function FilterGradientBevel(id:uint) {
			super(id);
		}
		
		override public function clone():IFilter {
			var filter:FilterGradientBevel = new FilterGradientBevel(id);
			filter.numColors = numColors;
			var i:uint;
			for (i = 0; i < numColors; i++) {
				filter.gradientColors.push(gradientColors[i]);
			}
			for (i = 0; i < numColors; i++) {
				filter.gradientRatios.push(gradientRatios[i]);
			}
			filter.blurX = blurX;
			filter.blurY = blurY;
			filter.strength = strength;
			filter.passes = passes;
			filter.innerShadow = innerShadow;
			filter.knockout = knockout;
			filter.compositeSource = compositeSource;
			filter.onTop = onTop;
			return filter;
		}
		
		override protected function get filterName():String { return "GradientBevelFilter"; }
	}
}
