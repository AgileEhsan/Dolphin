﻿"Filed out from Dolphin Smalltalk 7"!

AbstractStringTest subclass: #MultiByteStringTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
MultiByteStringTest guid: (GUID fromString: '{f3d4f4a7-05b6-445f-8380-d0b838804877}')!
MultiByteStringTest isAbstract: true!
MultiByteStringTest comment: ''!
!MultiByteStringTest categoriesForClass!Unclassified! !
!MultiByteStringTest methodsFor!

caseConversionCases
	^super caseConversionCases
		, {{'кракозябры' asUtf8String. 'КРАКОЗЯБРЫ' asUtf8String}.
				{'文字化け' asUtf8String}.
				{'маймуница' asUtf8String. 'МАЙМУНИЦА' asUtf8String}.
				{'ａｂｃ' asUtf8String. 'ＡＢＣ' asUtf8String}}!

lengthTestCases
	^super lengthTestCases
		, #(#('a 🍺' 3) #('文字化け' 4) #('Ḽơᶉëᶆ ȋṕšᶙṁ ḍỡḽǭᵳ ʂǐť ӓṁệẗ, ĉṓɲṩḙċťᶒțûɾ ấɖḯƥĭṩčįɳġ ḝłįʈ, șếᶑ ᶁⱺ ẽḭŭŝḿꝋď ṫĕᶆᶈṓɍ ỉñḉīḑȋᵭṵńť ṷŧ ḹẩḇőꝛế éȶ đꝍꞎôꝛȇ ᵯáꞡᶇā ąⱡîɋṹẵ' 122) #('Camión' 6) #('ᚠ' 1) #('Приве́т नमस्ते שָׁלוֹם' 22) #('🐬🍺ö' 4) #('👨🏻‍🍳' 4))!

reverseTestCases
	"Private - #reverse doesn't work correctly for multi-byte encodings of UTF-8 and UTF-16."

	^super reverseTestCases
		, #(#('🍺 a' 'a 🍺') #('文字化け' 'け化字文') #('Ḽơᶉëᶆ ȋṕšᶙṁ ḍỡḽǭᵳ ʂǐť ӓṁệẗ, ĉṓɲṩḙċťᶒțûɾ ấɖḯƥĭṩčįɳġ ḝłįʈ, șếᶑ ᶁⱺ ẽḭŭŝḿꝋď ṫĕᶆᶈṓɍ ỉñḉīḑȋᵭṵńť ṷŧ ḹẩḇőꝛế éȶ đꝍꞎôꝛȇ ᵯáꞡᶇā ąⱡîɋṹẵ' 'ẵṹɋîⱡą āᶇꞡáᵯ ȇꝛôꞎꝍđ ȶé ếꝛőḇẩḹ ŧṷ ťńṵᵭȋḑīḉñỉ ɍṓᶈᶆĕṫ ďꝋḿŝŭḭẽ ⱺᶁ ᶑếș ,ʈįłḝ ġɳįčṩĭƥḯɖấ ɾûțᶒťċḙṩɲṓĉ ,ẗệṁӓ ťǐʂ ᵳǭḽỡḍ ṁᶙšṕȋ ᶆëᶉơḼ'))!

testAnsiStringRoundTrip
	| ansiAll utf ansi |
	ansiAll := Character byteCharacterSet.
	utf := self assimilateString: ansiAll.
	ansi := utf asAnsiString.
	self assert: ansi class identicalTo: AnsiString.
	self assert: ansi size equals: 256.
	self assert: ansi equals: ansiAll!

