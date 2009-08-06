# as3swf

as3swf is a low level Actionscript 3 library to parse, create, modify and publish SWF files.

Alpha version, under active development.

## Supported SWF tags:

	ID	Read	Write	Name
	0	x	x	End	
	1	x	x	ShowFrame	
	2	x		DefineShape	
	4	x		PlaceObject	
	5	x		RemoveObject	
	6	x	x	DefineBits	
	7	x		DefineButton	
	8	x		JPEGTables	
	9	x		SetBackgroundColor	
	10	x		DefineFont	
	11	x		DefineText	
	12	x		DoAction	
	13	x		DefineFontInfo	
	14	x		DefineSound	
	15	x		StartSound	
	17	x		DefineButtonSound	
	18	x		SoundStreamHead	
	19	x		SoundStreamBlock	
	20	x	x	DefineBitsLossless	
	21	x	x	DefineBitsJPEG2	
	22	x		DefineShape2	
	23	x		DefineButtonCxform	
	24	x		Protect	
	26	x		PlaceObject2	
	28	x		RemoveObject2	
	32	x		DefineShape3	
	33	x		DefineText2	
	34	x		DefineButton2	
	35	x	x	DefineBitsJPEG3	
	36	x	x	DefineBitsLossless2	
	37	x		DefineEditText	
	39	x	x	DefineSprite	
	43	x		FrameLabel	
	45	x		SoundStreamHead2	
	46	x		DefineMorphShape	
	48	x		DefineFont2	
	56	x	x	ExportAssets	
	57	x	x	ImportAssets	
	58	x		EnableDebugger	
	59	x		DoInitAction	
	60			DefineVideoStream	
	61			VideoFrame	
	62			DefineFontInfo2	
	64			EnableDebugger2	
	65			ScriptLimits	
	66			SetTabIndex	
	69	x	x	FileAttributes	
	70			PlaceObject3	
	71			ImportAssets2	
	73	x		DefineFontAlignZones	
	74			CSMTextSettings	
	75	x		DefineFont3	
	76	x	x	SymbolClass	
	77	x	x	Metadata	
	78	x		DefineScalingGrid	
	82	x		DoABC	
	83	x		DefineShape4	
	84			DefineMorphShape2	
	86	x		DefineSceneAndFrameLabelData	
	87			DefineBinaryData	
	88	x		DefineFontName	
	89			StartSound2	
	90			DefineBitsJPEG4	
	91			DefineFont4	
