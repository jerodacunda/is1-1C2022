!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 12:22:35'!
test01
	
	| account expectedReport |
	
	account := ReceptiveAccount  new.
	
	expectedReport _ OrderedCollection with: 'Balance = 0'.
	
	self assert: expectedReport equals: (account accountSummary) .! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 12:33:17'!
test02
	
	| account expectedReport |
	
	account := ReceptiveAccount  new.
	Deposit register: 20 on: account.
	
	expectedReport _ OrderedCollection with: 'Deposito por 20.' with: 'Balance = 20'.
	
	self assert: expectedReport equals: (account accountSummary).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 12:33:22'!
test03
	
	| account expectedReport |
	
	account := ReceptiveAccount  new.
	Withdraw register: 20 on: account.
	
	expectedReport _ OrderedCollection with: 'Extraccion por 20.' with: 'Balance = -20'.
	
	self assert: expectedReport equals: (account accountSummary).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 12:35:31'!
test04
	
	| destinationAccount expectedDestinationAccountReport expectedSourceAccountReport sourceAccount |
	
	sourceAccount _ ReceptiveAccount  new.
	destinationAccount _ ReceptiveAccount  new.
	
	Transfer an: 20 from: sourceAccount to: destinationAccount.
	
	expectedSourceAccountReport _ OrderedCollection with: 'Salida por transferencia de 20.' with: 'Balance = -20'.
	expectedDestinationAccountReport _ OrderedCollection with: 'Entrada por transferencia de 20.' with: 'Balance = 20'.
	
	self assert: expectedSourceAccountReport equals: (sourceAccount accountSummary).
	self assert: expectedDestinationAccountReport equals: (destinationAccount accountSummary).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 12:55:01'!
test05

	| account expectedReport portfolio |
	
	account _ ReceptiveAccount  new.
	Deposit register: 20 on: account.
	portfolio _ Portfolio new.
	
	portfolio add: account.
	
	expectedReport _ OrderedCollection with: 'Deposito por 20.' with: 'Balance = 20'.
	
	self assert: expectedReport equals: portfolio accountSummary.
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 13:29:12'!
test055
	
	"| destinationAccount sourceAccount expectedDestinationAccountTransferNet expectedSourceAccountTransferNet |
	
	sourceAccount _ ReceptiveAccount  new.
	destinationAccount _ ReceptiveAccount  new.
	
	expectedSourceAccountTransferNet _ 0.
	expectedDestinationAccountTransferNet _ 0.
	
	self assert: expectedSourceAccountTransferNet equals: (sourceAccount transferNet).
	self assert: expectedDestinationAccountTransferNet equals: (destinationAccount transferNet)."
	
	self assert: true.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 13:11:50'!
test06

	| expectedReport portfolio portfolioToAdd |
	
	portfolioToAdd _ Portfolio new.
	portfolio _ Portfolio new.
	
	portfolio add: portfolioToAdd.
	
	expectedReport _ OrderedCollection  with: 'Balance = 0'.
	
	self assert: expectedReport equals: portfolio accountSummary.
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 13:15:13'!
test07

	| expectedReport portfolio portfolioToAdd account |
	
	account _ ReceptiveAccount new.
	Deposit register: 20 on: account.
	portfolioToAdd _ Portfolio new.
	portfolio _ Portfolio new.
	
	portfolioToAdd add: account.
	portfolio add: portfolioToAdd.
	
	expectedReport _ OrderedCollection  with: 'Deposito por 20.' with: 'Balance = 20'.
	
	self assert: expectedReport equals: portfolio accountSummary.
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 13:31:34'!
test08

	| expectedReport portfolio account1 account2 |
	
	account1 _ ReceptiveAccount new.
	Deposit register: 20 on: account1.
	account2 _ ReceptiveAccount new.
	Withdraw register: 30 on: account2.
	portfolio _ Portfolio new.
	
	portfolio add: account1.
	portfolio add: account2.
	
	expectedReport _ OrderedCollection  with: 'Deposito por 20.' with: 'Extraccion por 30.' with: 'Balance = -10'.
	
	self assert: expectedReport equals: portfolio accountSummary.
	
	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/23/2022 21:36:13'!
test01

	"creating a transfer affects source and destination balance	"
	
	| sourceAccount destinationAccount amount |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 20.
	
	Transfer an: amount from: sourceAccount to: destinationAccount.
	
	self assert: (sourceAccount balance) equals: (-1 * amount).
	self assert: (destinationAccount balance) equals: amount ! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:20:07'!
test02

	"a transfer should know both its transfer legs"
	
	| sourceAccount destinationAccount amount transfer |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 20.
	
	transfer _ Transfer an: amount from: sourceAccount to: destinationAccount.
	
	self assert: (sourceAccount hasRegistered: transfer sourcePata).
	self assert: (destinationAccount hasRegistered: transfer destinationPata)! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:22:40'!
test03

	| sourceAccount destinationAccount amount transfer |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 20.
	
	transfer _ Transfer an: amount from: sourceAccount to: destinationAccount.
	
	self assert: (transfer destinationPata otherPata) equals: transfer sourcePata.
	self assert: (transfer sourcePata otherPata) equals: transfer destinationPata.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:35:02'!
test04

	| sourceAccount destinationAccount amount transfer |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 20.
	
	transfer _ Transfer an: amount from: sourceAccount to: destinationAccount.
	
	self assert: (transfer destinationPata value) equals: transfer value.
	self assert: (transfer sourcePata value) equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:48:36'!
test05
	
	| sourceAccount destinationAccount amount |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 0.
	
	self should: [ Transfer an: amount from: sourceAccount to: destinationAccount. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Transfer emptyTransactionErrorDescription ]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 12:00:56'!
