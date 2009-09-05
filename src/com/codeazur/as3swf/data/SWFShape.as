package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFFillStyle;
	import com.codeazur.as3swf.data.SWFLineStyle;
	import com.codeazur.as3swf.data.SWFShapeRecord;
	import com.codeazur.as3swf.data.SWFShapeRecordCurvedEdge;
	import com.codeazur.as3swf.data.SWFShapeRecordStraightEdge;
	import com.codeazur.as3swf.data.SWFShapeRecordStyleChange;
	import com.codeazur.as3swf.data.etc.IEdge;
	import com.codeazur.as3swf.data.etc.IShapeExportDocumentHandler;
	import com.codeazur.as3swf.data.etc.CurvedEdge;
	import com.codeazur.as3swf.data.etc.StraightEdge;
	import com.codeazur.as3swf.data.etc.DefaultShapeExportDocumentHandler;
	import com.codeazur.as3swf.utils.ColorUtils;
	import com.codeazur.utils.StringUtils;

	import flash.geom.Point;
	
	public class SWFShape
	{
		protected var _records:Vector.<SWFShapeRecord>;

		protected var tmpFillStyles:Vector.<SWFFillStyle>;
		protected var tmpLineStyles:Vector.<SWFLineStyle>;

		public function SWFShape(data:SWFData = null, level:uint = 1) {
			_records = new Vector.<SWFShapeRecord>();
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function get records():Vector.<SWFShapeRecord> { return _records; }

		public function parse(data:SWFData, level:uint = 1):void {
			data.resetBitsPending();
			var numFillBits:uint = data.readUB(4);
			var numLineBits:uint = data.readUB(4);
			readShapeRecords(data, numFillBits, numLineBits, level);
		}
		
		protected function readShapeRecords(data:SWFData, fillBits:uint, lineBits:uint, level:uint = 1):void {
			var shapeRecord:SWFShapeRecord;
			while (!(shapeRecord is SWFShapeRecordEnd)) {
				// The SWF10 spec says that shape records are byte aligned.
				// In reality they seem not to be?
				// bitsPending = 0;
				var edgeRecord:Boolean = (data.readUB(1) == 1);
				if (edgeRecord) {
					var straightFlag:Boolean = (data.readUB(1) == 1);
					var numBits:uint = data.readUB(4) + 2;
					if (straightFlag) {
						shapeRecord = data.readSTRAIGHTEDGERECORD(numBits);
					} else {
						shapeRecord = data.readCURVEDEDGERECORD(numBits);
					}
				} else {
					var states:uint = data.readUB(5);
					if (states == 0) {
						shapeRecord = new SWFShapeRecordEnd();
					} else {
						var styleChangeRecord:SWFShapeRecordStyleChange = data.readSTYLECHANGERECORD(states, fillBits, lineBits, level);
						if (styleChangeRecord.stateNewStyles) {
							// TODO: We might have to update fillStyles and lineStyles too
							fillBits = styleChangeRecord.numFillBits;
							lineBits = styleChangeRecord.numLineBits;
						}
						shapeRecord = styleChangeRecord;
					}
				}
				_records.push(shapeRecord);
			}
		}

		public function export(handler:IShapeExportDocumentHandler = null):void {
			var xPos:Number = 0;
			var yPos:Number = 0;
			var fillStyleIdxOffset:int = 0;
			var lineStyleIdxOffset:int = 0;
			var currentFillStyleIdx0:uint = 0;
			var currentFillStyleIdx1:uint = 0;
			var currentLineStyleIdx:uint = 0;
			var path:Vector.<IEdge> = new Vector.<IEdge>();
			var subpath:Vector.<IEdge> = new Vector.<IEdge>();
			if (handler == null) {
				handler = new DefaultShapeExportDocumentHandler();
			}
			for (var i:uint = 0; i < _records.length; i++) {
				var from:Point;
				var to:Point;
				var shapeRecord:SWFShapeRecord = _records[i];
				switch(shapeRecord.type) {
					case SWFShapeRecord.TYPE_STYLECHANGE:
						var styleChangeRecord:SWFShapeRecordStyleChange = shapeRecord as SWFShapeRecordStyleChange;
						if (styleChangeRecord.stateFillStyle0 || styleChangeRecord.stateFillStyle1) {
							processSubPath(path, subpath, currentFillStyleIdx0, currentFillStyleIdx1);
							subpath = new Vector.<IEdge>();
						}
						if (styleChangeRecord.stateNewStyles) {
							appendFillStyles(tmpFillStyles, styleChangeRecord.fillStyles);
							appendLineStyles(tmpLineStyles, styleChangeRecord.lineStyles);
							fillStyleIdxOffset += styleChangeRecord.fillStyles.length;
							fillStyleIdxOffset += styleChangeRecord.lineStyles.length;
						}
						if (styleChangeRecord.stateLineStyle) {
							currentLineStyleIdx = styleChangeRecord.lineStyle;
							if (currentLineStyleIdx > 0) {
								currentLineStyleIdx += lineStyleIdxOffset;
							}
						}
						if (styleChangeRecord.stateFillStyle0) {
							currentFillStyleIdx0 = styleChangeRecord.fillStyle0;
							if (currentFillStyleIdx0 > 0) {
								currentFillStyleIdx0 += fillStyleIdxOffset;
							}
						}
						if (styleChangeRecord.stateFillStyle1) {
							currentFillStyleIdx1 = styleChangeRecord.fillStyle1;
							if (currentFillStyleIdx1 > 0) {
								currentFillStyleIdx1 += fillStyleIdxOffset;
							}
						}
						if (styleChangeRecord.stateMoveTo) {
							xPos = styleChangeRecord.moveDeltaX / 20;
							yPos = styleChangeRecord.moveDeltaY / 20;
						}
						break;
					case SWFShapeRecord.TYPE_STRAIGHTEDGE:
						var straightEdgeRecord:SWFShapeRecordStraightEdge = shapeRecord as SWFShapeRecordStraightEdge;
						from = new Point(xPos, yPos);
						if (straightEdgeRecord.generalLineFlag) {
							xPos += straightEdgeRecord.deltaX / 20;
							yPos += straightEdgeRecord.deltaY / 20;
						} else {
							if (straightEdgeRecord.vertLineFlag) {
								yPos += straightEdgeRecord.deltaY / 20;
							} else {
								xPos += straightEdgeRecord.deltaX / 20;
							}
						}
						to = new Point(xPos, yPos);
						subpath.push(new StraightEdge(from, to, currentLineStyleIdx, currentFillStyleIdx1));
						break;
					case SWFShapeRecord.TYPE_CURVEDEDGE:
						var curvedEdgeRecord:SWFShapeRecordCurvedEdge = shapeRecord as SWFShapeRecordCurvedEdge;
						from = new Point(xPos, yPos);
						var xPosControl = xPos + curvedEdgeRecord.controlDeltaX / 20;
						var yPosControl = yPos + curvedEdgeRecord.controlDeltaY / 20;
						xPos = xPosControl + curvedEdgeRecord.anchorDeltaX / 20;
						yPos = yPosControl + curvedEdgeRecord.anchorDeltaY / 20;
						var control:Point = new Point(xPosControl, yPosControl);
						to = new Point(xPos, yPos);
						subpath.push(new CurvedEdge(from, control, to, currentLineStyleIdx, currentFillStyleIdx1));
						break;
					case SWFShapeRecord.TYPE_END:
						processSubPath(path, subpath, currentFillStyleIdx0, currentFillStyleIdx1);
						processPath(path, handler);
						break;
				}
			}
		}
		
		protected function processPath(path:Vector.<IEdge>, handler:IShapeExportDocumentHandler):void {
			var xPos:Number = Number.MAX_VALUE;
			var yPos:Number = Number.MAX_VALUE;
			var fillStyleIdx:uint = uint.MAX_VALUE;
			var lineStyleIdx:uint = uint.MAX_VALUE;
			var hasOpenFill:Boolean = false;
			path = sortPath(path);
			for (var i:uint = 0; i < path.length; i++) {
				var e:IEdge = path[i];
				if (lineStyleIdx != e.lineStyleIdx) {
					lineStyleIdx = e.lineStyleIdx;
					if (lineStyleIdx == 0) {
						handler.lineStyle();
					} else {
						var lineStyle:SWFLineStyle = tmpLineStyles[lineStyleIdx - 1];
						handler.lineStyle(lineStyle.width / 20, ColorUtils.rgb(lineStyle.color), ColorUtils.alpha(lineStyle.color));
					}
				}
				if (fillStyleIdx != e.fillStyleIdx) {
					fillStyleIdx = e.fillStyleIdx;
					if (fillStyleIdx == 0) {
						if (hasOpenFill) {
							handler.endFill();
							hasOpenFill = false;
						}
					} else {
						var fillStyle:SWFFillStyle = tmpFillStyles[fillStyleIdx - 1];
						handler.beginFill(ColorUtils.rgb(fillStyle.rgb), ColorUtils.alpha(fillStyle.rgb));
						hasOpenFill = true;
					}
				}
				if (xPos != e.from.x || yPos != e.from.y) {
					handler.moveTo(e.from.x, e.from.y);
				}
				if (e is CurvedEdge) {
					var c:CurvedEdge = CurvedEdge(e);
					handler.curveTo(c.control.x, c.control.y, c.to.x, c.to.y);
				} else {
					handler.lineTo(e.to.x, e.to.y);
				}
				xPos = e.to.x;
				yPos = e.to.y;
			}
			if (hasOpenFill) {
				handler.endFill();
			}
		}
		
		protected function sortPath(path:Vector.<IEdge>):Vector.<IEdge> {
			var oldPath:Vector.<IEdge> = path.concat();
			var newPath:Vector.<IEdge> = new Vector.<IEdge>();
			var xPosStart:Number = Number.MAX_VALUE;
			var yPosStart:Number = Number.MAX_VALUE;
			var fillStyleIdx:uint;
			var i:uint;
			while (oldPath.length > 0) {
				i = 0;
				xPosStart = oldPath[0].from.x;
				yPosStart = oldPath[0].from.y;
				fillStyleIdx = oldPath[0].fillStyleIdx;
				do {
					var e:IEdge = oldPath[i];
					if (fillStyleIdx == e.fillStyleIdx) {
						newPath.push(e);
						oldPath.splice(i, 1);
						if (xPosStart == e.to.x && yPosStart == e.to.y) {
							// The end point of the current edge matches the start point of the subshape
							// That means that the subshape is closed and complete.
							// Bail out of the inner loop, continue with next subshape.
							break;
						}
					} else {
						i++;
					}
				}
				while (i < oldPath.length);
			}
			return newPath;
		}

		protected function processSubPath(path:Vector.<IEdge>, subpath:Vector.<IEdge>, fillStyleIdx0:uint, fillStyleIdx1:uint):void {
			var j:int;
			if (fillStyleIdx1 != 0 || (fillStyleIdx0 == 0 && fillStyleIdx1 == 0)) {
				for (j = 0; j < subpath.length; j++) {
					path.push(subpath[j]);
				}
			}
			if (fillStyleIdx0 != 0) {
				for (j = subpath.length - 1; j >= 0; j--) {
					path.push(subpath[j].reverseWithNewFillStyle(fillStyleIdx0));
				}
			}
		}
		
		protected function appendFillStyles(v1:Vector.<SWFFillStyle>, v2:Vector.<SWFFillStyle>):void {
			for (var i:uint = 0; i < v2.length; i++) {
				v1.push(v2[i]);
			}
		}
		
		protected function appendLineStyles(v1:Vector.<SWFLineStyle>, v2:Vector.<SWFLineStyle>):void {
			for (var i:uint = 0; i < v2.length; i++) {
				v1.push(v2[i]);
			}
		}

		public function toString(indent:uint = 0):String {
			var str:String = "\n" + StringUtils.repeat(indent) + "Shapes:";
			for (var i:uint = 0; i < _records.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + _records[i].toString(indent + 2);
			}
			return str;
		}
	}
}
