"Filed out from Dolphin Smalltalk X6"!

Object subclass: #ILImport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ILImport guid: (GUID fromString: '{A28AB780-B157-41BD-84FA-A8869AC8BEAC}')!
ILImport comment: 'See [DolphinImageFolder]/Idb/Documentation for details

(C) 2005 Ian Bartholomew
ian@idb.me.uk
Public Domain Freeware'!
!ILImport categoriesForClass!IDB Goodies! !
!ILImport methodsFor!

color1atColumn: columnInteger startingFrom: offsetInteger in: anILImportProxy
	| colorIndex |
	colorIndex := (anILImportProxy imageBytes at: offsetInteger + (columnInteger // 8)) 
				bitAt: 8 - (columnInteger \\ 8).
	^anILImportProxy colorTable at: colorIndex + 1!

color24atColumn: columnInteger startingFrom: offsetInteger in: anILImportProxy
	^(RGBQUAD new)
		rgbRed: (anILImportProxy imageBytes at: columnInteger * 3 + offsetInteger + 2);
		rgbGreen: (anILImportProxy imageBytes at: columnInteger * 3 + offsetInteger + 1);
		rgbBlue: (anILImportProxy imageBytes at: columnInteger * 3 + offsetInteger);
		yourself!

color4atColumn: columnInteger startingFrom: offsetInteger in: anILImportProxy
	| colorIndex |
	colorIndex := anILImportProxy imageBytes at: offsetInteger + (columnInteger // 2).
	columnInteger even ifTrue: [colorIndex := colorIndex bitShift: -4].
	colorIndex := colorIndex bitAnd: 15.
	^anILImportProxy colorTable at: colorIndex + 1!

color8atColumn: columnInteger startingFrom: offsetInteger in: anILImportProxy
	| colorIndex |
	colorIndex := anILImportProxy imageBytes at: offsetInteger + columnInteger.
	^anILImportProxy colorTable at: colorIndex + 1!

colorAtColumn: columnInteger startingFrom: offsetInteger in: anILImportProxy
	^RGB fromRGBQUAD: (self 
				perform: (self columnAddressMethodFor: anILImportProxy colorDepth)
				with: columnInteger
				with: offsetInteger
				with: anILImportProxy)!

colorAtPoint: aPoint in: anILImportProxy
	| rowSize rowStart |
	aPoint x > anILImportProxy width | (aPoint y > anILImportProxy height) 
		ifTrue: [^RGB darkGray].
	rowSize := anILImportProxy imageBytes size / anILImportProxy height.
	self assert: [rowSize \\ 4 = 0].	"Can't cope with bitmaps that are not DWORD aligned  - is it legal anyway?"
	rowStart := anILImportProxy isTopDown 
				ifTrue: [(aPoint y - 1) * rowSize + 1]
				ifFalse: [(anILImportProxy height - aPoint y) * rowSize + 1].
	^self 
		colorAtColumn: aPoint x - 1
		startingFrom: rowStart
		in: anILImportProxy!

columnAddressMethodFor: anInteger
	^##((LookupTable new)
		at: 1 put: #color1atColumn:startingFrom:in:;
		at: 4 put: #color4atColumn:startingFrom:in:;
		at: 8 put: #color8atColumn:startingFrom:in:;
		at: 24 put: #color24atColumn:startingFrom:in:;
		yourself) at: anInteger
			ifAbsent: 
				[MessageBox 
					notify: '
Sorry, the ImageLibrary cannot load this bitmap as it''s color
depth or organisation is not supported. However, if you would
like to email me a copy of the bitmap I will see what I can do. 
See the help page for the address, but please check with me 
before sending large files (>50K say) as I may already have 
implemented the format for somebody else'.
				self error: 'Cannot continue with import']!

getBitmapFrom: aByteArray
	| stream bitmapInfoHeader colorTable imageBytes |
	stream := aByteArray readStream.
	bitmapInfoHeader := BITMAPINFOHEADER fromBytes: (stream next: BITMAPINFOHEADER byteSize).
	bitmapInfoHeader biBitCount <= 8 
		ifTrue: 
			[colorTable := StructureArray length: (2 bitShift: bitmapInfoHeader biBitCount - 1)
						elementClass: RGBQUAD.
			colorTable bytes: (stream next: colorTable byteSize)].
	imageBytes := stream upToEnd.
	^self proxyClass 
		bitmapInfoHeader: bitmapInfoHeader
		colorTable: colorTable
		imageBytes: imageBytes!

images
	^OrderedCollection new! !
!ILImport categoriesFor: #color1atColumn:startingFrom:in:!operations!public! !
!ILImport categoriesFor: #color24atColumn:startingFrom:in:!operations!public! !
!ILImport categoriesFor: #color4atColumn:startingFrom:in:!operations!public! !
!ILImport categoriesFor: #color8atColumn:startingFrom:in:!operations!public! !
!ILImport categoriesFor: #colorAtColumn:startingFrom:in:!helpers!public! !
!ILImport categoriesFor: #colorAtPoint:in:!helpers!public! !
!ILImport categoriesFor: #columnAddressMethodFor:!constants!public! !
!ILImport categoriesFor: #getBitmapFrom:!operations!public! !
!ILImport categoriesFor: #images!operations!public! !

!ILImport class methodsFor!

identifyImportFileClass: aStream
	^self importableClasses 
		detect: [:each | [each isResponsibleFor: aStream] ensure: [aStream reset]]
		ifNone: []!

importableClasses
	^##((OrderedCollection new)
		add: ILImportBitmap;
		add: ILImportIcon;
		add: ILImportCursor;
		add: ILImportStandardExe;
		add: ILImportToGoExe;
		yourself)!

importFrom: aStream
	^(self new initializeFrom: aStream) images! !
!ILImport class categoriesFor: #identifyImportFileClass:!helpers!public! !
!ILImport class categoriesFor: #importableClasses!helpers!public! !
!ILImport class categoriesFor: #importFrom:!instance creation!public! !
