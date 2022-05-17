!classDefinition: #PortfolioTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 20:59:42'!
test01

	| portfolio |
	portfolio _ Portfolio new.
	
	self assert: 0 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:13:34'!
test02

	| portfolio account |
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio _ Portfolio new.
	portfolio addAccount: account.
	
	self assert: 100 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:23:39'!
test03

	| portfolio account portfolioToAdd |
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolioToAdd _ Portfolio new.
	portfolioToAdd addAccount: account.
	
	portfolio _ Portfolio new.
	portfolio addPortfolio: portfolioToAdd.
	
	self assert: 100 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:35:14'!
test04

	| portfolio account1 account2 |
	account1 _ ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	account2 _ ReceptiveAccount new.
	Deposit register: 100 on: account2.
	Withdraw register: 75 on: account2.
	
	portfolio _ Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: 125 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:42:10'!
test05

	| portfolio account1 account2 portfolioToAdd1 portfolioToAdd2 |
	account1 _ ReceptiveAccount new.
	Deposit register: 100 on: account1.	
	
	account2 _ ReceptiveAccount new.
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.
	
	portfolioToAdd1 _ Portfolio new.
	portfolioToAdd1 addAccount: account1.
	
	portfolioToAdd2 _ Portfolio new.
	portfolioToAdd2 addAccount: account2.
	
	portfolio _ Portfolio new.
	portfolio addPortfolio: portfolioToAdd1.
	portfolio addPortfolio: portfolioToAdd2.
	
	self assert: 150 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:49:43'!
test06

	| portfolio |
	portfolio _ Portfolio new.
	
	self assert: portfolio transactions isEmpty
	
! !

!PortfolioTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:59:49'!
test07

	| portfolio account |
	
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account. 
	
	portfolio _ Portfolio new.
	portfolio addAccount: account.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: account transactions equals: portfolio transactions 
	
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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:37:42'!
addAccount: anAccount

	accounts add: anAccount

	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:43:12'!
addPortfolio: aPortfolio 
	
	portfolios add: aPortfolio! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:43:58'!
balance
	
	| balance |
	
	balance _ 0.

	accounts do: [:account | balance _ account balance + balance].
	portfolios do: [:portfolio | balance _ portfolio balance + balance].
	
	^balance! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:43:12'!
initialize

	accounts _ OrderedCollection new.
	portfolios _ OrderedCollection new.
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/16/2022 21:58:24'!
transactions
	| transacctions |
	transacctions _ OrderedCollection new.
	accounts ifNotEmpty: [transacctions addAll: accounts first transactions].
	
	^transacctions.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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
