﻿"Filed out from Dolphin Smalltalk 7"!

IntegerTest subclass: #SmallIntegerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SmallIntegerTest guid: (GUID fromString: '{3fc98bda-cdeb-45ea-a355-2968f5fd5e3a}')!
SmallIntegerTest comment: ''!
!SmallIntegerTest categoriesForClass!Unclassified! !
!SmallIntegerTest methodsFor!

canonicalInstance
	^123!

testAbs
	self assert: -4 abs identicalTo: 4!

testAllMask

	self assert: (29127 allMask: 20805).
	self assert: (29127 allMask: 21845) not
!

testAnyMask

	self assert: (29127 anyMask: 21845).
!

testBasicNew
	self should: [SmallInteger basicNew] raise: TestResult error!

testBitAnd
	self assert: (29127 bitAnd: 3640) identicalTo: 0!

testBitOr
	self assert: (29127 bitOr: 3640) identicalTo: 32767.
	self assert: (29127 bitOr: 21845) identicalTo: 30167!

testBitShift
	"Bit manipulation (in particular check 32-bitness)"

	self assert: (-1 bitShift: -1) identicalTo: -1.
	self assert: (-1073741824 bitShift: -29) identicalTo: -2.
	self assert: (-1073741824 bitShift: -30) identicalTo: -1.
	self assert: (-1073741824 bitShift: -31) identicalTo: -1.
	self assert: (-1073741824 bitShift: -32) identicalTo: -1.
	self assert: (1 bitShift: -1) identicalTo: 0.
	self assert: (1073741823 bitShift: -29) identicalTo: 1.
	self assert: (1073741823 bitShift: -30) identicalTo: 0.
	self assert: (1073741823 bitShift: -31) identicalTo: 0.
	self assert: (1073741823 bitShift: -32) identicalTo: 0.
	self assert: (3640 bitShift: 1) identicalTo: 7280!

testDecimalDigitLength
	2 to: 10 do: [:i | | subject |
		subject := 10 raisedToInteger: i-1.
		self assert: subject decimalDigitLength equals: i.
		self assert: (subject - 1) decimalDigitLength equals: i-1.
		self assert: (subject + 1) decimalDigitLength equals: i].
	self assert: 0 decimalDigitLength equals: 1.
	self assert: 1 decimalDigitLength equals: 1.
	self assert: 16r3FFFFFFF decimalDigitLength equals: 10!

testDigitLength
	"Note that the digitLength is the number of bytes required to represent the positive magnitude,
	not the 2's complement value."

	#(-255 -129 -128 -1 0 1 127 128 255) do: [:each | self assert: each digitLength identicalTo: 1].
	#(-65535 -256 256 65535) do: [:each | self assert: each digitLength identicalTo: 2].
	#(16rFFFFFF -16rFFFFFF) do: [:each | self assert: each digitLength identicalTo: 3].
	#(16r1000000 -16r1000000) do: [:each | self assert: each digitLength identicalTo: 4].
	"This loop repeats some of the above tests, but those for literal values are left for clarity"
	(2 to: VMConstants.IntPtrSize) collect: 
			[:i |
			| first |
			first := 2 ** ((i - 1) * 8).
			self assert: first digitLength identicalTo: i.
			self assert: (first * -1) digitLength identicalTo: i.
			i == VMConstants.IntPtrSize
				ifFalse: 
					[| last |
					last := 2 ** (i * 8) - 1.
					self assert: last digitLength identicalTo: i.
					self assert: (last * -1) digitLength identicalTo: i]].
	self assert: SmallInteger minimum digitLength equals: VMConstants.IntPtrSize.
	self assert: SmallInteger maximum digitLength equals: VMConstants.IntPtrSize!

testDivide
	self assert: 6 / 2 identicalTo: 3.
	self assert: 7 / 2 equals: (Fraction numerator: 7 denominator: 2)!

testEven
	#(-1073741824 -2 0 4 32768 1073741822) do: 
			[:each | 
			self assert: each even.
			self deny: (each + 1) even]!

