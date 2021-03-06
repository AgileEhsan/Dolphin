﻿"Filed out from Dolphin Smalltalk 7"!

IDispatch subclass: #IVBSAXDeclHandler
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'MSXMLConstants'
	classInstanceVariableNames: ''!
IVBSAXDeclHandler guid: (IID fromString: '{E8917260-7579-4BE1-B5DD-7AFBFA6F077B}')!
IVBSAXDeclHandler comment: '<IVBSAXDeclHandler> is a wrapper class for the COM interface ''MSXML2.IVBSAXDeclHandler'' generated from type information in the ''Microsoft XML, v4.0'' library. It contains methods to invoke the member functions exposed by that interface.

The type library contains the following helpstring for this interface
	"IVBSAXDeclHandler interface"

Warning: This comment was automatically generated from the interface''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

[
	object, 
	uuid(E8917260-7579-4BE1-B5DD-7AFBFA6F077B), 
	helpstring("IVBSAXDeclHandler interface"), 
	dual, 
	nonextensible
]
interface IVBSAXDeclHandler : IDispatch
 {
	[id(0x00000557), helpstring("Report an element type declaration.")]
	HRESULT __stdcall elementDecl(
		[in, out]BSTR* strName,
		[in, out]BSTR* strModel);
	[id(0x00000558), helpstring("Report an attribute type declaration.")]
	HRESULT __stdcall attributeDecl(
		[in, out]BSTR* strElementName,
		[in, out]BSTR* strAttributeName,
		[in, out]BSTR* strType,
		[in, out]BSTR* strValueDefault,
		[in, out]BSTR* strValue);
	[id(0x00000559), helpstring("Report an internal entity declaration.")]
	HRESULT __stdcall internalEntityDecl(
		[in, out]BSTR* strName,
		[in, out]BSTR* strValue);
	[id(0x0000055a), helpstring("Report a parsed external entity declaration.")]
	HRESULT __stdcall externalEntityDecl(
		[in, out]BSTR* strName,
		[in, out]BSTR* strPublicId,
		[in, out]BSTR* strSystemId);
};
'!
!IVBSAXDeclHandler categoriesForClass!COM-Interfaces!MSXML2-Interfaces! !
!IVBSAXDeclHandler methodsFor!

attributeDecl: strElementName strAttributeName: strAttributeName strType: strType strValueDefault: strValueDefault strValue: strValue
	"Invoke the attributeDecl() method of the COM object.
	Helpstring: Report an attribute type declaration."

	| answer |
	answer := (Array new: 5)
				basicAt: 1 put: strElementName asBSTR;
				basicAt: 2 put: strAttributeName asBSTR;
				basicAt: 3 put: strType asBSTR;
				basicAt: 4 put: strValueDefault asBSTR;
				basicAt: 5 put: strValue asBSTR;
				yourself.
	self
		AttributeDecl: (answer basicAt: 1)
		strAttributeName: (answer basicAt: 2)
		strType: (answer basicAt: 3)
		strValueDefault: (answer basicAt: 4)
		strValue: (answer basicAt: 5).
	^answer collect: [:each | each asObject]
!

AttributeDecl: strElementName strAttributeName: strAttributeName strType: strType strValueDefault: strValueDefault strValue: strValue
	"Private - Invoke the attributeDecl() method of the COM object.
	Helpstring: Report an attribute type declaration.

		HRESULT __stdcall attributeDecl(
			[in, out]BSTR* strElementName,
			[in, out]BSTR* strAttributeName,
			[in, out]BSTR* strType,
			[in, out]BSTR* strValueDefault,
			[in, out]BSTR* strValue);"

	<virtual stdcall: hresult 9 bstr* bstr* bstr* bstr* bstr*>
	^self invalidCall!

elementDecl: strName strModel: strModel
	"Invoke the elementDecl() method of the COM object.
	Helpstring: Report an element type declaration."

	| answer |
	answer := (Array new: 2)
				basicAt: 1 put: strName asBSTR;
				basicAt: 2 put: strModel asBSTR;
				yourself.
	self
		ElementDecl: (answer basicAt: 1)
		strModel: (answer basicAt: 2).
	^answer collect: [:each | each asObject]
!

ElementDecl: strName strModel: strModel
	"Private - Invoke the elementDecl() method of the COM object.
	Helpstring: Report an element type declaration.

		HRESULT __stdcall elementDecl(
			[in, out]BSTR* strName,
			[in, out]BSTR* strModel);"

	<virtual stdcall: hresult 8 bstr* bstr*>
	^self invalidCall!

