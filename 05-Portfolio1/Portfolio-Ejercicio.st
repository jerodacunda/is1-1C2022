!classDefinition: #PortfolioTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:29:51'!
test01

	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: 0 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:31:50'!
test02

	| portfolio account |
	
	account _ ReceptiveAccount new.	
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account.
	
	portfolio addXxx: account.
	
	self assert: 100 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:31:54'!
test03

	| portfolio account portfolioToAdd |
	
	account _ ReceptiveAccount new.	
	portfolioToAdd _ Portfolio new.	
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account.
	
	portfolioToAdd addXxx: account.
	portfolio addXxx: portfolioToAdd.
	
	self assert: 100 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:34:02'!
test04

	| portfolio account1 account2 |
	
	account1 _ ReceptiveAccount new.	
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account1.
	
	Deposit register: 100 on: account2.
	Withdraw register: 75 on: account2.	
	
	portfolio addXxx: account1.
	portfolio addXxx: account2.
	
	self assert: 125 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:34:07'!
test05

	| portfolio account1 account2 portfolioToAdd1 portfolioToAdd2 |
	
	account1 _ ReceptiveAccount new.	
	account2 _ ReceptiveAccount new.
	portfolioToAdd1 _ Portfolio new.
	portfolioToAdd2 _ Portfolio new.
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account1.	
	
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.	
	
	portfolioToAdd1 addXxx: account1.	
	portfolioToAdd2 addXxx: account2.	
	
	portfolio addXxx: portfolioToAdd1.
	portfolio addXxx: portfolioToAdd2.
	
	self assert: 150 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:34:27'!
test06

	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: portfolio transactions isEmpty
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:34:44'!
test07

	| portfolio account |
	
	account _ ReceptiveAccount new.	
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account. 
	
	portfolio addXxx: account.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: account transactions equals: portfolio transactions 
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:35:09'!
test08

	| portfolio account1 account2 |
	
	account1 _ ReceptiveAccount new.	
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account1. 
	
	Deposit register: 50 on: account2.
	Withdraw register: 10 on: account2.
	
	portfolio addXxx: account1.
	portfolio addXxx: account2.
	
	self assert: 3 equals: portfolio transactions size.
	self assert: (account1 transactions, account2 transactions) asSet equals: portfolio transactions asSet.
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:36:35'!
test09

	| portfolio portfolioToAdd account1 account2 |
	
	account1 _ ReceptiveAccount new.	
	account2 _ ReceptiveAccount new.
	portfolioToAdd _ Portfolio new.
	portfolio _ Portfolio new.
	
	Deposit register: 10 on: account1. 
	
	Deposit register: 100 on: account2. 
	Withdraw register: 50 on: account2.	
	
	portfolioToAdd addXxx: account2.	
	portfolio addXxx: account1.
	portfolio addXxx: portfolioToAdd. 
	
	self assert: 3 equals: portfolio transactions size.
	self assert: (account1 transactions, portfolioToAdd transactions) asSet equals: portfolio transactions asSet
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:37:07'!
test10
	
	| account deposit portfolio |
	
	account _ ReceptiveAccount new.	
	portfolio _ Portfolio new.
	
	deposit _ Deposit register: 10 on: account. 
	
	portfolio addXxx: account.
	
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:38:22'!
test11
	
	| portfolio account1 account2 deposit1 deposit2 portfolioToAdd withdraw |
	
	account1 _ ReceptiveAccount new.	
	account2 _ ReceptiveAccount new.
	portfolioToAdd _ Portfolio new.
	portfolio _ Portfolio new.
	
	deposit1 _ Deposit register: 10 on: account1.
	
	deposit2 _ Deposit register: 50 on: account2.
	withdraw _ Withdraw register: 20 on: account2.	
	
	portfolioToAdd addXxx: account1.	
	
	portfolio addXxx: portfolioToAdd.
	portfolio addXxx: account2.
	
	self assert: (portfolio hasRegistered: deposit1).
	self assert: (portfolio hasRegistered: deposit2).
	self assert: (portfolio hasRegistered: withdraw).
	self deny: (portfolioToAdd hasRegistered: deposit2).
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:42:04'!
test12

	| account portfolio |
	
	account _ ReceptiveAccount new.	
	portfolio _ Portfolio new.
	
	portfolio addXxx: account.
	
	self should: [ portfolio addXxx: portfolio ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Portfolio xxxIsAlreadyAddedErrorDescription ]
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:41:50'!
test13

	| account portfolio portfolioParent |
	
	account _ ReceptiveAccount new.	
	portfolio _ Portfolio new.	
	portfolioParent _ Portfolio new.
	
	portfolio addXxx: account.
	portfolioParent addXxx: portfolio.
	
	self should: [ portfolioParent addXxx: portfolio ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Portfolio xxxIsAlreadyAddedErrorDescription ]
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:41:40'!
test14

	| account portfolioParent portfolio |
	
	account _ ReceptiveAccount new.	
	portfolioParent _ Portfolio new.	
	portfolio _ Portfolio new.
	
	portfolio addXxx: account.
	
	portfolioParent addXxx: portfolio.	
	
	self should: [ portfolioParent addXxx: account ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Portfolio xxxIsAlreadyAddedErrorDescription ]
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:40:33'!
test15

	| portfolio portfolioParent |
	
	portfolio _ Portfolio new.
	portfolioParent _ Portfolio new.
	
	portfolioParent addXxx: portfolio.
	
	self should: [ portfolio addXxx: portfolioParent ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Portfolio xxxIsAlreadyAddedErrorDescription ]
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:40:43'!
test16

	| portfolio portfolioParent1 portfolioParent2 |
	
	portfolio _ Portfolio new.	
	portfolioParent1 _ Portfolio new.	
	portfolioParent2 _ Portfolio new.
	
	portfolioParent1 addXxx: portfolio.
	portfolioParent2 addXxx: portfolio.	
	
	self should: [ portfolio addXxx: portfolioParent1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Portfolio xxxIsAlreadyAddedErrorDescription ]
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:40:50'!
test17

	| portfolio portfolioGrandParent portfolioParent |
	
	portfolio _ Portfolio new.
	portfolioParent _ Portfolio new.	
	portfolioGrandParent _ Portfolio new.
	
	portfolioGrandParent addXxx: portfolioParent.
	portfolioParent addXxx: portfolio.	
	
	self should: [ portfolio addXxx: portfolioGrandParent ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Portfolio xxxIsAlreadyAddedErrorDescription ]
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/22/2022 18:41:21'!
test18

	| account portfolio portfolioParent1 portfolioParent2 |
	
	account _ ReceptiveAccount new.	
	portfolioParent1 _ Portfolio new.	
	portfolioParent2 _ Portfolio new.
	portfolio _ Portfolio new.
		
	portfolioParent1 addXxx: portfolio.
	portfolioParent2 addXxx: portfolio.
	portfolioParent2 addXxx: account.	
	
	self should: [ portfolio addXxx: account ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Portfolio xxxIsAlreadyAddedErrorDescription ]
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:18:39'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'JDR 5/16/2022 20:50:27'!
addTo: aBalanceBeingCalculated 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 20:50:27'!
addTo: aBalanceBeingCalculated 
	
	^aBalanceBeingCalculated + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 20:50:27'!
