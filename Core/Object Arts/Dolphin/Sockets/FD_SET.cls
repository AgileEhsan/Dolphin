﻿"Filed out from Dolphin Smalltalk 7"!

ExternalStructure subclass: #FD_SET
	instanceVariableNames: ''
	classVariableNames: '_OffsetOf_fd_array _OffsetOf_fd_count'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FD_SET guid: (GUID fromString: '{b99a7942-497e-4a39-97ef-9040c83d7829}')!
FD_SET addClassConstant: '_OffsetOf_fd_array' value: 16r4!
FD_SET addClassConstant: '_OffsetOf_fd_count' value: 16r0!
FD_SET comment: '<FD_SET> is an <ExternalStructure> class to wrap the struct ''WINSOCK2Lib.fd_set'' from type information in the ''Windows Sockets 2 Type Library'' library.

IDL definition follows:

typedef struct tagfd_set {
	unsigned int fd_count;
	unsigned int fd_array[64];
} fd_set;
'!
!FD_SET categoriesForClass!WINSOCK2Lib-Structs! !
!FD_SET methodsFor!

fd_array
	"Answer the <DWORDArray> value of the receiver's 'fd_array' field."

	^DWORDArray fromAddress: bytes yourAddress + _OffsetOf_fd_array length: 64!

fd_count
	"Answer the <Integer> value of the receiver's 'fd_count' field."

	^bytes dwordAtOffset: _OffsetOf_fd_count!

fd_count: anInteger
	"Set the receiver's 'fd_count' field to the value of the argument, anInteger"

	bytes dwordAtOffset: _OffsetOf_fd_count put: anInteger! !
!FD_SET categoriesFor: #fd_array!**compiled accessors**!public! !
!FD_SET categoriesFor: #fd_count!**compiled accessors**!public! !
!FD_SET categoriesFor: #fd_count:!**compiled accessors**!public! !

!FD_SET class methodsFor!

defineFields
	"Define the fields of the fd_set structure.
		FD_SET compileDefinition
	
		typedef 		struct tagfd_set {
			unsigned int fd_count;
			unsigned int fd_array[64];
		} fd_set;
"

	self
		defineField: #fd_count type: DWORDField new;
		defineField: #fd_array type: (ArrayField type: DWORDArray length: 64) beReadOnly!

getFieldNames
	^#(#fd_count #fd_array)! !
!FD_SET class categoriesFor: #defineFields!**auto generated**!initializing!public! !
!FD_SET class categoriesFor: #getFieldNames!**compiled accessors**!constants!private! !

