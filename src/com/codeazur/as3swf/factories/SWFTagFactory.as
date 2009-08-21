package com.codeazur.as3swf.factories
{
	import com.codeazur.as3swf.tags.*;
	
	public class SWFTagFactory
	{
		public static function create(type:uint):ITag
		{
			switch(type) {
				/*  0 */ case TagEnd.TYPE: return new TagEnd();
				/*  1 */ case TagShowFrame.TYPE: return new TagShowFrame();
				/*  2 */ case TagDefineShape.TYPE: return new TagDefineShape();
				/*  4 */ case TagPlaceObject.TYPE: return new TagPlaceObject();
				/*  5 */ case TagRemoveObject.TYPE: return new TagRemoveObject();
				/*  6 */ case TagDefineBits.TYPE: return new TagDefineBits();
				/*  7 */ case TagDefineButton.TYPE: return new TagDefineButton();
				/*  8 */ case TagJPEGTables.TYPE: return new TagJPEGTables();
				/*  9 */ case TagSetBackgroundColor.TYPE: return new TagSetBackgroundColor();
				/* 10 */ case TagDefineFont.TYPE: return new TagDefineFont();
				/* 11 */ case TagDefineText.TYPE: return new TagDefineText();
				/* 12 */ case TagDoAction.TYPE: return new TagDoAction();
				/* 13 */ case TagDefineFontInfo.TYPE: return new TagDefineFontInfo();
				/* 14 */ case TagDefineSound.TYPE: return new TagDefineSound();
				/* 15 */ case TagStartSound.TYPE: return new TagStartSound();
				/* 17 */ case TagDefineButtonSound.TYPE: return new TagDefineButtonSound();
				/* 18 */ case TagSoundStreamHead.TYPE: return new TagSoundStreamHead();
				/* 19 */ case TagSoundStreamBlock.TYPE: return new TagSoundStreamBlock();
				/* 20 */ case TagDefineBitsLossless.TYPE: return new TagDefineBitsLossless();
				/* 21 */ case TagDefineBitsJPEG2.TYPE: return new TagDefineBitsJPEG2();
				/* 22 */ case TagDefineShape2.TYPE: return new TagDefineShape2();
				/* 23 */ case TagDefineButtonCxform.TYPE: return new TagDefineButtonCxform();
				/* 24 */ case TagProtect.TYPE: return new TagProtect();
				/* 26 */ case TagPlaceObject2.TYPE: return new TagPlaceObject2();
				/* 28 */ case TagRemoveObject2.TYPE: return new TagRemoveObject2();
				/* 32 */ case TagDefineShape3.TYPE: return new TagDefineShape3();
				/* 33 */ case TagDefineText2.TYPE: return new TagDefineText2();
				/* 34 */ case TagDefineButton2.TYPE: return new TagDefineButton2();
				/* 35 */ case TagDefineBitsJPEG3.TYPE: return new TagDefineBitsJPEG3();
				/* 36 */ case TagDefineBitsLossless2.TYPE: return new TagDefineBitsLossless2();
				/* 37 */ case TagDefineEditText.TYPE: return new TagDefineEditText();
				/* 39 */ case TagDefineSprite.TYPE: return new TagDefineSprite();
				/* 41 */ case TagProductInfo.TYPE: return new TagProductInfo();
				/* 43 */ case TagFrameLabel.TYPE: return new TagFrameLabel();
				/* 45 */ case TagSoundStreamHead2.TYPE: return new TagSoundStreamHead2();
				/* 46 */ case TagDefineMorphShape.TYPE: return new TagDefineMorphShape();
				/* 48 */ case TagDefineFont2.TYPE: return new TagDefineFont2();
				/* 56 */ case TagExportAssets.TYPE: return new TagExportAssets();
				/* 57 */ case TagImportAssets.TYPE: return new TagImportAssets();
				/* 58 */ case TagEnableDebugger.TYPE: return new TagEnableDebugger();
				/* 59 */ case TagDoInitAction.TYPE: return new TagDoInitAction();
				/* 60 */ case TagDefineVideoStream.TYPE: return new TagDefineVideoStream();
				/* 61 */ case TagVideoFrame.TYPE: return new TagVideoFrame();
				/* 62 */ case TagDefineFontInfo2.TYPE: return new TagDefineFontInfo2();
				/* 63 */ case TagDebugID.TYPE: return new TagDebugID();
				/* 64 */ case TagEnableDebugger2.TYPE: return new TagEnableDebugger2();
				/* 65 */ case TagScriptLimits.TYPE: return new TagScriptLimits();
				/* 66 */ case TagSetTabIndex.TYPE: return new TagSetTabIndex();
				/* 69 */ case TagFileAttributes.TYPE: return new TagFileAttributes();
				/* 70 */ case TagPlaceObject3.TYPE: return new TagPlaceObject3();
				/* 71 */ case TagImportAssets2.TYPE: return new TagImportAssets2();
				/* 73 */ case TagDefineFontAlignZones.TYPE: return new TagDefineFontAlignZones();
				/* 74 */ case TagCSMTextSettings.TYPE: return new TagCSMTextSettings();
				/* 75 */ case TagDefineFont3.TYPE: return new TagDefineFont3();
				/* 76 */ case TagSymbolClass.TYPE: return new TagSymbolClass();
				/* 77 */ case TagMetadata.TYPE: return new TagMetadata();
				/* 78 */ case TagDefineScalingGrid.TYPE: return new TagDefineScalingGrid();
				/* 82 */ case TagDoABC.TYPE: return new TagDoABC();
				/* 83 */ case TagDefineShape4.TYPE: return new TagDefineShape4();
				/* 84 */ case TagDefineMorphShape2.TYPE: return new TagDefineMorphShape2();
				/* 86 */ case TagDefineSceneAndFrameLabelData.TYPE: return new TagDefineSceneAndFrameLabelData();
				/* 87 */ case TagDefineBinaryData.TYPE: return new TagDefineBinaryData();
				/* 88 */ case TagDefineFontName.TYPE: return new TagDefineFontName();
				/* 89 */ case TagStartSound2.TYPE: return new TagStartSound2();
				/* 90 */ case TagDefineBitsJPEG4.TYPE: return new TagDefineBitsJPEG4();
				/* 91 */ case TagDefineFont4.TYPE: return new TagDefineFont4();
				default: return new TagUnknown(type);
			}
		}
	}
}
