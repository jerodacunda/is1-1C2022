!classDefinition: #TDDBabyStepsRot13Test category: 'TDDBabyStepsGameRot13'!
TestCase subclass: #TDDBabyStepsRot13Test
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameRot13'!

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 17:49:00'!
test01TheEmptyStringDoesntChange
	
	self assert: '' equals: '' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 17:55:54'!
test02CorrectlyEncodesALowercaseOneCharStringFromTheFirstPartOfTheAlphabet
	
	self assert: 'n' equals: 'a' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:01:32'!
test03CorrectlyEncodesALowercaseOneCharStringFromTheFirstPartOfTheAlphabet
	
	self assert: 'z' equals: 'm' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:03:15'!
test04CorrectlyEncodesALowercaseOneCharStringFromTheSecondPartOfTheAlphabet
	
	self assert: 'a' equals: 'n' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:04:37'!
test05CorrectlyEncodesALowercaseOneCharStringFromTheSecondPartOfTheAlphabet
	
	self assert: 'm' equals: 'z' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:05:57'!
test06CorrectlyEncodesAnUppercaseOneCharStringFromTheFirstPartOfTheAlphabet
	
	self assert: 'N' equals: 'A' asRot13.
	self assert: 'Z' equals: 'M' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:27:31'!
test07CorrectlyEncodesAnUppercaseOneCharStringFromTheSecondPartOfTheAlphabet
	
	self assert: 'A' equals: 'N' asRot13.
	self assert: 'M' equals: 'Z' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:28:21'!
test08CorrectlyEncodesATwoCharStringWithNoSpecialCharacters
	
	self assert: 'nm' equals: 'az' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:33:20'!
test09CorrectlyEncodesMoreThanTwoCharStringWithNoSpecialCharacters
	
	self assert: 'uByN' equals: 'hOlA' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:47:59'!
test10CorrectlyEncodesSpecialCharactersWithNoChange
	
	self assert: '&án%( ñ4' equals: '&áa%( ñ4' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'JDR 5/9/2022 18:55:18'!
testExtraToCheckGeneralizationOnKata
		
	self assert: 'Ju3er j3 4e3 t01at j3 q0ag a3rq e04q$...' equals: 'Wh3re w3 4r3 g01ng w3 d0nt n3ed r04d$...' asRot13
	! !
