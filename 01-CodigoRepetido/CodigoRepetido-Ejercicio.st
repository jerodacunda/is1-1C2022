!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/12/2022 20:04:16'!
assertExecuting: aClosure shouldRaise: anErrorClass andMustKeepValid: aCustomerBook
	
	aClosure 
		on: anErrorClass 
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: 'John Lennon') ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/12/2022 19:06:43'!
assertThat: aCustomerBook with: anAmountOfCostumers hasActive: anAmountOfActiveCostumers andSuspended: anAmountOfSuspendedCostumers

	self assert: anAmountOfActiveCostumers equals: aCustomerBook numberOfActiveCustomers.
	self assert: anAmountOfSuspendedCostumers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: anAmountOfCostumers equals: aCustomerBook numberOfCustomers.

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/12/2022 20:16:48'!
createCustomerBookWith: aCustomer

	
	| customerBook|
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: aCustomer.

	^customerBook	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/11/2022 21:40:41'!
execute: aClosure shouldNotTakeMoreThan: anAmountOfMilliseconds 

	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (anAmountOfMilliseconds)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/11/2022 21:38:58'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook aClosure |
	
	customerBook := CustomerBook new.
	
	aClosure _ [customerBook addCustomerNamed: 'John Lennon'.].
	
	self execute: aClosure shouldNotTakeMoreThan: 50 * millisecond.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/11/2022 21:43:03'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney aClosure |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	aClosure _ [customerBook removeCustomerNamed: paulMcCartney.].
	
	self execute: aClosure shouldNotTakeMoreThan: 100 * millisecond.
	  
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/12/2022 20:33:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon errorClass removeCustomerFromBookClosure |
			
	johnLennon := 'John Lennon'.
	customerBook _ self createCustomerBookWith: johnLennon.	
	
	removeCustomerFromBookClosure _ [ 
		customerBook removeCustomerNamed: 'Paul McCartney'.
		self fail
	].
	errorClass _ NotFound.

	self assertExecuting: removeCustomerFromBookClosure shouldRaise:  errorClass andMustKeepValid: customerBook.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/12/2022 20:34:02'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney anAmountOfCostumers activeCostumers suspendedCostumers|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook _ self createCustomerBookWith: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	anAmountOfCostumers _ 1.
	activeCostumers _ 0.
	suspendedCostumers _ 1.
	
	self assertThat: customerBook with: anAmountOfCostumers hasActive: activeCostumers andSuspended: suspendedCostumers.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/12/2022 20:31:06'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney activeCostumers anAmountOfCostumers suspendedCostumers |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook _ self createCustomerBookWith: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.	
	
	anAmountOfCostumers _ 0.
	activeCostumers _ 0.
	suspendedCostumers _ 0.	
	
	self assertThat: customerBook with: anAmountOfCostumers hasActive: activeCostumers andSuspended: suspendedCostumers.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/12/2022 20:33:34'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon errorClass suspendCustomerFromBookClosure |
	
	johnLennon := 'John Lennon'.
	customerBook _ self createCustomerBookWith: johnLennon.	
	
	suspendCustomerFromBookClosure _ [ 
		customerBook suspendCustomerNamed: 'George Harrison'.
		self fail 
	].
	errorClass _ CantSuspend.

	self assertExecuting: suspendCustomerFromBookClosure shouldRaise:  errorClass andMustKeepValid: customerBook.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JDR 4/12/2022 20:33:41'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon errorClass suspendCustomerFromBookClosure |
	
	johnLennon := 'John Lennon'.
	customerBook _ self createCustomerBookWith: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	suspendCustomerFromBookClosure _ [ 
		customerBook suspendCustomerNamed: johnLennon.
		self fail 
	].
	errorClass _ CantSuspend.

	self assertExecuting: suspendCustomerFromBookClosure shouldRaise:  errorClass andMustKeepValid: customerBook.
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JDR 4/12/2022 20:50:45'!
removeCustomerNamed: aName 
 

	^active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^ NotFound signal.].].
	

	
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