addTo: aBalanceBeingCalculated 
	
	^aBalanceBeingCalculated - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #XXX category: 'Portfolio-Ejercicio'!
Object subclass: #XXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 19:14:31'!
balance

	self subclassResponsibility ! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 19:14:08'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 19:14:49'!
initialize

	self subclassResponsibility ! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 19:14:22'!
transactions 

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
XXX subclass: #Portfolio
	instanceVariableNames: 'xxxs parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 22:20:12'!
addRootsTo: aSetOfRoots

	(self isRoot) 
		ifTrue: [aSetOfRoots add: self] 
		ifFalse: [	parents do: [ :aParent | aParent addRootsTo: aSetOfRoots ] ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 22:22:00'!
addXxx: aXxx
	
	| roots |
		
	roots _ self findRoots.
	roots do: [ :aRoot | aRoot assertAXxxIsNotDescendant: aXxx. ].
	
	xxxs add: aXxx.
	(aXxx isKindOf: Portfolio) ifTrue: [aXxx markAsParent: self]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 21:45:59'!
assertAXxxIsNotDescendant: aXxx	
		
	(aXxx = self) ifTrue: [self error: Portfolio xxxIsAlreadyAddedErrorDescription].
	
	xxxs do: [ :xxx | 		
		(xxx = aXxx) ifTrue: [self error: Portfolio xxxIsAlreadyAddedErrorDescription] .
		(xxx isKindOf: Portfolio) ifTrue: [ xxx assertAXxxIsNotDescendant: aXxx ].
	].
	
	
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 19:31:27'!
balance
	
	| balance |
	
	balance _ 0.

	xxxs do: [ :xxx | balance _ xxx balance + balance].
	
	^balance! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 22:22:56'!
findRoots

	| roots |
	roots _ Set new.
	self addRootsTo: roots.
	
	^roots! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 19:35:47'!
hasRegistered: aTransaction 
	
	^xxxs anySatisfy: [ :aXxx | aXxx hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 21:20:08'!
initialize

	xxxs _ Set new.
	parents _ OrderedCollection new.	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 21:38:38'!
isRoot
	
	^parents isEmpty! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 21:20:08'!
markAsParent: aPortfolio

	parents add: aPortfolio! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 19:33:21'!
transactions

	| transactions |
	
	transactions _ OrderedCollection new.
	xxxs do: [ :aXxx | transactions addAll: aXxx transactions].
	
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 20:20:38'!
portfolioCannotBeAddedToItselfErrorDescription

	^'cannot add a portfolio into itself'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JDR 5/21/2022 20:25:58'!
xxxIsAlreadyAddedErrorDescription

	'xxx is already added in portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
XXX subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'JDR 5/16/2022 20:50:46'!
balance

	| balance |
	balance _ 0.
	transactions do: [ :aTransaction | balance _ aTransaction addTo: balance 	].
	
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
