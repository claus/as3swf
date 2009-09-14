package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFFillStyle;
	import com.codeazur.as3swf.data.SWFLineStyle;
	import com.codeazur.as3swf.data.SWFShapeRecord;
	import com.codeazur.as3swf.data.SWFShapeRecordCurvedEdge;
	import com.codeazur.as3swf.data.SWFShapeRecordStraightEdge;
	import com.codeazur.as3swf.data.SWFShapeRecordStyleChange;
	import com.codeazur.as3swf.data.consts.GradientInterpolationMode;
	import com.codeazur.as3swf.data.consts.GradientSpreadMode;
	import com.codeazur.as3swf.data.consts.LineCapsStyle;
	import com.codeazur.as3swf.data.consts.LineJointStyle;
	import com.codeazur.as3swf.data.etc.IEdge;
	import com.codeazur.as3swf.data.etc.CurvedEdge;
	import com.codeazur.as3swf.data.etc.StraightEdge;
	import com.codeazur.as3swf.exporters.IShapeExportDocumentHandler;
	import com.codeazur.as3swf.exporters.DefaultShapeExportDocumentHandler;
	import com.codeazur.as3swf.utils.ColorUtils;

	import com.codeazur.utils.StringUtils;

	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	
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
			var from:Point;
			var to:Point;
			var control:Point;
			var fillStyleIdxOffset:int = 0;
			var lineStyleIdxOffset:int = 0;
			var currentFillStyleIdx0:uint = 0;
			var currentFillStyleIdx1:uint = 0;
			var currentLineStyleIdx:uint = 0;
			var path:Vector.<IEdge> = new Vector.<IEdge>();
			var subPath:Vector.<IEdge> = new Vector.<IEdge>();
			if (handler == null) { handler = new DefaultShapeExportDocumentHandler(); }
			for (var i:uint = 0; i < _records.length; i++) {
				var shapeRecord:SWFShapeRecord = _records[i];
				switch(shapeRecord.type) {
					case SWFShapeRecord.TYPE_STYLECHANGE:
						var styleChangeRecord:SWFShapeRecordStyleChange = shapeRecord as SWFShapeRecordStyleChange;
						if (styleChangeRecord.stateFillStyle0 || styleChangeRecord.stateFillStyle1) {
							processSubPath(path, subPath, currentFillStyleIdx0, currentFillStyleIdx1);
							subPath = new Vector.<IEdge>();
						}
						if (styleChangeRecord.stateNewStyles) {
							fillStyleIdxOffset = tmpFillStyles.length;
							lineStyleIdxOffset = tmpLineStyles.length;
							appendFillStyles(tmpFillStyles, styleChangeRecord.fillStyles);
							appendLineStyles(tmpLineStyles, styleChangeRecord.lineStyles);
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
						subPath.push(new StraightEdge(from, to, currentLineStyleIdx, currentFillStyleIdx1));
						break;
					case SWFShapeRecord.TYPE_CURVEDEDGE:
						var curvedEdgeRecord:SWFShapeRecordCurvedEdge = shapeRecord as SWFShapeRecordCurvedEdge;
						from = new Point(xPos, yPos);
						var xPosControl = xPos + curvedEdgeRecord.controlDeltaX / 20;
						var yPosControl = yPos + curvedEdgeRecord.controlDeltaY / 20;
						xPos = xPosControl + curvedEdgeRecord.anchorDeltaX / 20;
						yPos = yPosControl + curvedEdgeRecord.anchorDeltaY / 20;
						control = new Point(xPosControl, yPosControl);
						to = new Point(xPos, yPos);
						subPath.push(new CurvedEdge(from, control, to, currentLineStyleIdx, currentFillStyleIdx1));
						break;
					case SWFShapeRecord.TYPE_END:
						// We're done. Process the last subpath, if any
						processSubPath(path, subPath, currentFillStyleIdx0, currentFillStyleIdx1);
						// Let the doc handler know that a shape export starts
						handler.beginShape();
						// Export fills first
						exportFillPath(path, handler);
						// Export strokes last
						exportLinePath(path, handler);
						// Let the doc handler know that we're done exporting a shape
						handler.endShape();
						break;
				}
			}
		}
		
		protected function exportFillPath(fillPath:Vector.<IEdge>, handler:IShapeExportDocumentHandler):void {
			var path:Vector.<IEdge> = sortFillPath(fillPath);
			var fillStyleIdx:uint = uint.MAX_VALUE;
			var pos:Point = new Point(Number.MAX_VALUE, Number.MAX_VALUE);
			var hasFills:Boolean = false;
			var hasOpenFill:Boolean = false;
			for (var i:uint = 0; i < path.length; i++) {
				var e:IEdge = path[i];
				if (fillStyleIdx != e.fillStyleIdx) {
					fillStyleIdx = e.fillStyleIdx;
					if (fillStyleIdx == 0) {
						// Fillstyle index 0: no fill
						if (hasOpenFill) {
							handler.endFill();
							hasOpenFill = false;
						}
					} else {
						if (!hasFills) {
							handler.beginFills();
							hasFills = true;
						}
						hasOpenFill = true;
						try {
							var fillStyle:SWFFillStyle = tmpFillStyles[fillStyleIdx - 1];
							switch(fillStyle.type) {
								case 0x00:
									// Solid fill
									handler.beginFill(ColorUtils.rgb(fillStyle.rgb), ColorUtils.alpha(fillStyle.rgb));
									break;
								case 0x10:
								case 0x12:
								case 0x13:
									// Gradient fill
									var colors:Array = [];
									var alphas:Array = [];
									var ratios:Array = [];
									var gradientRecord:SWFGradientRecord;
									for (var gri:uint = 0; gri < fillStyle.gradient.records.length; gri++) {
										gradientRecord = fillStyle.gradient.records[gri];
										colors.push(ColorUtils.rgb(gradientRecord.color));
										alphas.push(ColorUtils.alpha(gradientRecord.color));
										ratios.push(gradientRecord.ratio);
									}
									handler.beginGradientFill(
										(fillStyle.type == 0x10) ? GradientType.LINEAR : GradientType.RADIAL,
										colors, alphas, ratios,
										fillStyle.gradientMatrix.matrix,
										GradientSpreadMode.toString(fillStyle.gradient.spreadMode),
										GradientInterpolationMode.toString(fillStyle.gradient.interpolationMode),
										fillStyle.gradient.focalPoint
									);
									break;
								case 0x40:
								case 0x41:
								case 0x42:
								case 0x43:
									// Bitmap fill
									handler.beginBitmapFill(
										fillStyle.bitmapId,
										fillStyle.bitmapMatrix.matrix,
										(fillStyle.type == 0x40 || fillStyle.type == 0x42),
										(fillStyle.type == 0x40 || fillStyle.type == 0x41)
									);
									break;
								default:
									hasOpenFill = false;
									break;
							}
						} catch (e:Error) {
							// Font shapes define no fillstyles per se, but do reference fillstyle index 1,
							// which represents the font color. We just report solid black in this case.
							handler.beginFill(0);
						}
					}
				}
				if (hasOpenFill) {
					if (!pos.equals(e.from)) {
						handler.moveTo(e.from.x, e.from.y);
					}
					if (e is CurvedEdge) {
						var c:CurvedEdge = CurvedEdge(e);
						handler.curveTo(c.control.x, c.control.y, c.to.x, c.to.y);
					} else {
						handler.lineTo(e.to.x, e.to.y);
					}
				}
				pos = e.to;
			}
			if (hasOpenFill) {
				handler.endFill();
			}
			if (hasFills) {
				handler.endFills();
			}
		}
		
		protected function exportLinePath(linePath:Vector.<IEdge>, handler:IShapeExportDocumentHandler):void {
			var path:Vector.<IEdge> = new Vector.<IEdge>();
			var pos:Point = new Point(Number.MAX_VALUE, Number.MAX_VALUE);
			var lineStyle:SWFLineStyle;
			var hasLines:Boolean = false;
			for (var lineStyleIdx:uint = 1; lineStyleIdx <= tmpLineStyles.length; lineStyleIdx++) {
				var newLineStyle:Boolean = true;
				try {
					lineStyle = tmpLineStyles[lineStyleIdx - 1];
				} catch (e:Error) {
					lineStyle = null;
				}
				for (var i:uint = 0; i < linePath.length; i++) {
					var e:IEdge = linePath[i];
					if (!e.isDuplicate) {
						if (e.lineStyleIdx == lineStyleIdx) {
							if (!hasLines) {
								handler.beginLines();
								hasLines = true;
							}
							if (newLineStyle) {
								if (lineStyle != null) {
									var scaleMode:String = LineScaleMode.NORMAL;
									if (lineStyle.noHScaleFlag && lineStyle.noVScaleFlag) {
										scaleMode = LineScaleMode.NONE;
									} else if (lineStyle.noHScaleFlag) {
										scaleMode = LineScaleMode.HORIZONTAL;
									} else if (lineStyle.noVScaleFlag) {
										scaleMode = LineScaleMode.VERTICAL;
									}
									handler.lineStyle(
										lineStyle.width / 20, 
										ColorUtils.rgb(lineStyle.color), 
										ColorUtils.alpha(lineStyle.color), 
										lineStyle.pixelHintingFlag,
										scaleMode,
										LineCapsStyle.toString(lineStyle.startCapsStyle),
										LineCapsStyle.toString(lineStyle.endCapsStyle),
										LineJointStyle.toString(lineStyle.jointStyle),
										lineStyle.miterLimitFactor);
								} else {
									// We should never get here
									handler.lineStyle(0);
								}
								newLineStyle = false;
							}
							if (!e.from.equals(pos)) {
								handler.moveTo(e.from.x, e.from.y);
							}
							if (e is CurvedEdge) {
								var c:CurvedEdge = CurvedEdge(e);
								handler.curveTo(c.control.x, c.control.y, c.to.x, c.to.y);
							} else {
								handler.lineTo(e.to.x, e.to.y);
							}
							pos = e.to;
						}
					}
				}
			}
			if (hasLines) {
				handler.endLines();
			}
		}
		
		protected function sortFillPath(path:Vector.<IEdge>):Vector.<IEdge> {
			var oldPath:Vector.<IEdge> = path.concat();
			var newPath:Vector.<IEdge> = new Vector.<IEdge>();
			var fillStyleIdx:uint;
			var posStart:Point;
			var i:uint;
			while (oldPath.length > 0) {
				i = 0;
				posStart = oldPath[0].from;
				fillStyleIdx = oldPath[0].fillStyleIdx;
				do {
					var e:IEdge = oldPath[i];
					if (fillStyleIdx == e.fillStyleIdx) {
						newPath.push(e);
						oldPath.splice(i, 1);
						if (posStart.equals(e.to)) {
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

		protected function processSubPath(path:Vector.<IEdge>, subPath:Vector.<IEdge>, fillStyleIdx0:uint, fillStyleIdx1:uint):void {
			var j:int;
			var hasDuplicates:Boolean = (fillStyleIdx0 != 0 && fillStyleIdx1 != 0);
			if (fillStyleIdx1 != 0 || (fillStyleIdx0 == 0 && fillStyleIdx1 == 0)) {
				for (j = 0; j < subPath.length; j++) {
					path.push(subPath[j]);
				}
			}
			if (fillStyleIdx0 != 0) {
				for (j = subPath.length - 1; j >= 0; j--) {
					var e:IEdge = subPath[j].reverseWithNewFillStyle(fillStyleIdx0);
					e.isDuplicate = hasDuplicates;
					path.push(e);
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
