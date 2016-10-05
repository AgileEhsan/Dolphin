"Filed out from Dolphin Smalltalk X6.2"!

Object subclass: #StyledGradientBrush
	instanceVariableNames: 'startColor endColor startPoint endPoint'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
StyledGradientBrush guid: (GUID fromString: '{4A31F78C-2126-4B71-BF0B-064199A1F828}')!
StyledGradientBrush comment: 'A StyledBrush holds persistent details for a GdiplusLinearGradientBrush.'!
!StyledGradientBrush categoriesForClass!Kernel-Objects! !
!StyledGradientBrush methodsFor!

asBackgroundGdiplusBrushFor: aView 
	"Answers a GdiplushLinearGradientBrush suitable for painting the receiver inside aView"

	| clientRect colorRect p1 mid p2 c1 c2 brush |
	clientRect := aView clientRectangle.
	colorRect := clientRect expandBy: 1 asPoint.
	p1 := self startPoint * colorRect extent + colorRect position.
	mid := self endPoint * colorRect extent + colorRect position.
	p2 := p1 + ((mid - p1) * 2).
	c1 := self startColorARGB.
	c2 := self endColorARGB.
	brush := GdiplusLinearGradientBrush 
				point1: p1
				point2: p2
				color1: c1
				color2: c2.
	brush blendFactors: #(0.0 0.2 0.4 0.6 0.8 1.0 1.0 0.8 0.6 0.4 0.2 0.0)
		positions: #(0 0.1 0.2 0.3 0.4 0.5 0.5 0.6 0.7 0.8 0.9 1.0).
	^brush!

endColor
	^endColor!

endColor: aColorOrNil 
	endColor := aColorOrNil!

endColorARGB
	^(self endColor ifNotNil: [:c | c] ifNil: [Color none]) asARGB!

endPoint
	^endPoint!

endPoint: aPoint 
	endPoint := aPoint!

isPartlyTransparent
	^self startColorARGB alpha < 255 or: [self endColorARGB alpha < 255]!

printOn: aStream 
	"Render the receiver to aStream as a developer would wish to see it"

	aStream
		nextPut: $(;
		display: self class.
	aStream nextPutAll: ' from: '.
	self startColor printOn: aStream.
	aStream nextPutAll: ' at: '.
	self startPoint displayOn: aStream.
	aStream nextPutAll: ' to: '.
	self endColor printOn: aStream.
	aStream nextPutAll: ' at: '.
	self endPoint printOn: aStream.
	aStream nextPut: $)!

startColor
	^startColor!

startColor: aColorOrNil 
	startColor := aColorOrNil!

startColorARGB
	^(self startColor ifNotNil: [:c | c] ifNil: [Color none]) asARGB!

startPoint
	^startPoint!

startPoint: aPoint 
	startPoint := aPoint! !
!StyledGradientBrush categoriesFor: #asBackgroundGdiplusBrushFor:!converting!public! !
!StyledGradientBrush categoriesFor: #endColor!accessing!public! !
!StyledGradientBrush categoriesFor: #endColor:!accessing!public! !
!StyledGradientBrush categoriesFor: #endColorARGB!converting!public! !
!StyledGradientBrush categoriesFor: #endPoint!accessing!public! !
!StyledGradientBrush categoriesFor: #endPoint:!accessing!public! !
!StyledGradientBrush categoriesFor: #isPartlyTransparent!public!testing! !
!StyledGradientBrush categoriesFor: #printOn:!printing!public! !
!StyledGradientBrush categoriesFor: #startColor!accessing!public! !
!StyledGradientBrush categoriesFor: #startColor:!accessing!public! !
!StyledGradientBrush categoriesFor: #startColorARGB!converting!public! !
!StyledGradientBrush categoriesFor: #startPoint!accessing!public! !
!StyledGradientBrush categoriesFor: #startPoint:!accessing!public! !

!StyledGradientBrush class methodsFor!

black
	^self color: Color black!

color: aColor 
	^self 
		from: aColor
		at: 0.5 @ 0
		to: aColor
		at: 0.5 @ 1!

face3dLeftToRightFade
	^self 
		from: Color face3d
		at: 0 @ 0.5
		to: nil
		at: 1 @ 0.5!

face3dTopLeftToBottomRightFade
	^self 
		from: Color face3d
		at: 0 @ 0
		to: nil
		at: 1 @ 1!

face3dTopToBottomFade
	^self 
		from: Color face3d
		at: 0.5 @ 0
		to: nil
		at: 0.5 @ 1!

from: aColor1 at: aPoint1 to: aColor2 at: aPoint2 
	^(super new)
		startColor: aColor1;
		startPoint: aPoint1;
		endColor: aColor2;
		endPoint: aPoint2;
		yourself!

new
	^self color: Color black!

white
	^self color: Color white! !
!StyledGradientBrush class categoriesFor: #black!instance creation!public! !
!StyledGradientBrush class categoriesFor: #color:!instance creation!public! !
!StyledGradientBrush class categoriesFor: #face3dLeftToRightFade!instance creation!public! !
!StyledGradientBrush class categoriesFor: #face3dTopLeftToBottomRightFade!instance creation!public! !
!StyledGradientBrush class categoriesFor: #face3dTopToBottomFade!instance creation!public! !
!StyledGradientBrush class categoriesFor: #from:at:to:at:!instance creation!public! !
!StyledGradientBrush class categoriesFor: #new!instance creation!public! !
!StyledGradientBrush class categoriesFor: #white!instance creation!public! !
