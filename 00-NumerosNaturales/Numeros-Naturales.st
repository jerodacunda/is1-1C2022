!classDefinition: #I category: 'Numeros-Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros-Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next' stamp: 'ARM 3/31/2022 21:18:47'!
next

	^II! !


!I class methodsFor: 'operations' stamp: 'JDR 4/4/2022 20:39:38'!
* multiplicando
	^multiplicando! !

!I class methodsFor: 'operations' stamp: 'JDR 4/5/2022 15:39:22'!
+ sumando

	^sumando next! !

!I class methodsFor: 'operations' stamp: 'JDR 4/7/2022 01:21:31'!
- sustraendo

	self error: self negativeNumbersNotSupportedErrorDescription! !

!I class methodsFor: 'operations' stamp: 'JDR 4/7/2022 01:22:11'!
/ divisor

	self = divisor ifTrue:[^self].
	self error: self canNotDivideByBiggerNumberErrorDescription! !

!I class methodsFor: 'operations' stamp: 'JDR 4/7/2022 01:02:24'!
< unNatural
	
	unNatural = I ifTrue: [^false].
	^true! !

!I class methodsFor: 'operations' stamp: 'JDR 4/7/2022 01:23:53'!
> unNatural

	^false! !

!I class methodsFor: 'operations' stamp: 'JDR 4/7/2022 01:22:10'!
canNotDivideByBiggerNumberErrorDescription

	^'No se puede dividir un número por otro mayor'! !

!I class methodsFor: 'operations' stamp: 'JDR 4/7/2022 01:21:31'!
negativeNumbersNotSupportedErrorDescription

	^ 'Resultado no natural - Numeros negativos no soportados'! !

!I class methodsFor: 'operations' stamp: 'JDR 4/4/2022 20:18:03'!
previous
	self shouldBeImplemented.! !

!I class methodsFor: 'operations' stamp: 'JDR 4/4/2022 20:30:30'!
sustraeteDe: minuendo

	^minuendo previous! !


!classDefinition: #II category: 'Numeros-Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros-Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones' stamp: 'JDR 4/4/2022 20:40:29'!
* unNatural

	^unNatural + (self previous * unNatural)! !

!II class methodsFor: 'operaciones' stamp: 'ARM 3/31/2022 21:27:43'!
+ unNatural

	^previous + unNatural next! !

!II class methodsFor: 'operaciones' stamp: 'JDR 4/4/2022 20:28:12'!
- sustraendo

	^sustraendo sustraeteDe: self! !

!II class methodsFor: 'operaciones' stamp: 'JDR 4/7/2022 01:22:10'!
/ divisor

	self < divisor ifTrue:[self error: self canNotDivideByBiggerNumberErrorDescription].

	divisor = self ifTrue:[^I].
	divisor = I ifTrue:[^self].
	^ I + ((self - divisor)/divisor).! !

!II class methodsFor: 'operaciones' stamp: 'JDR 4/7/2022 01:01:15'!
< unNatural
	
	self = unNatural ifTrue:[^false].
	self = I ifTrue:[^true].
	unNatural = I ifTrue:[^false].

	^self previous < unNatural previous! !

!II class methodsFor: 'operaciones' stamp: 'JDR 4/7/2022 01:05:05'!
> unNatural

	unNatural < self ifTrue:[^true].
	^false! !

!II class methodsFor: 'operaciones' stamp: 'JDR 4/7/2022 01:22:10'!
canNotDivideByBiggerNumberErrorDescription

	^'No se puede dividir un número por otro mayor'! !

!II class methodsFor: 'operaciones' stamp: 'JDR 4/4/2022 20:29:56'!
sustraeteDe: minuendo

	^minuendo previous - self previous! !


!II class methodsFor: 'next & previous' stamp: 'JDR 4/5/2022 14:31:39'!
nameOfNext
	
	(self name endsWith: 'CMXCIX') ifTrue:[^(self name withoutSuffix: ''), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue:[^(self name withoutSuffix: ''), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue:[^(self name withoutSuffix: ''), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue:[^(self name withoutSuffix: ''), 'CD'].			
	
	(self name endsWith: 'XCIX') ifTrue:[^(self name withoutSuffix: 'XCIX'), 'C'].	
	(self name endsWith: 'LXXXIX') ifTrue:[^(self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue:[^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue:[^(self name withoutSuffix: 'XXXIX'), 'XL'].
	
	(self name endsWith: 'IX') ifTrue:[^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue:[^(self name withoutSuffix: 'VIII'), 'IX'].	
	(self name endsWith: 'IV') ifTrue:[^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue:[^(self name withoutSuffix: 'III'), 'IV'].
	
	^ self name , 'I'! !

!II class methodsFor: 'next & previous' stamp: 'JDR 4/4/2022 20:53:15'!
next
	next ifNotNil:[^next].
	next _ II createChildNamed: self nameOfNext.
	next previous: self.
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:26:45'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:55'!
previous: unNatural 
	
	previous _ unNatural! !


!II class methodsFor: 'as yet unclassified' stamp: 'JDR 4/4/2022 21:24:16'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next _ nil.
	]! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'JDR 4/7/2022 01:26:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros-Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros-Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'JDR 4/7/2022 01:26:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'Numeros-Naturales'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Numeros-Naturales'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'JDR 4/7/2022 01:26:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!