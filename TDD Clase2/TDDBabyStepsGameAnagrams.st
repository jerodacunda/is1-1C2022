!classDefinition: #TDDBabyStepsAnagramsTest category: 'TDDBabyStepsGameAnagrams'!
TestCase subclass: #TDDBabyStepsAnagramsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameAnagrams'!

!TDDBabyStepsAnagramsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 21:14:31'!
test01EmptyStringAnagramIsJustACollectionWithTheEmptyString

	self assert: (Set with: '') equals: '' anagrams
	! !

!TDDBabyStepsAnagramsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 21:17:01'!
test02OneCharStringAnagramReturnsACollectionWithTheSameOneCharString

	self assert: (Set with:'a') equals: 'a' anagrams
	! !

!TDDBabyStepsAnagramsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 21:19:32'!
test03TwoCharStringAnagramReturnsTheOriginalStringAndAnotherOneFlipped

	self assert: (Set with:'ab' with: 'ba') equals: 'ab' anagrams
	! !

!TDDBabyStepsAnagramsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 21:22:15'!
test04ThreeCharStringAnagramReturnsAllThe6PossibleOrderCombinations

	| anagrams |
	
	anagrams := Set new.
	anagrams add: 'abc'.
	anagrams add: 'acb'.
	anagrams add: 'bac'.
	anagrams add: 'bca'.
	anagrams add: 'cab'.
	anagrams add: 'cba'.

	self assert: anagrams equals: 'abc' anagrams
	! !
