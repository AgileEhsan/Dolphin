"Filed out from Dolphin Smalltalk 7"!

HttpServerStructure subclass: #HTTP_CACHE_POLICY
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
HTTP_CACHE_POLICY guid: (GUID fromString: '{02064551-c601-4e48-85ac-6d19fe34f58b}')!
HTTP_CACHE_POLICY comment: '<HTTP_CACHE_POLICY> is an <ExternalStructure> class to wrap the struct ''Win32.HTTP_CACHE_POLICY'' from type information in the ''Win32 API'' library.

The type library contains the following helpstring for this struct
	" Only cache unauthorized GETs + HEADs."

** This comment was automatically generated from a type library. Delete this line to prevent any manual edits from being overwritten if the wrapper class is regenerated. **

IDL definition follows:

typedef [uuid(02064551-c601-4e48-85ac-6d19fe34f58b), helpstring(" Only cache unauthorized GETs + HEADs.")]
struct tagHTTP_CACHE_POLICY {
	HTTP_CACHE_POLICY_TYPE Policy;
	ULONG SecondsToLive;
} HTTP_CACHE_POLICY;
'!
!HTTP_CACHE_POLICY categoriesForClass!Win32-Structs! !
!HTTP_CACHE_POLICY methodsFor!

Policy
	"Answer the <Integer> value of the receiver's 'Policy' field."

	^bytes sdwordAtOffset: 0!

Policy: anInteger
	"Set the receiver's 'Policy' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: 0 put: anInteger!

SecondsToLive
	"Answer the <Integer> value of the receiver's 'SecondsToLive' field."

	^bytes dwordAtOffset: ##(self offsetOf: #SecondsToLive)!

SecondsToLive: anInteger
	"Set the receiver's 'SecondsToLive' field to the value of the argument, anInteger"

	bytes dwordAtOffset: ##(self offsetOf: #SecondsToLive) put: anInteger! !
!HTTP_CACHE_POLICY categoriesFor: #Policy!**compiled accessors**!public! !
!HTTP_CACHE_POLICY categoriesFor: #Policy:!**compiled accessors**!public! !
!HTTP_CACHE_POLICY categoriesFor: #SecondsToLive!**compiled accessors**!public! !
!HTTP_CACHE_POLICY categoriesFor: #SecondsToLive:!**compiled accessors**!public! !

!HTTP_CACHE_POLICY class methodsFor!

defineFields
	"Define the fields of the HTTP_CACHE_POLICY structure.

	HTTP_CACHE_POLICY compileDefinition

		typedef [uuid(02064551-c601-4e48-85ac-6d19fe34f58b), helpstring(' Only cache unauthorized GETs + HEADs.')]
		struct tagHTTP_CACHE_POLICY {
			HTTP_CACHE_POLICY_TYPE Policy;
			ULONG SecondsToLive;
		} HTTP_CACHE_POLICY;
"

	self
		defineField: #Policy type: SDWORDField new offset: 0;
		defineField: #SecondsToLive type: DWORDField new offset: 4.
	self byteSize: 8! !
!HTTP_CACHE_POLICY class categoriesFor: #defineFields!**auto generated**!initializing!public! !
