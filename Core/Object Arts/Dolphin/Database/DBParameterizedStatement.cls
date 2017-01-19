"Filed out from Dolphin Smalltalk X6"!

DBStatement subclass: #DBParameterizedStatement
	instanceVariableNames: 'values parameters paramCols isPrepared'
	classVariableNames: ''
	poolDictionaries: 'ODBCCTypes'
	classInstanceVariableNames: ''!
DBParameterizedStatement guid: (GUID fromString: '{87B4C549-026E-11D3-9FD7-00A0CC3E4A32}')!
DBParameterizedStatement comment: 'A DBParameterizedStatement is used to represent a parameterized (prepared) SQL statement to be executed by a <DBConnection>.

In general one does not create DBParameterizedStatements directly but rather by the use of DBConnection>>prepare:. The statement can later be parameterized with the appropriate column attributes using #paramCols: and the parameter values using #values:. The statement must then executed using #exec to perform the actual database query. If any results are expected then a <DBResultSet> can be retrieved by sending it a #results message.

Instance Variables:
	values		<Array> of <Object>. The current parameter values.
	parameters	<Array> of <DBField>. Buffers to hold the parameter values for the query.
	paramCols		<Array> of DBColAttr>. Metadata about the parameters.
	isPrepared		<Boolean>. Flag to indicate whether the statement has been prepared.
'!
!DBParameterizedStatement categoriesForClass!ODBC Interface! !
!DBParameterizedStatement methodsFor!

exec
	"(Re)Execute a prepared statement."

	| ret |
	self close.
	isPrepared
		ifFalse: [self prepare].
	paramCols notNil
		ifTrue: [self setValues].
	ret := ODBCLibrary default sqlExecute: self allocatedHandle.
	self dbCheckException: ret.
	executed := true.
!

free
	"Release external resources held by the receiver,
	remaining in a consistent state in order that
	the result set could be regenerated."

	isPrepared := false.
	super free.
	parameters := nil!

paramCols
	"Answer the receiver's parameter columns"

	^paramCols!

paramCols: anArrayOfColAttrs
	"Set the receiver's parameter columns to anArrayOfColAttrs"

	paramCols := anArrayOfColAttrs.!

parameters
	"Private - Answer the receivers bound parameter fields. On first receipt (usually from 
	#exec) completes lazy evaluation by causing allocation of a statement handle, preparing 
	the statement, creating the array of parameter fields and binding them."

	parameters == nil ifTrue: [
		parameters := (paramCols collect: [:col | DBField newForCol: col]) asArray.
		self setParams].
	^parameters!

prepare
	"Private - Prepare the receiver for later execution when the parameter values have 
	been set. N.B. This should only be sent once unless closed in the interm."

	| ret |
	isPrepared := false.
	parameters := nil.
	ret := ODBCLibrary default 
				sqlPrepare: self allocatedHandle
				statementText: self sqlString
				textLength: SQL_NTS.
	self dbCheckException: ret.
	isPrepared := true!

prepare: aString
	"Private - Prepare the receiver for later execution when the parameter values have 
	been set."

	self sqlString: aString; prepare!

reset
	"Private - Initialize the receiver."

	super reset.
	isPrepared := false.
	parameters := nil.!

setParams
	"Private - Bind parameter columns for a prepared SQL statement so that when we 
	subsequently fill the buffer fields the statement is ready to exec. Normally only done 
	just before first exec (from #parameters)."

	paramCols keysAndValuesDo: 
			[:i :eachCol | 
			| buf eachField |
			eachField := parameters at: i.
			buf := eachField fieldBuf.
			self dbCheckException: (ODBCLibrary default 
						sqlBindParameter: self allocatedHandle
						parameterNumber: i
						inputOutputType: eachCol parameterType
						valueType: SQL_C_DEFAULT
						parameterType: eachCol type
						columnSize: eachCol precision
						decimalDigits: eachCol scale
						parameterValuePtr: buf
						bufferLength: buf byteSize
						strLenOrIndPtr: eachField lengthBuf)]!

setValues
	"Private - Copy object values to the bound fields for the parameters of the prepared SQL
	statement. On first receipt this will cause the parameter fields to be created and bound 	(via #parameters)."

	1 to: self parameters size do: [:i |
		(parameters at: i) value: (values at: i)]
!

values
	"Answer the array of parameter values."

	^values!

values: anArrayOfValues
	"Set the receiver's parameter values prior to a future #exec."

	self close.
	values := anArrayOfValues! !
!DBParameterizedStatement categoriesFor: #exec!operations!public! !
!DBParameterizedStatement categoriesFor: #free!public!realizing/unrealizing! !
!DBParameterizedStatement categoriesFor: #paramCols!accessing!public! !
!DBParameterizedStatement categoriesFor: #paramCols:!accessing!public! !
!DBParameterizedStatement categoriesFor: #parameters!accessing!private! !
!DBParameterizedStatement categoriesFor: #prepare!operations!private! !
!DBParameterizedStatement categoriesFor: #prepare:!operations!private! !
!DBParameterizedStatement categoriesFor: #reset!initializing!private! !
!DBParameterizedStatement categoriesFor: #setParams!operations!private! !
!DBParameterizedStatement categoriesFor: #setValues!operations!private! !
!DBParameterizedStatement categoriesFor: #values!accessing!public! !
!DBParameterizedStatement categoriesFor: #values:!accessing!public! !