test06

	| sourceAccount amount |
	
	sourceAccount _ ReceptiveAccount new.
	amount _ 20.
	
	self should: [ Transfer an: amount from: sourceAccount to: sourceAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Transfer sourceAndDestinationCannotBeEqualErrorDescription ]
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'JDR 5/28/2022 13:28:43'!
accountSummary

	| accountSummaryReport |
	accountSummaryReport _ OrderedCollection new.
	
	self addToAccountSummary: accountSummaryReport .
	
	accountSummaryReport add: 'Balance = ', self balance asString.
	
	^accountSummaryReport ! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 13:32:27'!
addToAccountSummary: anAccountSummaryReportToBeCompleted 

	accounts do: [ :anAccount |
		anAccount addToAccountSummary: anAccountSummaryReportToBeCompleted.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 13:33:44'!
accountSummary
	
	| anAccountSummaryReport |
	anAccountSummaryReport _ OrderedCollection new.
	
	self addToAccountSummary: anAccountSummaryReport.
	
	anAccountSummaryReport add: 'Balance = ', (self balance asString). 
	
	^anAccountSummaryReport! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 13:18:42'!
addToAccountSummary: anAccountSummaryReportToBeCompleted 
	
	transactions do: [ :aTransaction | 
		(aTransaction isKindOf: Deposit) ifTrue: [ anAccountSummaryReportToBeCompleted add: 'Deposito por ', aTransaction value asString, '.' ] .
		(aTransaction isKindOf: Withdraw) ifTrue: [ anAccountSummaryReportToBeCompleted add: 'Extraccion por ', aTransaction value asString, '.' ] .
		(aTransaction isKindOf: SourcePata) ifTrue: [ anAccountSummaryReportToBeCompleted add: 'Salida por transferencia de ', aTransaction value asString, '.' ] .
		(aTransaction isKindOf: DestinationPata) ifTrue: [ anAccountSummaryReportToBeCompleted add: 'Entrada por transferencia de ', aTransaction value asString, '.' ] .
	].! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DestinationPata category: 'Portfolio-Solucion'!
AccountTransaction subclass: #DestinationPata
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DestinationPata methodsFor: 'initialization' stamp: 'JDR 5/26/2022 21:56:29'!
affectBalance: aSmallInteger 
	
	^aSmallInteger + (transfer value).! !

!DestinationPata methodsFor: 'initialization' stamp: 'JDR 5/26/2022 21:55:42'!
initializeRegisterFrom: aTransfer 
	
	transfer := aTransfer.! !


!DestinationPata methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:20:07'!
otherPata
	
	^transfer sourcePata 
! !

!DestinationPata methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:35:43'!
value
	
	^transfer value
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DestinationPata class' category: 'Portfolio-Solucion'!
DestinationPata class
	instanceVariableNames: ''!

!DestinationPata class methodsFor: 'instance creation' stamp: 'JDR 5/26/2022 21:55:34'!
registerFrom: aTransfer 

	^self new initializeRegisterFrom: aTransfer ! !


!classDefinition: #SourcePata category: 'Portfolio-Solucion'!
AccountTransaction subclass: #SourcePata
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SourcePata methodsFor: 'initialization' stamp: 'JDR 5/26/2022 21:54:35'!
initializeRegisterFrom: aTransfer 
	
	transfer := aTransfer.! !


!SourcePata methodsFor: 'as yet unclassified' stamp: 'JDR 5/26/2022 21:56:05'!
affectBalance: aSmallInteger 
	
	^aSmallInteger - (transfer value) ! !

!SourcePata methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:21:05'!
otherPata
	
	^transfer destinationPata ! !

!SourcePata methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:35:50'!
value
	
	^transfer value
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SourcePata class' category: 'Portfolio-Solucion'!
SourcePata class
	instanceVariableNames: ''!

!SourcePata class methodsFor: 'instance creation' stamp: 'JDR 5/26/2022 21:54:09'!
registerFrom: aTransfer 

	^self new initializeRegisterFrom: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value sourceAccount destinationAccount sourcePata depositPata'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'JDR 5/28/2022 11:54:09'!
initializeAn: aValue from: aSourceAccount to: aDestinationAccount 

	value := aValue.
	sourceAccount := aSourceAccount.
	destinationAccount := aDestinationAccount.
	
	sourcePata _ SourcePata registerFrom: self.
	depositPata _ DestinationPata  registerFrom: self.
	
	sourceAccount register: sourcePata.
	destinationAccount register: depositPata! !

!Transfer methodsFor: 'initialization' stamp: 'JDR 5/26/2022 21:57:04'!
value

	^value! !


!Transfer methodsFor: 'as yet unclassified' stamp: 'JDR 5/23/2022 21:26:41'!
affectBalance: aSmallInteger 
	self shouldBeImplemented.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:39:40'!
destinationPata
	
	^depositPata ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:39:34'!
sourcePata
	
	^ sourcePata.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'JDR 5/28/2022 12:00:47'!
an: aValue from: aSourceAccount to: aDestinationAccount 

	(aSourceAccount = aDestinationAccount) ifTrue: [ self error: Transfer sourceAndDestinationCannotBeEqualErrorDescription ].
	(aValue = 0) ifTrue: [ self error: Transfer emptyTransactionErrorDescription ].

	^ self new initializeAn: aValue from: aSourceAccount to: aDestinationAccount! !


!Transfer class methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:49:40'!
emptyTransactionErrorDescription

	^'A transfer must have a positive value!!!!'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'JDR 5/28/2022 11:59:59'!
sourceAndDestinationCannotBeEqualErrorDescription

	^'Source and destination accounts cannot be the same'! !