package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.ISWFDataInput;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.utils.StringUtils;
	
	public class TagSymbolClass extends Tag implements ITag
	{
		public static const TYPE:uint = 76;
		
		protected var _symbols:Vector.<SWFSymbol>;
		
		public function TagSymbolClass() {
			_symbols = new Vector.<SWFSymbol>();
		}
		
		public function get symbols():Vector.<SWFSymbol> { return _symbols; }
		
		public function parse(data:ISWFDataInput, length:uint):void {
			var numSymbols:uint = data.readUI16();
			for (var i:uint = 0; i < numSymbols; i++) {
				_symbols.push(data.readSYMBOL());
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[" + StringUtils.printf("%02d", TYPE) + ":TagSymbolClass]";
			if (_symbols.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Symbols:";
				for (var i:uint = 0; i < _symbols.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _symbols[i].toString();
				}
			}
			return str;
		}
	}
}
