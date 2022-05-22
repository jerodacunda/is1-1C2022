!classDefinition: #PortfolioTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTests methodsFor: 'testing - balance' stamp: 'AF 5/22/2022 19:07:12'!
test01AnEmptyPortfolioShouldHaveZeroBalance

	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: 0 equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'testing - balance' stamp: 'AF 5/22/2022 19:10:36'!
test02BalanceOfPortfolioWithAnAccountShouldBeAccountBalance

	| portfolio account |
	
	account _ ReceptiveAccount new.	
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account.
	
	portfolio addBankAccount: account.
	
	self assert: account balance equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'testing - balance' stamp: 'AF 5/22/2022 19:11:46'!
test03BalanceOfPortfolioWithPortfolioShouldBeInnerPortfolioBalance

	| portfolio account portfolioToAdd |
	
	account _ ReceptiveAccount new.	
	portfolioToAdd _ Portfolio new.	
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account.
	
	portfolioToAdd addBankAccount: account.
	portfolio addBankAccount: portfolioToAdd.
	
	self assert: portfolioToAdd balance equals: portfolio balance
	
! !

!PortfolioTests methodsFor: 'testing - balance' stamp: 'AF 5/22/2022 20:43:34'!
test05BalanceOfPortfolioWithAccountsShouldBeTheSumOfAccountsBalances

	| portfolio account1 account2 portfolioToAdd1 portfolioToAdd2 expectedBalance |
	
	account1 _ ReceptiveAccount new.	
	account2 _ ReceptiveAccount new.
	portfolioToAdd1 _ Portfolio new.
	portfolioToAdd2 _ Portfolio new.
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account1.	
	
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.	
	
	portfolioToAdd1 addBankAccount: account1.	
	portfolioToAdd2 addBankAccount: account2.	
	
	portfolio addBankAccount: portfolioToAdd1.
	portfolio addBankAccount: portfolioToAdd2.
	
	expectedBalance _ portfolioToAdd2 balance + portfolioToAdd1 balance.
	
	self assert: expectedBalance equals: portfolio balance
	
! !


!PortfolioTests methodsFor: 'testing - transactions' stamp: 'AF 5/22/2022 20:01:55'!
test06AnEmptyPortfolioShouldNotHaveAnyTransactions

	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: portfolio transactions isEmpty
	
! !

!PortfolioTests methodsFor: 'testing - transactions' stamp: 'AF 5/22/2022 19:17:45'!
test07TransactionsOfPortfolioWithAnAccountShouldBeAccountTransactions

	| portfolio account |
	
	account _ ReceptiveAccount new.	
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account. 
	
	portfolio addBankAccount: account.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: account transactions equals: portfolio transactions 
	
! !

!PortfolioTests methodsFor: 'testing - transactions' stamp: 'AF 5/22/2022 19:19:30'!
test08TransactionsOfPortfolioWithAccountsShouldBeAccountsTransactions

	| portfolio account1 account2 |
	
	account1 _ ReceptiveAccount new.	
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account1. 
	
	Deposit register: 50 on: account2.
	Withdraw register: 10 on: account2.
	
	portfolio addBankAccount: account1.
	portfolio addBankAccount: account2.
	
	self assert: 3 equals: portfolio transactions size.
	self assert: (account1 transactions, account2 transactions) asSet equals: portfolio transactions asSet.
	
! !

!PortfolioTests methodsFor: 'testing - transactions' stamp: 'AF 5/22/2022 19:25:49'!
test10PortfolioWithAnAccountShouldHaveItsAccountTransactionRegistered
	
	| account deposit portfolio |
	
	account _ ReceptiveAccount new.	
	portfolio _ Portfolio new.
	
	deposit _ Deposit register: 10 on: account. 
	
	portfolio addBankAccount: account.
	
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTests methodsFor: 'testing - transactions' stamp: 'AF 5/22/2022 19:26:10'!
test11PortfolioWithAccountsShouldHaveItsAccountsTransactionsRegistered
	
	| portfolio account1 account2 deposit1 deposit2 portfolioToAdd withdraw |
	
	account1 _ ReceptiveAccount new.	
	account2 _ ReceptiveAccount new.
	portfolioToAdd _ Portfolio new.
	portfolio _ Portfolio new.
	
	deposit1 _ Deposit register: 10 on: account1.
	
	deposit2 _ Deposit register: 50 on: account2.
	withdraw _ Withdraw register: 20 on: account2.	
	
	portfolioToAdd addBankAccount: account1.	
	
	portfolio addBankAccount: portfolioToAdd.
	portfolio addBankAccount: account2.
	
	self assert: (portfolio hasRegistered: deposit1).
	self assert: (portfolio hasRegistered: deposit2).
	self assert: (portfolio hasRegistered: withdraw).
	self deny: (portfolioToAdd hasRegistered: deposit2).
