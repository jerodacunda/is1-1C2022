!classDefinition: #TDDBabyStepsPrimeFactorsTest category: 'TDDBabyStepsGamePrimeFactors'!
TestCase subclass: #TDDBabyStepsPrimeFactorsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGamePrimeFactors'!

!TDDBabyStepsPrimeFactorsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 19:44:16'!
test01OneHasNoPrimeFactors
	
	self assert: Bag new equals: 1 factorize
	! !

!TDDBabyStepsPrimeFactorsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 19:46:06'!
test02FactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 2) equals: 2 factorize
	! !

!TDDBabyStepsPrimeFactorsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 19:47:19'!
test03FactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 3) equals: 3 factorize
	! !

!TDDBabyStepsPrimeFactorsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 19:47:59'!
test04CorrectlyFactorizesACompositeNumberWithTwoFactors2
	
	self assert: (Bag with: 2 with: 2) equals: 4 factorize
	! !

!TDDBabyStepsPrimeFactorsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 19:53:02'!
test08CorrectlyFactorizesACompositeNumberWithMoreThanTwoFactors2
	
	self assert: (Bag with: 2 with: 2 with: 2) equals: 8 factorize
	! !

!TDDBabyStepsPrimeFactorsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 20:03:37'!
test09CorrectlyFactorizesACompositeNumberWithMoreThanOneFactorsDifferentThan2
	
	self assert: (Bag with: 3 with: 3) equals: 9 factorize
	! !

!TDDBabyStepsPrimeFactorsTest methodsFor: 'tests' stamp: 'JDR 5/9/2022 20:56:09'!
testExtraToCheckGeneralizationOnKata
	
	self assert: (Bag with: 2 with: 2 with: 3 with: 3 with: 5 with: 13) equals: (2*2*3*3*5*13) factorize
	! !
