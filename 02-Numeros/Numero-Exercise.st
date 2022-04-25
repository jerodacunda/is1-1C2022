!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 02:08:19'!
* aMultiplier 
	
	^aMultiplier multiplyByEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 01:56:21'!
+ anAdder 

	^anAdder addToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 14:57:09'!
- aSubtrahend 

	^aSubtrahend subtractFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 14:35:43'!
/ aDivisor 
	
	^aDivisor dividesEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:23:22'!
addToEntero: anEnteroAdder

	^self class with: value + anEnteroAdder integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:23:29'!
addToFraccion: aFraccionAdder

	| newDenominator newNumerator |
	newNumerator := (self  * aFraccionAdder denominator ) + aFraccionAdder numerator.
	newDenominator := aFraccionAdder denominator.
		
	^newNumerator / newDenominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:23:36'!
dividesEntero: anEnteroDividend

	^Fraccion with: anEnteroDividend over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:23:43'!
dividesFraccion: aFraccionDividend

	^aFraccionDividend numerator / (self * aFraccionDividend denominator)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 19:54:26'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 21:02:46'!
greatestCommonDivisorWith: anEntero 
	
	^Entero with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:23:55'!
multiplyByEntero: anEnteroMultiplier

	^self class with: value * anEnteroMultiplier integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:24:02'!
multiplyByFraccion: aFraccionMultiplier

	| newNumerator |
	newNumerator := aFraccionMultiplier numerator * self.
		
	^newNumerator / aFraccionMultiplier denominator	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 14:57:17'!
subtractFromEntero: anEnteroMinuend

	^ self class with: (anEnteroMinuend integerValue - value)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 14:56:24'!
subtractFromFraccion: aFraccionMinuend 

	 | newDenominator newNumerator |	
	newNumerator := aFraccionMinuend numerator - (self  * aFraccionMinuend denominator ).
	newDenominator := aFraccionMinuend denominator.
		
	^newNumerator / newDenominator! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'JDR 4/24/2022 19:55:07'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:00:53'!
isNegative
	
	self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:01:03'!
isOne
	
	self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:01:06'!
isZero
	
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'JDR 4/24/2022 21:12:18'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	| enteroClass |
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	enteroClass := Entero subclasses detect: [ :unEnteroClass | unEnteroClass correspondingTo: aValue] ifNone: [self error: 'No se puede inicializar ese valor'].
	^enteroClass new initializeWith: aValue! !


!Entero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:01:30'!
isNegative

	^false! !

!Cero methodsFor: 'testing' stamp: 'JDR 4/24/2022 19:59:51'!
isOne

	^false! !

!Cero methodsFor: 'testing' stamp: 'JDR 4/24/2022 19:59:06'!
isZero

	^true! !


!Cero methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 19:54:08'!
fibonacci

	^Entero with: 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'subclass creation' stamp: 'JDR 4/24/2022 21:11:32'!
correspondingTo: aValue

	 ^aValue = 0! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:01:39'!
isNegative

	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'JDR 4/24/2022 19:59:59'!
isOne

	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'JDR 4/24/2022 19:59:41'!
isZero

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'subclass creation' stamp: 'JDR 4/24/2022 21:12:17'!
correspondingTo: aValue

	^aValue > 1! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 19:53:49'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription! !


!Negativo methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:01:51'!
isNegative

	^true! !

!Negativo methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:00:02'!
isOne

	^false! !

!Negativo methodsFor: 'testing' stamp: 'JDR 4/24/2022 19:59:19'!
isZero

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativo class' category: 'Numero-Exercise'!
Negativo class
	instanceVariableNames: ''!

!Negativo class methodsFor: 'subclass creation' stamp: 'JDR 4/24/2022 21:12:17'!
correspondingTo: aValue

	^aValue < 0! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 19:54:15'!
fibonacci

	^Entero with: 1! !


!Uno methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:01:43'!
isNegative

	^false! !

!Uno methodsFor: 'testing' stamp: 'JDR 4/24/2022 20:00:10'!
isOne

	^true! !

!Uno methodsFor: 'testing' stamp: 'JDR 4/24/2022 19:59:30'!
isZero

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'subclass creation' stamp: 'JDR 4/24/2022 21:12:17'!
correspondingTo: aValue

	^aValue = 1! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 02:08:52'!
* aMultiplier 

	^aMultiplier multiplyByFraccion: self
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 01:57:14'!
+ anAdder 

	^anAdder addToFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 14:56:41'!
- aSubtrahend 
	
	^aSubtrahend subtractFromFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 14:37:03'!
/ aDivisor 
	
	^aDivisor dividesFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:24:49'!
addToEntero: anEnteroAdder 

	|newDenominator newNumerator | 
	
	newNumerator := (anEnteroAdder  * self denominator ) + self numerator.
	newDenominator := self denominator.
		
	^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:24:54'!
addToFraccion: aFraccionAdder

	| newDenominator newNumerator |
	newNumerator := (numerator * aFraccionAdder denominator) + (denominator * aFraccionAdder numerator).
	newDenominator := denominator * aFraccionAdder denominator.

	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:24:59'!
dividesEntero: anEnteroDividend

	^Fraccion with: (self denominator * anEnteroDividend)	 over: (self numerator) ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:25:05'!