! !


!PortfolioTests methodsFor: 'testing - adding - assertions' stamp: 'AF 5/22/2022 20:38:44'!
shouldRaiseAnErrorWhenAdding: anAccountToAdd to: aPortfolio
	
	self should: [ aPortfolio addBankAccount: anAccountToAdd ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Portfolio bankAccountIsAlreadyAddedErrorDescription ]
! !


!PortfolioTests methodsFor: 'testing - adding' stamp: 'AF 5/22/2022 20:39:10'!
test12AddingPortfolioToItselfShouldRaiseAnError

	| portfolio |
	portfolio _ Portfolio new.
	
	self shouldRaiseAnErrorWhenAdding: portfolio to: portfolio.
! !

!PortfolioTests methodsFor: 'testing - adding' stamp: 'AF 5/22/2022 20:39:34'!
test13AddingAPortfolioTwiceShouldRaiseAnError

	| portfolio portfolioParent |
		
	portfolio _ Portfolio new.	
	portfolioParent _ Portfolio new.
	
	portfolioParent addBankAccount: portfolio.
	
	self shouldRaiseAnErrorWhenAdding: portfolioParent to: portfolio.
! !

!PortfolioTests methodsFor: 'testing - adding' stamp: 'AF 5/22/2022 20:40:29'!
test14AddingAnAccountThatIsRegisteredInADescendantShouldRaiseAnError

	| account portfolioParent portfolio |
	
	account _ ReceptiveAccount new.	
	portfolioParent _ Portfolio new.	
	portfolio _ Portfolio new.
	
	portfolio addBankAccount: account.
	
	portfolioParent addBankAccount: portfolio.	
	
	self shouldRaiseAnErrorWhenAdding: account to: portfolioParent
! !

!PortfolioTests methodsFor: 'testing - adding' stamp: 'AF 5/22/2022 20:40:48'!
test15AddingAParentShouldRaiseAnError

	| portfolio portfolioParent |
	
	portfolio _ Portfolio new.
	portfolioParent _ Portfolio new.
	
	portfolioParent addBankAccount: portfolio.
	
	self shouldRaiseAnErrorWhenAdding: portfolioParent to: portfolio
! !

!PortfolioTests methodsFor: 'testing - adding' stamp: 'AF 5/22/2022 20:41:08'!
test17AddingAnAncestorShouldRaiseAnError

	| portfolio portfolioGrandParent portfolioParent |
	
	portfolio _ Portfolio new.
	portfolioParent _ Portfolio new.	
	portfolioGrandParent _ Portfolio new.
	
	portfolioGrandParent addBankAccount: portfolioParent.
	portfolioParent addBankAccount: portfolio.	
	
	self shouldRaiseAnErrorWhenAdding: portfolioGrandParent to: portfolio! !

!PortfolioTests methodsFor: 'testing - adding' stamp: 'AF 5/22/2022 20:41:18'!
test18AddingAnAccountToAPortfolioThatIsAlreadyADescendantOfAnAncestorShouldRaiseAnError

	| account portfolio portfolioParent1 portfolioParent2 |
	
	account _ ReceptiveAccount new.	
	portfolioParent1 _ Portfolio new.	
	portfolioParent2 _ Portfolio new.
	portfolio _ Portfolio new.
		
	portfolioParent1 addBankAccount: portfolio.
	portfolioParent2 addBankAccount: portfolio.
	portfolioParent2 addBankAccount: account.	
	
	self shouldRaiseAnErrorWhenAdding: account to: portfolio
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


!classDefinition: #BankAccount category: 'Portfolio-Ejercicio'!
Object subclass: #BankAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAccount methodsFor: 'transactions' stamp: 'JDR 5/21/2022 19:14:22'!
transactions 

	self subclassResponsibility ! !


!BankAccount methodsFor: 'transactions - private' stamp: 'AF 5/22/2022 18:56:19'!
addTransactionsTo: aCollectionOfTransactions 

	self subclassResponsibility ! !


!BankAccount methodsFor: 'balance' stamp: 'JDR 5/21/2022 19:14:31'!
balance

	self subclassResponsibility ! !