externalEntityDecl: strName strPublicId: strPublicId strSystemId: strSystemId
	"Invoke the externalEntityDecl() method of the COM object.
	Helpstring: Report a parsed external entity declaration."

	| answer |
	answer := (Array new: 3)
				basicAt: 1 put: strName asBSTR;
				basicAt: 2 put: strPublicId asBSTR;
				basicAt: 3 put: strSystemId asBSTR;
				yourself.
	self
		ExternalEntityDecl: (answer basicAt: 1)
		strPublicId: (answer basicAt: 2)
		strSystemId: (answer basicAt: 3).
	^answer collect: [:each | each asObject]
!

ExternalEntityDecl: strName strPublicId: strPublicId strSystemId: strSystemId
	"Private - Invoke the externalEntityDecl() method of the COM object.
	Helpstring: Report a parsed external entity declaration.

		HRESULT __stdcall externalEntityDecl(
			[in, out]BSTR* strName,
			[in, out]BSTR* strPublicId,
			[in, out]BSTR* strSystemId);"

	<virtual stdcall: hresult 11 bstr* bstr* bstr*>
	^self invalidCall!

internalEntityDecl: strName strValue: strValue
	"Invoke the internalEntityDecl() method of the COM object.
	Helpstring: Report an internal entity declaration."

	| answer |
	answer := (Array new: 2)
				basicAt: 1 put: strName asBSTR;
				basicAt: 2 put: strValue asBSTR;
				yourself.
	self
		InternalEntityDecl: (answer basicAt: 1)
		strValue: (answer basicAt: 2).
	^answer collect: [:each | each asObject]
!

InternalEntityDecl: strName strValue: strValue
	"Private - Invoke the internalEntityDecl() method of the COM object.
	Helpstring: Report an internal entity declaration.

		HRESULT __stdcall internalEntityDecl(
			[in, out]BSTR* strName,
			[in, out]BSTR* strValue);"

	<virtual stdcall: hresult 10 bstr* bstr*>
	^self invalidCall!

isExtensible
	"Answer whether the receiver may add methods at run-time."

	^false!

isVBCollection
	"Answer whether the receiver is a VB style collection."

	^false! !
!IVBSAXDeclHandler categoriesFor: #attributeDecl:strAttributeName:strType:strValueDefault:strValue:!**auto generated**!methods!public! !
!IVBSAXDeclHandler categoriesFor: #AttributeDecl:strAttributeName:strType:strValueDefault:strValue:!**auto generated**!COM Interfaces-IVBSAXDeclHandler!private! !
!IVBSAXDeclHandler categoriesFor: #elementDecl:strModel:!**auto generated**!methods!public! !
!IVBSAXDeclHandler categoriesFor: #ElementDecl:strModel:!**auto generated**!COM Interfaces-IVBSAXDeclHandler!private! !
!IVBSAXDeclHandler categoriesFor: #externalEntityDecl:strPublicId:strSystemId:!**auto generated**!methods!public! !
!IVBSAXDeclHandler categoriesFor: #ExternalEntityDecl:strPublicId:strSystemId:!**auto generated**!COM Interfaces-IVBSAXDeclHandler!private! !
!IVBSAXDeclHandler categoriesFor: #internalEntityDecl:strValue:!**auto generated**!methods!public! !
!IVBSAXDeclHandler categoriesFor: #InternalEntityDecl:strValue:!**auto generated**!COM Interfaces-IVBSAXDeclHandler!private! !
!IVBSAXDeclHandler categoriesFor: #isExtensible!**auto generated**!public!testing! !
!IVBSAXDeclHandler categoriesFor: #isVBCollection!**auto generated**!public!testing! !

!IVBSAXDeclHandler class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface 'MSXML2.IVBSAXDeclHandler'
		IVBSAXDeclHandler defineTemplate"

	self
		defineFunction: #ElementDecl:strModel:
			argumentTypes: 'bstr* bstr*';
		defineFunction: #AttributeDecl:strAttributeName:strType:strValueDefault:strValue:
			argumentTypes: 'bstr* bstr* bstr* bstr* bstr*';
		defineFunction: #InternalEntityDecl:strValue:
			argumentTypes: 'bstr* bstr*';
		defineFunction: #ExternalEntityDecl:strPublicId:strSystemId:
			argumentTypes: 'bstr* bstr* bstr*'
! !
!IVBSAXDeclHandler class categoriesFor: #defineFunctions!**auto generated**!initializing!public! !