testExp10
	| expected |
	self assert: -2 exp10 equals: 1 / 100.
	self assert: -1 exp10 equals: 1 / 10.
	self assert: 0 exp10 equals: 1.
	expected := 10.
	1 to: 50
		do: 
			[:i |
			self assert: i exp10 equals: expected.
			expected := expected * 10]!

testGcd
	self assert: (55 gcd: 30) identicalTo: 5!

testHighBit
	self should: [-1 highBit] raise: Error.
	self assert: 0 highBit equals: 0.
	0 to: 30 do: [:each | self assert: (2 ** each) highBit equals: each + 1].
	self assert: SmallInteger maximum highBit equals: 30!

testIntegerDivide
	self assert: 7 // 2 identicalTo: 3.
	self assert: -7 // 2 identicalTo: -4.
	self assert: 7 // -2 identicalTo: -4!

testLargeSmallComparisons
	self assert: SmallInteger maximum < (SmallInteger maximum + 1).
	self assert: SmallInteger maximum <= (SmallInteger maximum + 1).
	self deny: SmallInteger maximum equals: SmallInteger maximum + 1.
	self deny: SmallInteger maximum > (SmallInteger maximum + 1).
	self deny: SmallInteger maximum >= (SmallInteger maximum + 1).
	self assert: SmallInteger maximum + 1 > SmallInteger maximum.
	self assert: SmallInteger maximum + 1 >= SmallInteger maximum.
	self deny: SmallInteger maximum + 1 <= SmallInteger maximum.
	self deny: SmallInteger maximum + 1 equals: SmallInteger maximum.
	self deny: SmallInteger maximum + 1 < SmallInteger maximum!

testLcm
	self assert: (6 lcm: 10) identicalTo: 30!

testLowBit
	0 to: 30 do: [:each | 
		| i |
		i := 1 << each.
		self assert: i lowBit equals: each+1.
		self assert: i negated lowBit equals: each + 1].
	#(#(0 0) #(3 1) #(16r30000000 29) #(-3 1) #(-16r40000000 31))
		do: [:each | self assert: each first lowBit equals: each second]!

testMaxVal
	self should: [SmallInteger maximum = ((1 bitShift: VMConstants.IntPtrBits - 2) - 1)]!