dividesFraccion: aFraccionDividend

	^ (self denominator * aFraccionDividend numerator) / (self numerator * aFraccionDividend denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:25:12'!
multiplyByEntero: anEnteroMultiplier

	| newNumerator |
	newNumerator := (anEnteroMultiplier * self numerator).
	
	^newNumerator / self denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/24/2022 20:25:18'!
multiplyByFraccion: aFraccionMultiplier 

	^(self numerator * aFraccionMultiplier numerator) / (self denominator * aFraccionMultiplier denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 14:57:35'!
subtractFromEntero: anEnteroMinuend

	| newDenominator newNumerator |
	newNumerator := (denominator * anEnteroMinuend)	 - numerator.
	newDenominator := denominator.
		
	^newNumerator / newDenominator	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JDR 4/22/2022 14:56:47'!
subtractFromFraccion: aFraccionMinuend 
	
	| newNumerator newDenominator |
	newNumerator := (aFraccionMinuend numerator * denominator) - (aFraccionMinuend denominator * numerator).
	newDenominator := denominator * aFraccionMinuend denominator.
	
	^newNumerator / newDenominator 
! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'JDR 4/24/2022 22:35:16'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator 
	
! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'JDR 4/25/2022 00:12:40'!
with: aDividend over: aDivisor	

	| divisor greatestCommonDivisor dividend fraccionClass |
	greatestCommonDivisor := aDivisor greatestCommonDivisorWith: aDividend. 
	dividend := aDividend // greatestCommonDivisor.
	divisor := aDivisor // greatestCommonDivisor.
	
	fraccionClass := Fraccion subclasses detect: 	
			[ :unFraccionClass | unFraccionClass correspondsTo: dividend with: divisor] .
		

	^fraccionClass with: dividend over: divisor
	! !



!classDefinition: #FraccionConDividendoCero category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConDividendoCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConDividendoCero class' category: 'Numero-Exercise'!
FraccionConDividendoCero class
	instanceVariableNames: ''!

!FraccionConDividendoCero class methodsFor: 'subclass creation' stamp: 'JDR 4/24/2022 23:54:27'!
correspondsTo: aDividend with: aDivisor

	^aDividend isZero! !


!FraccionConDividendoCero class methodsFor: 'instance creation' stamp: 'JDR 4/25/2022 00:12:40'!
with: aDividend over: aDivisor

	^aDivisor ! !


!classDefinition: #FraccionConDivisorCero category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConDivisorCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConDivisorCero class' category: 'Numero-Exercise'!
FraccionConDivisorCero class
	instanceVariableNames: ''!

!FraccionConDivisorCero class methodsFor: 'subclass creation' stamp: 'JDR 4/24/2022 23:55:04'!
correspondsTo: aDividend with: aDivisor

	^aDivisor isZero! !


!FraccionConDivisorCero class methodsFor: 'instance creation' stamp: 'JDR 4/25/2022 00:12:40'!
with: aDividend over: aDivisor

	self error: self canNotDivideByZeroErrorDescription! !


!classDefinition: #FraccionConDivisorMayorAUnoYDividendoDistintoDeCero category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConDivisorMayorAUnoYDividendoDistintoDeCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConDivisorMayorAUnoYDividendoDistintoDeCero class' category: 'Numero-Exercise'!
FraccionConDivisorMayorAUnoYDividendoDistintoDeCero class
	instanceVariableNames: ''!

!FraccionConDivisorMayorAUnoYDividendoDistintoDeCero class methodsFor: 'subclass creation' stamp: 'JDR 4/25/2022 00:09:48'!
correspondsTo: aDividend with: aDivisor

	^(aDividend isZero not) and: [aDivisor integerValue > 1]! !


!FraccionConDivisorMayorAUnoYDividendoDistintoDeCero class methodsFor: 'instance creation' stamp: 'JDR 4/25/2022 00:12:40'!
with: aDividend over: aDivisor

	^self new initializeWith: aDividend over: aDivisor! !


!classDefinition: #FraccionConDivisorNegativo category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConDivisorNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConDivisorNegativo class' category: 'Numero-Exercise'!
FraccionConDivisorNegativo class
	instanceVariableNames: ''!

!FraccionConDivisorNegativo class methodsFor: 'subclass creation' stamp: 'JDR 4/24/2022 23:55:21'!
correspondsTo: aDividend with: aDivisor

	^aDivisor isNegative! !


!FraccionConDivisorNegativo class methodsFor: 'instance creation' stamp: 'JDR 4/25/2022 00:12:40'!
with: aDividend over: aDivisor

	^aDividend negated / aDivisor negated! !


!classDefinition: #FraccionConDivisorUno category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConDivisorUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConDivisorUno class' category: 'Numero-Exercise'!
FraccionConDivisorUno class
	instanceVariableNames: ''!

!FraccionConDivisorUno class methodsFor: 'instance creation' stamp: 'JDR 4/25/2022 00:12:40'!
with: aDividend over: aDivisor

	^aDividend! !


!FraccionConDivisorUno class methodsFor: 'subclass creation' stamp: 'JDR 4/24/2022 23:52:01'!
correspondsTo: aDividend with: aDivisor

	^aDivisor isOne! !
