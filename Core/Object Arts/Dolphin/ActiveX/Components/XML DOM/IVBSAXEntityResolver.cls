﻿"Filed out from Dolphin Smalltalk 7"!

IDispatch subclass: #IVBSAXEntityResolver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'MSXMLConstants'
	classInstanceVariableNames: ''!
IVBSAXEntityResolver guid: (IID fromString: '{0C05D096-F45B-4ACA-AD1A-AA0BC25518DC}')!
IVBSAXEntityResolver comment: '<IVBSAXEntityResolver> is a wrapper class for the COM interface ''MSXML2.IVBSAXEntityResolver'' generated from type information in the ''Microsoft XML, v4.0'' library. It contains methods to invoke the member functions exposed by that interface.

The type library contains the following helpstring for this interface
	"IVBSAXEntityResolver interface"

Warning: This comment was automatically generated from the interface''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

[
	object, 
	uuid(0C05D096-F45B-4ACA-AD1A-AA0BC25518DC), 
	helpstring("IVBSAXEntityResolver interface"), 
	dual, 
	nonextensible
]
interface IVBSAXEntityResolver : IDispatch
 {
	[id(0x00000527), helpstring("Allow the application to resolve external entities.")]
	HRESULT __stdcall resolveEntity(
		[in, out]BSTR* strPublicId,
		[in, out]BSTR* strSystemId,
		[out, retval]VARIANT* varInput);
};
'!
!IVBSAXEntityResolver categoriesForClass!COM-Interfaces!MSXML2-Interfaces! !
!IVBSAXEntityResolver methodsFor!

isExtensible
	"Answer whether the receiver may add methods at run-time."

	^false!

isVBCollection
	"Answer whether the receiver is a VB style collection."

	^false!

resolveEntity: strPublicId strSystemId: strSystemId
	"Invoke the resolveEntity() method of the COM object.
	Helpstring: Allow the application to resolve external entities."

	| answer |
	answer := (Array new: 3)
				basicAt: 1 put: strPublicId asBSTR;
				basicAt: 2 put: strSystemId asBSTR;
				basicAt: 3 put: VARIANT new;
				yourself.
	self
		ResolveEntity: (answer basicAt: 1)
		strSystemId: (answer basicAt: 2)
		varInput: (answer basicAt: 3).
	^answer collect: [:each | each asObject]
!

ResolveEntity: strPublicId strSystemId: strSystemId varInput: varInput
	"Private - Invoke the resolveEntity() method of the COM object.
	Helpstring: Allow the application to resolve external entities.

		HRESULT __stdcall resolveEntity(
			[in, out]BSTR* strPublicId,
			[in, out]BSTR* strSystemId,
			[out, retval]VARIANT* varInput);"

	<virtual stdcall: hresult 8 bstr* bstr* variant*>
	^self invalidCall! !
!IVBSAXEntityResolver categoriesFor: #isExtensible!**auto generated**!public!testing! !
!IVBSAXEntityResolver categoriesFor: #isVBCollection!**auto generated**!public!testing! !
!IVBSAXEntityResolver categoriesFor: #resolveEntity:strSystemId:!**auto generated**!methods!public! !
!IVBSAXEntityResolver categoriesFor: #ResolveEntity:strSystemId:varInput:!**auto generated**!COM Interfaces-IVBSAXEntityResolver!private! !

!IVBSAXEntityResolver class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface 'MSXML2.IVBSAXEntityResolver'
		IVBSAXEntityResolver defineTemplate"

	self
		defineFunction: #ResolveEntity:strSystemId:varInput:
			argumentTypes: 'bstr* bstr* variant*'
! !
!IVBSAXEntityResolver class categoriesFor: #defineFunctions!**auto generated**!initializing!public! !