testMinMax
	VMConstants.IsWin64
		ifTrue: 
			[self assert: SmallInteger maximum + 1 equals: 16r4000000000000000.
			self assert: SmallInteger minimum - 1 equals: -16r4000000000000001.
			self assert: (SmallInteger maximum // 2 + 1) * 2 equals: 16r4000000000000000.
			self assert: (SmallInteger minimum // 2 - 1) * 2 equals: -16r4000000000000002]
		ifFalse: 
			[self assert: SmallInteger maximum + 1 equals: 16r40000000.
			self assert: SmallInteger minimum - 1 equals: -16r40000001.
			self assert: (SmallInteger maximum // 2 + 1) * 2 equals: 16r40000000.
			self assert: (SmallInteger minimum // 2 - 1) * 2 equals: -16r40000002]!

testMinVal
	self should: [SmallInteger minimum = (1 bitShift: VMConstants.IntPtrBits - 2) negated]!

testModulo
	self should: [-1 \\ 0] raise: ZeroDivide.
	self assert: 6 \\ 2 equals: 0.
	self assert: -6 \\ 2 equals: 0.
	self assert: 5 \\ -3 equals: -1.
	self assert: -5 \\ -3 equals: -2.
	self assert: 7 \\ 2 equals: 1.
	self assert: 7 \\ 2 + 1 equals: 2.
	self assert: 7 \\ 11 equals: 7.
	self assert: 7 \\ -2 equals: -1.
	self assert: 7 \\ -3 equals: -2.
	self assert: 7 \\ -4 equals: -1.
	self assert: 7 \\ -5 equals: -3.
	self assert: 7 \\ -6 equals: -5.
	self assert: 7 \\ -7 equals: 0.
	self assert: 7 \\ -8 equals: -1.
	self assert: 7 \\ -11 equals: -4.
	self assert: -7 \\ 2 equals: 1.
	self assert: -7 \\ 7 equals: 0.
	self assert: -7 \\ 11 equals: 4.
	self assert: -7 \\ -11 equals: -7!

testNew
	self should: [SmallInteger new] raise: TestResult error!

testNoMask

	self assert: (29127 noMask: 3640).!

testNumberOfDigitsInBase
	(1 to: 30) do: 
			[:each |
			self assert: ((2 raisedToInteger: each) - 1 numberOfDigitsInBase: 2) equals: each.
			self assert: ((2 raisedToInteger: each) numberOfDigitsInBase: 16) equals: each // 4 + 1].
	self assert: (-2 numberOfDigitsInBase: 2) equals: 2.
	self assert: (16r3FFFFFFF numberOfDigitsInBase: 16) equals: 8.
	self assert: (16r3FFFFFFF numberOfDigitsInBase: 3) equals: 19!

testOverflow
	"Test overflow of SmallInteger arithmetic prims"

	| res |
	res := SmallInteger maximum + 1.
	self assert: res equals: 16r40000000.
	self assert: res class identicalTo: LargeInteger.
	res := SmallInteger maximum + SmallInteger maximum.
	self assert: res equals: 16r7FFFFFFE.
	self assert: res class identicalTo: LargeInteger.
	res := SmallInteger minimum - 1.
	self assert: res equals: -16r40000001.
	self assert: res class identicalTo: LargeInteger.
	res := SmallInteger minimum + SmallInteger minimum.
	self assert: res equals: -16r80000000.
	self assert: res class identicalTo: LargeInteger.
	res := SmallInteger minimum - SmallInteger maximum.
	self assert: res equals: -16r7FFFFFFF.
	self assert: res class identicalTo: LargeInteger.
	res := 16r20000000 * 2.
	self assert: res equals: 16r40000000.
	self assert: res class identicalTo: LargeInteger.
	res := SmallInteger maximum * SmallInteger maximum.
	self assert: res equals: 16rFFFFFFF80000001.
	self assert: res class identicalTo: LargeInteger.
	res := SmallInteger minimum * SmallInteger maximum.
	self assert: res equals: -16rFFFFFFFC0000000.
	self assert: res class identicalTo: LargeInteger.
	res := SmallInteger minimum * SmallInteger minimum.
	self assert: res equals: 16r1000000000000000.
	self assert: res class identicalTo: LargeInteger!

testPrimesUpTo
	"Use a brute force technique to generate the first few hundred primes, which we know works."

	| primes primes2 max |
	self should: [Integer primesUpTo: -1] raise: Error.
	self should: [Integer primesUpTo: 0] raise: Error.
	self assert: (Integer primesUpTo: 1) isEmpty.
	self assert: (Integer primesUpTo: 2) asArray equals: #(2).
	self assert: (Integer primesUpTo: 3) asArray equals: #(2 3).
	max := 2000.
	primes := OrderedCollection with: 2.
	(3 to: max by: 2) do: [:n | primes detect: [:p | n \\ p == 0] ifNone: [primes add: n]].
	primes2 := Integer primesUpTo: 2000.
	self assert: primes asArray equals: primes2!

testPrintString
	| pairs |
	pairs := #(#(0 '0') #(1 '1') #(-1 '-1') #(12 '12') #(-12 '-12') #(255 '255') #(-255 '-255') #(256 '256') #(-256 '-256') #(999 '999') #(-999 '-999') #(1000 '1000') #(-1000 '-1000') #(4095 '4095') #(-4095 '-4095') #(4096 '4096') #(-4096 '-4096') #(9999 '9999') #(-9999 '-9999') #(10000 '10000') #(-10000 '-10000') #(65535 '65535') #(-65535 '-65535') #(65536 '65536') #(-65536 '-65536') #(99999 '99999') #(-99999 '-99999') #(100000 '100000') #(-100000 '-100000') #(1048575 '1048575') #(-1048575 '-1048575') #(1048576 '1048576') #(-1048576 '-1048576') #(9999999 '9999999') #(-9999999 '-9999999') #(10000000 '10000000') #(-10000000 '-10000000') #(99999999 '99999999') #(-99999999 '-99999999') #(100000000 '100000000') #(-100000000 '-100000000') #(16777215 '16777215') #(-16777215 '-16777215') #(16777216 '16777216') #(-16777216 '-16777216') #(268435455 '268435455') #(-268435455 '-268435455') #(268435456 '268435456') #(-268435456 '-268435456') #(999999999 '999999999') #(-999999999 '-999999999') #(1000000000 '1000000000') #(-1000000000 '-1000000000') #(1073741823 '1073741823') #(-1073741823 '-1073741823') #(-1073741824 '-1073741824')).
	VMConstants.IsWin64
		ifTrue: 
			[pairs := pairs
						, #(#(4294967295 '4294967295') #(-4294967295 '-4294967295') #(4294967296 '4294967296') #(-4294967296 '-4294967296') #(4611686018427387903 '4611686018427387903') #(-4611686018427387903 '-4611686018427387903') #(-4611686018427387904 '-4611686018427387904'))].
	pairs do: [:eachPair | self assert: eachPair first printString equals: eachPair second]!

testPrintStringRadix
	self assert: (32767 printStringRadix: 2) equals: '2r111111111111111'.
	self assert: (30167 printStringRadix: 2) equals: '2r111010111010111'.
	self assert: (0 printStringRadix: 2) equals: '2r0'.
	self assert: (-1 printStringRadix: 2) equals: '-2r1'.
	self assert: (1295 printStringRadix: 36) equals: '36rZZ'.
	self assert: (SmallInteger maximum printStringRadix: 36) equals: '36rHRA0HR'.
	self assert: (SmallInteger minimum printStringRadix: 36) equals: '-36rHRA0HS'.
	self should: [1 printStringRadix: 1] raise: Error.
	self should: [36 printStringRadix: 37] raise: Error!

testQuo
	self assert: (6 quo: 2) identicalTo: 3.
	self assert: (7 quo: 2) identicalTo: 3.
	self assert: (7 quo: 2) + 1 identicalTo: 4.
	self assert: (7 quo: 2) + 1 identicalTo: 4.
	self assert: (7 quo: 2 + 1) identicalTo: 2.
	self assert: (-7 quo: 2) identicalTo: -3.
	"Remember that the absolute value of `SmallInteger minimum` is one greater than `SmallInteger maximum`"
	self assert: (SmallInteger maximum quo: SmallInteger maximum) equals: 1.
	self assert: (SmallInteger maximum quo: SmallInteger maximum+1) equals: 0.
	self assert: (SmallInteger maximum quo: SmallInteger minimum) equals: 0.
	self assert: (SmallInteger minimum quo: SmallInteger maximum+1) equals: -1.
	self assert: (SmallInteger minimum quo: SmallInteger maximum) equals: -1.
	self assert: (SmallInteger minimum quo: SmallInteger minimum) equals: 1.
!

testRaisedToInteger
	| expected subject |
	subject := 10.
	self assert: (subject raisedToInteger: 0) equals: 1.
	expected := subject.
	1 to: 10
		do: 
			[:i |
			self assert: (10 raisedToInteger: i) equals: expected.
			expected := expected * subject].
	self assert: (0 raisedToInteger: 0) equals: 1.
	self assert: (0 raisedToInteger: 1) equals: 0.
	self assert: (0 raisedToInteger: 2) equals: 0.
	self should: [0 raisedToInteger: -1] raise: ZeroDivide.
	self assert: (2 raisedToInteger: -1) equals: 1 / 2.
	self assert: (2 raisedToInteger: -4) equals: 1 / 16.
	self assert: (-3 raisedToInteger: 0) equals: 1.
	self assert: (-3 raisedToInteger: 1) equals: -3.
	self assert: (-3 raisedToInteger: 2) equals: 9.
	self assert: (-3 raisedToInteger: 3) equals: -27.
	self assert: (-3 raisedToInteger: -2) equals: 1 / 9.
	self assert: (-3 raisedToInteger: -3) equals: -1 / 27.
	self should: [10 raisedToInteger: 1.0] raise: Error.
	self assert: (SmallInteger maximum raisedToInteger: 1) equals: SmallInteger maximum.
	self assert: (SmallInteger maximum raisedToInteger: 2)
		equals: SmallInteger maximum * SmallInteger maximum.
	self assert: (SmallInteger minimum raisedToInteger: 2)
		equals: SmallInteger minimum * SmallInteger minimum.
	self assert: (SmallInteger minimum raisedToInteger: -2)
		equals: 1 / (SmallInteger minimum * SmallInteger minimum)!

testReciprocal
	self assert: 7 reciprocal equals: (Fraction numerator: 1 denominator: 7)!

testRem
	self assert: (7 rem: 2) identicalTo: 1.
	self assert: (-7 rem: 2) identicalTo: -1!

testSubtract
	"Coercion to float"

	self assert: (5 - 2.125 equals: 2.875)! !
!SmallIntegerTest categoriesFor: #canonicalInstance!public!unit tests! !
!SmallIntegerTest categoriesFor: #testAbs!public!unit tests! !
!SmallIntegerTest categoriesFor: #testAllMask!public!unit tests! !
!SmallIntegerTest categoriesFor: #testAnyMask!public!unit tests! !
!SmallIntegerTest categoriesFor: #testBasicNew!public!unit tests! !
!SmallIntegerTest categoriesFor: #testBitAnd!public!unit tests! !
!SmallIntegerTest categoriesFor: #testBitOr!public!unit tests! !
!SmallIntegerTest categoriesFor: #testBitShift!public!unit tests! !
!SmallIntegerTest categoriesFor: #testDecimalDigitLength!public!unit tests! !
!SmallIntegerTest categoriesFor: #testDigitLength!public!unit tests! !
!SmallIntegerTest categoriesFor: #testDivide!public!unit tests! !
!SmallIntegerTest categoriesFor: #testEven!public!unit tests! !
!SmallIntegerTest categoriesFor: #testExp10!public!unit tests! !
!SmallIntegerTest categoriesFor: #testGcd!public!unit tests! !
!SmallIntegerTest categoriesFor: #testHighBit!public!unit tests! !
!SmallIntegerTest categoriesFor: #testIntegerDivide!public!unit tests! !
!SmallIntegerTest categoriesFor: #testLargeSmallComparisons!public!unit tests! !
!SmallIntegerTest categoriesFor: #testLcm!public!unit tests! !
!SmallIntegerTest categoriesFor: #testLowBit!public!unit tests! !
!SmallIntegerTest categoriesFor: #testMaxVal!public!unit tests! !
!SmallIntegerTest categoriesFor: #testMinMax!public!unit tests! !
!SmallIntegerTest categoriesFor: #testMinVal!public!unit tests! !
!SmallIntegerTest categoriesFor: #testModulo!public!unit tests! !
!SmallIntegerTest categoriesFor: #testNew!public!unit tests! !
!SmallIntegerTest categoriesFor: #testNoMask!public!unit tests! !
!SmallIntegerTest categoriesFor: #testNumberOfDigitsInBase!public!unit tests! !
!SmallIntegerTest categoriesFor: #testOverflow!public!unit tests! !
!SmallIntegerTest categoriesFor: #testPrimesUpTo!public!unit tests! !
!SmallIntegerTest categoriesFor: #testPrintString!public!unit tests! !
!SmallIntegerTest categoriesFor: #testPrintStringRadix!public!unit tests! !
!SmallIntegerTest categoriesFor: #testQuo!public!unit tests! !
!SmallIntegerTest categoriesFor: #testRaisedToInteger!public!unit tests! !
!SmallIntegerTest categoriesFor: #testReciprocal!public!unit tests! !
!SmallIntegerTest categoriesFor: #testRem!public!unit tests! !
!SmallIntegerTest categoriesFor: #testSubtract!public!unit tests! !