!BankAccount methodsFor: 'testing' stamp: 'JDR 5/21/2022 19:14:08'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!BankAccount methodsFor: 'assertions' stamp: 'AF 5/22/2022 20:32:29'!
assertSubtreeDoesNotContain: aBankAccount

	self subclassResponsibility ! !


!BankAccount methodsFor: 'initialization' stamp: 'JDR 5/21/2022 19:14:49'!
initialize

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAccount subclass: #Portfolio
	instanceVariableNames: 'bankAccounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'AF 5/22/2022 20:21:27'!
addBankAccount: aBankAccount
	
	| roots |
		
	roots _ self findRoots.
	roots do: [ :aRoot | aRoot assertABankAnAccountIsNotAlreadyInTree: aBankAccount. ].
	
	bankAccounts add: aBankAccount.
	(aBankAccount isKindOf: Portfolio) ifTrue: [aBankAccount markAsParent: self]! !


!Portfolio methodsFor: 'assertions' stamp: 'AF 5/22/2022 20:33:15'!
assertABankAccountIsNotDescendant: aBankAccount

	^ bankAccounts do: [ :aRegisteredBankAccount | 		
		aRegisteredBankAccount assertSubtreeDoesNotContain: aBankAccount .
	]! !

!Portfolio methodsFor: 'assertions' stamp: 'AF 5/22/2022 20:33:15'!
assertABankAnAccountIsNotAlreadyInTree: aBankAccount	
		
	self assertSubtreeDoesNotContain: aBankAccount.
	
	
	! !

!Portfolio methodsFor: 'assertions' stamp: 'AF 5/22/2022 20:33:15'!
assertSubtreeDoesNotContain: aBankAccount

	(aBankAccount = self) ifTrue: [self error: Portfolio bankAccountIsAlreadyAddedErrorDescription].
	self assertABankAccountIsNotDescendant: aBankAccount! !


!Portfolio methodsFor: 'adding - private' stamp: 'JDR 5/21/2022 22:20:12'!
addRootsTo: aSetOfRoots

	(self isRoot) 
		ifTrue: [aSetOfRoots add: self] 
		ifFalse: [	parents do: [ :aParent | aParent addRootsTo: aSetOfRoots ] ]! !

!Portfolio methodsFor: 'adding - private' stamp: 'AF 5/22/2022 19:04:20'!
findRoots

	| roots |
	roots _ Set new.
	self addRootsTo: roots.
	^roots! !

!Portfolio methodsFor: 'adding - private' stamp: 'JDR 5/21/2022 21:38:38'!
isRoot
	
	^parents isEmpty! !

!Portfolio methodsFor: 'adding - private' stamp: 'JDR 5/21/2022 21:20:08'!
markAsParent: aPortfolio

	parents add: aPortfolio! !


!Portfolio methodsFor: 'transactions - private' stamp: 'AF 5/22/2022 19:01:23'!
addTransactionsTo: aCollectionOfTransactions

	bankAccounts do: [ :aBankAccount | aBankAccount addTransactionsTo: aCollectionOfTransactions].
	
	! !


!Portfolio methodsFor: 'balance' stamp: 'AF 5/22/2022 19:03:55'!
balance
	
	| balance |
	
	balance _ 0.

	bankAccounts do: [ :aRegisteredBankAccount | balance _ aRegisteredBankAccount balance + balance].
	
	^balance! !


!Portfolio methodsFor: 'testing' stamp: 'AF 5/22/2022 19:04:38'!
hasRegistered: aTransaction 
	
	^bankAccounts anySatisfy: [ :aRegisteredBankAccount | aRegisteredBankAccount hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'initialization' stamp: 'AF 5/22/2022 19:01:15'!
initialize

	bankAccounts _ Set new.
	parents _ OrderedCollection new.	! !


!Portfolio methodsFor: 'transactions' stamp: 'AF 5/22/2022 18:54:23'!
transactions

	| transactions |
	
	transactions _ OrderedCollection new.
	self addTransactionsTo: transactions.
	
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error decriptions' stamp: 'AF 5/22/2022 19:05:32'!
bankAccountIsAlreadyAddedErrorDescription

	'bank account is already added in portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAccount subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'AF 5/22/2022 18:55:20'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'AF 5/22/2022 20:33:15'!
assertSubtreeDoesNotContain: aBankAccount

	(aBankAccount = self) ifTrue: [self error: Portfolio bankAccountIsAlreadyAddedErrorDescription]! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