testBeginsWith
	| subject comperand pound |
	super testBeginsWith.
	pound := '£'.
	subject := (self collectionClass with: Character dolphin) , 'a' , pound , 'bc'.
	self assert: (subject beginsWith: Character dolphin).
	self deny: (subject beginsWith: (String with: (Character value: 16rF0))).
	self deny: (subject beginsWith: (Character value: 16rF0)).
	self deny: (subject beginsWith: (String with: (Character value: 16r3D))).
	self deny: (subject beginsWith: (Character value: 16r3D)).
	comperand := Character dolphin asUtf8String , 'a' , pound.
	self assert: (subject beginsWith: comperand).
	comperand := Character dolphin asUtf16String , 'a' , pound.
	self assert: (subject beginsWith: comperand)!

testBeginsWithIgnoreCase
	| subject comperand pound |
	super testBeginsWith.
	pound := String with: (Character value: 163).
	subject := (self collectionClass with: Character dolphin) , 'a' , pound , 'bc'.
	comperand := Character dolphin asUtf8String , 'A' , pound.
	self assert: (subject beginsWith: comperand ignoreCase: true).
	self deny: (subject beginsWith: comperand ignoreCase: false).
	comperand := comperand asUtf16String.
	self assert: (subject beginsWith: comperand ignoreCase: true).
	self deny: (subject beginsWith: comperand ignoreCase: false)!

testEncodeOnPut
	{Character dolphin.
		Character codePoint: 16r10FFFD.
		$a.
		$\0.
		Character ansiValue: 128.
		Character codePoint: 128.
		Character codePoint: 163.
		Character codePoint: 255.
		Character codePoint: 256.
		Character codePoint: 16rFFFD.
		Character codePoint: 16r10000} do: 
				[:each |
				"Test different initial buffer sizes to check stream growth/non-growth scenarios"
				#(0 1 2 3 4 8) do: 
						[:i |
						| actual utf stream actual2 |
						stream := self collectionClass writeStream: i.
						stream collection
							encodeOn: stream put: each;
							encodeOn: stream put: each.
						utf := stream contents.
						stream := utf readStream.
						actual := stream next.
						actual2 := stream next.
						self assert: actual2 equals: actual.
						self assert: stream atEnd.
						self assert: actual equals: each]]!

testIncludes
	| subject pound dolphin foreign |
	super testIncludes.
	pound := Character value: 163.
	dolphin := self collectionClass with: Character dolphin.
	subject := 'a' , dolphin , 'b' , pound asString , 'c'.
	self assert: (subject includes: $b).
	self assert: (subject includes: pound).
	self assert: (subject includes: Character dolphin).
	dolphin do: [:each | self assert: (subject includes: each)].
	foreign := self collectionClass == Utf8String
				ifTrue: [dolphin asUtf16String]
				ifFalse: [dolphin asUtf8String].
	foreign do: [:each | self deny: (subject includes: each)]!

testReverseComposites
	self skip.	"Currently #reverse does not handle these cases - issue #765"
	self assert: 'a 👨🏻‍🍳' reverse equals: '👨🏻‍🍳 a'.
	self assert: 'aeiöu' reverse equals: 'uöiea'.
	self assert: ' กำ' reverse equals: 'กำ '!

withAllTestCases
	^super withAllTestCases , #('a 🐬 test' 'Приве́т नमस्ते שָׁלוֹם' 'áèȋöû')! !
!MultiByteStringTest categoriesFor: #caseConversionCases!constants!private! !
!MultiByteStringTest categoriesFor: #lengthTestCases!constants!private! !
!MultiByteStringTest categoriesFor: #reverseTestCases!constants!private! !
!MultiByteStringTest categoriesFor: #testAnsiStringRoundTrip!public!unit tests! !
!MultiByteStringTest categoriesFor: #testBeginsWith!public!unit tests! !
!MultiByteStringTest categoriesFor: #testBeginsWithIgnoreCase!public!unit tests! !
!MultiByteStringTest categoriesFor: #testEncodeOnPut!public!unit tests! !
!MultiByteStringTest categoriesFor: #testIncludes!public!unit tests! !
!MultiByteStringTest categoriesFor: #testReverseComposites!public!unit tests! !
!MultiByteStringTest categoriesFor: #withAllTestCases!constants!private! !

