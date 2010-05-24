package com.codeazur.as3swf.data
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.consts.GradientInterpolationMode;
	import com.codeazur.as3swf.data.consts.GradientSpreadMode;
	import com.codeazur.as3swf.data.consts.LineCapsStyle;
	import com.codeazur.as3swf.data.consts.LineJointStyle;
	import com.codeazur.as3swf.data.etc.CurvedEdge;
	import com.codeazur.as3swf.data.etc.IEdge;
	import com.codeazur.as3swf.data.etc.StraightEdge;
	import com.codeazur.as3swf.exporters.DefaultShapeExporter;
	import com.codeazur.as3swf.exporters.IShapeExporter;
	import com.codeazur.as3swf.utils.ColorUtils;
	import com.codeazur.as3swf.utils.NumberUtils;
	import com.codeazur.utils.StringUtils;
	
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class SWFShape
	{
		protected var _records:Vector.<SWFShapeRecord>;

		protected var tmpFillStyles:Vector.<SWFFillStyle>;
		protected var tmpLineStyles:Vector.<SWFLineStyle>;
		protected var tmpFillEdgeMap:Dictionary;
		protected var tmpLineEdgeMap:Dictionary;

		public function SWFShape(data:SWFData = null, level:uint = 1) {
			_records = new Vector.<SWFShapeRecord>();
			if (data != null) {
				parse(data, level);
			}
		}
		
		public function get records():Vector.<SWFShapeRecord> { return _records; }

		public function getMaxFillStyleIndex():uint {
			var ret:uint = 0;
			for(var i:uint = 0; i < records.length; i++) {
				var shapeRecord:SWFShapeRecord = records[i];
				if(shapeRecord.type == SWFShapeRecord.TYPE_STYLECHANGE) {
					var shapeRecordStyleChange:SWFShapeRecordStyleChange = shapeRecord as SWFShapeRecordStyleChange;
					if(shapeRecordStyleChange.fillStyle0 > ret) {
						ret = shapeRecordStyleChange.fillStyle0;
					}
					if(shapeRecordStyleChange.fillStyle1 > ret) {
						ret = shapeRecordStyleChange.fillStyle1;
					}
					if(shapeRecordStyleChange.stateNewStyles) {
						break;
					}
				} 
			}
			return ret;
		}
		
		public function getMaxLineStyleIndex():uint {
			var ret:uint = 0;
			for(var i:uint = 0; i < records.length; i++) {
				var shapeRecord:SWFShapeRecord = records[i];
				if(shapeRecord.type == SWFShapeRecord.TYPE_STYLECHANGE) {
					var shapeRecordStyleChange:SWFShapeRecordStyleChange = shapeRecord as SWFShapeRecordStyleChange;
					if(shapeRecordStyleChange.lineStyle > ret) {
						ret = shapeRecordStyleChange.lineStyle;
					}
					if(shapeRecordStyleChange.stateNewStyles) {
						break;
					}
				} 
			}
			return ret;
		}
		
		public function parse(data:SWFData, level:uint = 1):void {
			data.resetBitsPending();
			var numFillBits:uint = data.readUB(4);
			var numLineBits:uint = data.readUB(4);
			readShapeRecords(data, numFillBits, numLineBits, level);
		}
		
		public function publish(data:SWFData, level:uint = 1):void {
			var numFillBits:uint = data.calculateMaxBits(false, [getMaxFillStyleIndex()]);
			var numLineBits:uint = data.calculateMaxBits(false, [getMaxLineStyleIndex()]);
			data.resetBitsPending();
			data.writeUB(4, numFillBits);
			data.writeUB(4, numLineBits);
			writeShapeRecords(data, numFillBits, numLineBits, level);
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

		protected function writeShapeRecords(data:SWFData, fillBits:uint, lineBits:uint, level:uint = 1):void {
			if(records.length == 0 || !(records[records.length - 1] is SWFShapeRecordEnd)) {
				records.push(new SWFShapeRecordEnd());
			}
			for(var i:uint = 0; i < records.length; i++) {
				var shapeRecord:SWFShapeRecord = records[i];
				if(shapeRecord.isEdgeRecord) {
					// EdgeRecordFlag (set)
					data.writeUB(1, 1);
					if(shapeRecord.type == SWFShapeRecord.TYPE_STRAIGHTEDGE) {
						// StraightFlag (set)
						data.writeUB(1, 1);
						data.writeSTRAIGHTEDGERECORD(SWFShapeRecordStraightEdge(shapeRecord));
					} else {
						// StraightFlag (not set)
						data.writeUB(1, 0);
						data.writeCURVEDEDGERECORD(SWFShapeRecordCurvedEdge(shapeRecord));
					}
				} else {
					// EdgeRecordFlag (not set)
					data.writeUB(1, 0);
					if(shapeRecord.type == SWFShapeRecord.TYPE_END) {
						data.writeUB(5, 0);
					} else {
						var states:uint = 0;
						var styleChangeRecord:SWFShapeRecordStyleChange = shapeRecord as SWFShapeRecordStyleChange;
						if(styleChangeRecord.stateNewStyles) { states |= 0x10; }
						if(styleChangeRecord.stateLineStyle) { states |= 0x08; }
						if(styleChangeRecord.stateFillStyle1) { states |= 0x04; }
						if(styleChangeRecord.stateFillStyle0) { states |= 0x02; }
						if(styleChangeRecord.stateMoveTo) { states |= 0x01; }
						data.writeUB(5, states);
						data.writeSTYLECHANGERECORD(styleChangeRecord, fillBits, lineBits, level);
						if (styleChangeRecord.stateNewStyles) {
							fillBits = styleChangeRecord.numFillBits;
							lineBits = styleChangeRecord.numLineBits;
						}
					}
				}
			}
		}
		
		public function export(handler:IShapeExporter = null):void {
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
			var subPath:Vector.<IEdge> = new Vector.<IEdge>();
			tmpFillEdgeMap = new Dictionary();
			tmpLineEdgeMap = new Dictionary();
			if (handler == null) { handler = new DefaultShapeExporter(null); }
			for (var i:uint = 0; i < _records.length; i++) {
				var shapeRecord:SWFShapeRecord = _records[i];
				switch(shapeRecord.type) {
					case SWFShapeRecord.TYPE_STYLECHANGE:
						var styleChangeRecord:SWFShapeRecordStyleChange = shapeRecord as SWFShapeRecordStyleChange;
						if (styleChangeRecord.stateFillStyle0 || styleChangeRecord.stateFillStyle1) {
							processSubPath(subPath, currentLineStyleIdx, currentFillStyleIdx0, currentFillStyleIdx1);
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
						from = new Point(NumberUtils.roundPixels20(xPos), NumberUtils.roundPixels20(yPos));
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
						to = new Point(NumberUtils.roundPixels20(xPos), NumberUtils.roundPixels20(yPos));
						subPath.push(new StraightEdge(from, to, currentLineStyleIdx, currentFillStyleIdx1));
						break;
					case SWFShapeRecord.TYPE_CURVEDEDGE:
						var curvedEdgeRecord:SWFShapeRecordCurvedEdge = shapeRecord as SWFShapeRecordCurvedEdge;
						from = new Point(NumberUtils.roundPixels20(xPos), NumberUtils.roundPixels20(yPos));
						var xPosControl:Number = xPos + curvedEdgeRecord.controlDeltaX / 20;
						var yPosControl:Number = yPos + curvedEdgeRecord.controlDeltaY / 20;
						xPos = xPosControl + curvedEdgeRecord.anchorDeltaX / 20;
						yPos = yPosControl + curvedEdgeRecord.anchorDeltaY / 20;
						control = new Point(xPosControl, yPosControl);
						to = new Point(NumberUtils.roundPixels20(xPos), NumberUtils.roundPixels20(yPos));
						subPath.push(new CurvedEdge(from, control, to, currentLineStyleIdx, currentFillStyleIdx1));
						break; 
					case SWFShapeRecord.TYPE_END:
						// We're done. Process the last subpath, if any
						processSubPath(subPath, currentLineStyleIdx, currentFillStyleIdx0, currentFillStyleIdx1);
						// Let the doc handler know that a shape export starts
						handler.beginShape();
						// Export fills first
						exportFillPath(handler);
						// Export strokes last
						exportLinePath(handler);
						// Let the doc handler know that we're done exporting a shape
						handler.endShape();
						break;
				}
			}
		}
		
		protected function exportFillPath(handler:IShapeExporter):void {
			var path:Vector.<IEdge> = createPathFromEdgeMap(tmpFillEdgeMap);
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
							var matrix:Matrix;
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
									matrix = fillStyle.gradientMatrix.matrix.clone();
									matrix.tx /= 20;
									matrix.ty /= 20;
									for (var gri:uint = 0; gri < fillStyle.gradient.records.length; gri++) {
										gradientRecord = fillStyle.gradient.records[gri];
										colors.push(ColorUtils.rgb(gradientRecord.color));
										alphas.push(ColorUtils.alpha(gradientRecord.color));
										ratios.push(gradientRecord.ratio);
									}
									handler.beginGradientFill(
										(fillStyle.type == 0x10) ? GradientType.LINEAR : GradientType.RADIAL,
										colors, alphas, ratios, matrix,
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
									matrix = fillStyle.bitmapMatrix.matrix.clone();
									matrix.tx /= 20;
									matrix.ty /= 20;
									handler.beginBitmapFill(
										fillStyle.bitmapId,
										matrix,
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
		
		protected function exportLinePath(handler:IShapeExporter):void {
			var path:Vector.<IEdge> = createPathFromEdgeMap(tmpLineEdgeMap);
			var pos:Point = new Point(Number.MAX_VALUE, Number.MAX_VALUE);
			var lineStyleIdx:uint = uint.MAX_VALUE;
			var lineStyle:SWFLineStyle;
			var hasLines:Boolean = false;
			var newLineStyle:Boolean = true;
			for (var i:uint = 0; i < path.length; i++) {
				var e:IEdge = path[i];
				if (!e.isDuplicate) {
					if (!hasLines) {
						handler.beginLines();
						hasLines = true;
					}
					if (lineStyleIdx != e.lineStyleIdx) {
						lineStyleIdx = e.lineStyleIdx;
						try {
							lineStyle = tmpLineStyles[lineStyleIdx - 1];
						} catch (e:Error) {
							lineStyle = null;
						}
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

							if(lineStyle.hasFillFlag) {
								var fillStyle:SWFFillStyle = lineStyle.fillType;
								switch(fillStyle.type) {
									case 0x10:
									case 0x12:
									case 0x13:
										// Gradient fill
										var colors:Array = [];
										var alphas:Array = [];
										var ratios:Array = [];
										var gradientRecord:SWFGradientRecord;
										var matrix:Matrix = fillStyle.gradientMatrix.matrix.clone();
										matrix.tx /= 20;
										matrix.ty /= 20;
										for (var gri:uint = 0; gri < fillStyle.gradient.records.length; gri++) {
											gradientRecord = fillStyle.gradient.records[gri];
											colors.push(ColorUtils.rgb(gradientRecord.color));
											alphas.push(ColorUtils.alpha(gradientRecord.color));
											ratios.push(gradientRecord.ratio);
										}
										handler.lineGradientStyle(
											(fillStyle.type == 0x10) ? GradientType.LINEAR : GradientType.RADIAL,
											colors, alphas, ratios, matrix,
											GradientSpreadMode.toString(fillStyle.gradient.spreadMode),
											GradientInterpolationMode.toString(fillStyle.gradient.interpolationMode),
											fillStyle.gradient.focalPoint
										);
										break;
								}
							}
						} else {
							// We should never get here
							handler.lineStyle(0);
						}
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
			if (hasLines) {
				handler.endLines();
			}
		}
		
		protected function createPathFromEdgeMap(edgeMap:Dictionary):Vector.<IEdge> {
			cleanEdgeMap(edgeMap);
			var newPath:Vector.<IEdge> = new Vector.<IEdge>();
			var styleIdxArray:Array = [];
			for(var styleIdx:String in edgeMap) {
				styleIdxArray.push(parseInt(styleIdx));
			}
			styleIdxArray.sort(Array.NUMERIC);
			for(var i:uint = 0; i < styleIdxArray.length; i++) {
				appendEdges(newPath, edgeMap[styleIdxArray[i]] as Vector.<IEdge>);
			}
			return newPath;
		}

		protected function processSubPath(subPath:Vector.<IEdge>, lineStyleIdx:uint, fillStyleIdx0:uint, fillStyleIdx1:uint):void {
			var j:int;
			var hasDuplicates:Boolean = (fillStyleIdx0 != 0 && fillStyleIdx1 != 0);
			var hasFill:Boolean = (fillStyleIdx0 != 0 || fillStyleIdx1 != 0);
			var path:Vector.<IEdge>;
			if (fillStyleIdx0 != 0) {
				path = tmpFillEdgeMap[fillStyleIdx0] as Vector.<IEdge>;
				if(path == null) { path = tmpFillEdgeMap[fillStyleIdx0] = new Vector.<IEdge>(); }
				for (j = subPath.length - 1; j >= 0; j--) {
					var e:IEdge = subPath[j].reverseWithNewFillStyle(fillStyleIdx0);
					e.isDuplicate = hasDuplicates;
					path.push(e);
				}
			}
			if (fillStyleIdx1 != 0) {
				path = tmpFillEdgeMap[fillStyleIdx1] as Vector.<IEdge>;
				if(path == null) { path = tmpFillEdgeMap[fillStyleIdx1] = new Vector.<IEdge>(); }
				for (j = 0; j < subPath.length; j++) {
					path.push(subPath[j]);
				}
			}
			if (lineStyleIdx != 0) {
				path = tmpLineEdgeMap[lineStyleIdx] as Vector.<IEdge>;
				if(path == null) { path = tmpLineEdgeMap[lineStyleIdx] = new Vector.<IEdge>(); }
				for (j = 0; j < subPath.length; j++) {
					path.push(subPath[j]);
				}
			}
		}

		protected function cleanEdgeMap(edgeMap:Dictionary):void {
			for(var styleIdx:String in edgeMap) {
				var subPath:Vector.<IEdge> = edgeMap[styleIdx] as Vector.<IEdge>;
				if(subPath && subPath.length > 0) {
					var i:uint;
					var from:Point;
					var coordMap:Dictionary = new Dictionary();
					for(i = 0; i < subPath.length; i++) {
						from = subPath[i].from;
						coordMap[from.x + "_" + from.y] = subPath[i];
					}
					var tmpPath:Vector.<IEdge> = new Vector.<IEdge>();
					while(subPath.length > 0) {
						var edge:IEdge = subPath[0];
						while(edge) {
							tmpPath.push(edge);
							delete coordMap[edge.from.x + "_" + edge.from.y];
							var idx:int = subPath.indexOf(edge);
							if(idx >= 0) {
								subPath.splice(idx, 1);
							}
							edge = coordMap[edge.to.x + "_" + edge.to.y] as IEdge;
						}
					}
					edgeMap[styleIdx] = tmpPath;
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

		protected function appendEdges(v1:Vector.<IEdge>, v2:Vector.<IEdge>):void {
			for (var i:uint = 0; i < v2.length; i++) {
				v1.push(v2[i]);
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = "\n" + StringUtils.repeat(indent) + "ShapeRecords:";
			for (var i:uint = 0; i < _records.length; i++) {
				str += "\n" + StringUtils.repeat(indent + 2) + _records[i].toString(indent + 2);
			}
			return str;
		}
	}
}
