﻿"Filed out from Dolphin Smalltalk 7"!

ENHMETARECORD subclass: #EMRCREATEPALETTE
	instanceVariableNames: ''
	classVariableNames: '_OffsetOf_ihPal _OffsetOf_lgpl'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EMRCREATEPALETTE guid: (GUID fromString: '{b8739ed2-de47-467f-aa8d-3a62f4c00509}')!
EMRCREATEPALETTE addClassConstant: '_OffsetOf_ihPal' value: 16r8!
EMRCREATEPALETTE addClassConstant: '_OffsetOf_lgpl' value: 16rC!
EMRCREATEPALETTE comment: '<EMRCREATEPALETTE> is an <ExternalStructure> class to wrap the struct ''Win32.EMRCREATEPALETTE'' from type information in the ''Win32 API (ANSI). Derived from Bruce McKinney´s Hardcore Visual Basic Type Library'' library.

The type library contains no documentation for this struct

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef [uuid(B8739ED2-DE47-467F-AA8D-3A62F4C00509)]
struct tagEMRCREATEPALETTE {
	EMR EMR;
	[helpstring("Palette handle index")] DWORD ihPal;
	[helpstring("The peFlags fields in the palette entries do not contain any flags")] LOGPALETTE lgpl;
} EMRCREATEPALETTE;
'!
!EMRCREATEPALETTE categoriesForClass!Win32-Structs! !
!EMRCREATEPALETTE methodsFor!

ihPal
	"Answer the <Integer> value of the receiver's 'ihPal' field."

	^bytes dwordAtOffset: _OffsetOf_ihPal!

ihPal: anInteger
	"Set the receiver's 'ihPal' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_ihPal put: anInteger!

lgpl
	"Answer the <LOGPALETTE> value of the receiver's 'lgpl' field."

	^LOGPALETTE fromAddress: bytes yourAddress + _OffsetOf_lgpl!

lgpl: aLOGPALETTE
	"Set the receiver's 'lgpl' field to the value of the argument, aLOGPALETTE"

	aLOGPALETTE
		replaceBytesOf: bytes
		from: ##(_OffsetOf_lgpl + 1)
		to: ##(_OffsetOf_lgpl + LOGPALETTE basicByteSize)
		startingAt: 1! !
!EMRCREATEPALETTE categoriesFor: #ihPal!**compiled accessors**!public! !
!EMRCREATEPALETTE categoriesFor: #ihPal:!**compiled accessors**!public! !
!EMRCREATEPALETTE categoriesFor: #lgpl!**compiled accessors**!public! !
!EMRCREATEPALETTE categoriesFor: #lgpl:!**compiled accessors**!public! !

!EMRCREATEPALETTE class methodsFor!

defineFields
	"Define the fields of the EMRCREATEPALETTE structure.

	EMRCREATEPALETTE  compileDefinition

		typedef [uuid(B8739ED2-DE47-467F-AA8D-3A62F4C00509)]
		struct tagEMRCREATEPALETTE {
			EMR EMR;
			[helpstring('Palette handle index')] DWORD ihPal;
			[helpstring('The peFlags fields in the palette entries do not contain any flags')] LOGPALETTE lgpl;
		} EMRCREATEPALETTE;
"

	super defineFields.
	self
		defineField: #ihPal
			type: DWORDField new
			offset: 8;
		defineField: #lgpl
			type: (StructureField type: LOGPALETTE)
			offset: 12.
	self byteSize: 20!

getFieldNames
	^#(#iType #nSize #ihPal #lgpl)!

iTypes
	"Answer the integer enhanced metafile record type id for this record class."

	^Array with: EMR_CREATEPALETTE! !
!EMRCREATEPALETTE class categoriesFor: #defineFields!**auto generated**!initializing!public! !
!EMRCREATEPALETTE class categoriesFor: #getFieldNames!**compiled accessors**!constants!private! !
!EMRCREATEPALETTE class categoriesFor: #iTypes!constants!public! !

