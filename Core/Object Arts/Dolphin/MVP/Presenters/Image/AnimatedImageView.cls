﻿"Filed out from Dolphin Smalltalk 7"!

DoubleBufferedView subclass: #AnimatedImageView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AnimatedImageView guid: (GUID fromString: '{63997d2b-abca-455e-917b-8cf248b11e63}')!
AnimatedImageView comment: ''!
!AnimatedImageView categoriesForClass!Unclassified! !
!AnimatedImageView methodsFor!

connectModel
	"Connect the receiver to its model, wiring events, etc.
	ValueConvertingControlViews expect to be connected to a model that obeys the
	ValueModel protocol; i.e. it must generate a #value event when the value it is wrapping 
	is replaced."

	self model ifNotNil: 
			[:m | 
			m 
				when: #valueChanged
				send: #onModelChanged
				to: self]!

initialize	
	super initialize.!

render
	"Private - Render the background image"

	| canvas image |
	canvas := self canvas.
	canvas backcolor: self backcolor; erase.
	image := self value.
	image notNil ifTrue: [image drawOn: canvas].
	canvas free.	"useful to avoid build up of finalizable garbage"
	super render!

value
	"Answer the receiver's model value"

	^self model value!

value: anObject
	"Set the receiver's model value to anObject"

	self model value: anObject! !
!AnimatedImageView categoriesFor: #connectModel!models!public! !
!AnimatedImageView categoriesFor: #initialize!private! !
!AnimatedImageView categoriesFor: #render!operations!private! !
!AnimatedImageView categoriesFor: #value!accessing!public! !
!AnimatedImageView categoriesFor: #value:!accessing!public! !

!AnimatedImageView class methodsFor!

defaultModel
	^nil asValue!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 4 788558 10 ##(Smalltalk.STBViewProxy) ##(Smalltalk.AnimatedImageView) 34 14 nil nil 34 2 8 1409286144 1 416 721990 2 ##(Smalltalk.ValueHolder) nil false 1310726 ##(Smalltalk.EqualitySearchPolicy) nil 786694 ##(Smalltalk.IndexedColor) 33554471 nil 5 nil nil nil 416 nil true 983302 ##(Smalltalk.MessageSequence) 138 144 34 1 721670 ##(Smalltalk.MessageSend) #createAt:extent: 34 2 328198 ##(Smalltalk.Point) 2799 21 690 247 201 416 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 119 5 0 0 10 0 0 0 242 5 0 0 110 0 0 0] 8 #() 690 193 193 nil 27 )! !
!AnimatedImageView class categoriesFor: #defaultModel!models!public! !
!AnimatedImageView class categoriesFor: #resource_Default_view!public!resources-views! !

