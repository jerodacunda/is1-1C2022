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

!ReportTest methodsFor: 'testing - account summary' stamp: 'JDR 5/28/2022 18:40:01'!
test01SummaryOfANewReceptiveAccountShouldPrintAccountBalance
	
	| account expectedReport accountSummary |
	
	account := ReceptiveAccount  new.
	accountSummary _ AccountSummary of: account.
	
	expectedReport _ OrderedCollection with: 'Balance = 0'.
	
	self assert: expectedReport equals: (accountSummary report) .! !

!ReportTest methodsFor: 'testing - account summary' stamp: 'JDR 5/28/2022 18:40:20'!
test02SummaryOfAReceptiveAccountWithADepositShouldPrintDepositAndAccountBalance
	
	| account expectedReport accountSummary |
	
	account := ReceptiveAccount  new.
	Deposit register: 20 on: account.
	accountSummary _ AccountSummary of: account.
	
	expectedReport _ OrderedCollection with: 'Deposito por 20.' with: 'Balance = 20'.
	
	self assert: expectedReport equals: (accountSummary report).! !

!ReportTest methodsFor: 'testing - account summary' stamp: 'JDR 5/28/2022 18:40:33'!
test03SummaryOfAReceptiveAccountWithAWithdrawShouldPrintWithdrawAndAccountBalance
	
	| account expectedReport accountSummary |
	
	account := ReceptiveAccount  new.
	Withdraw register: 20 on: account.
	accountSummary _ AccountSummary of: account.
	
	expectedReport _ OrderedCollection with: 'Extraccion por 20.' with: 'Balance = -20'.
	
	self assert: expectedReport equals: (accountSummary report).! !

!ReportTest methodsFor: 'testing - account summary' stamp: 'JDR 5/28/2022 18:22:05'!
test04ATransferShouldBePrintedInBothAccountsSummaries
	
	| destinationAccount expectedDestinationAccountReport expectedSourceAccountReport sourceAccount sourceAccountSummary destinationAccountSummary |
	
	sourceAccount _ ReceptiveAccount  new.
	destinationAccount _ ReceptiveAccount  new.
	sourceAccountSummary _ AccountSummary of: sourceAccount.
	destinationAccountSummary _ AccountSummary of: destinationAccount.
	
	Transfer register: 20 from: sourceAccount to: destinationAccount.
	
	expectedSourceAccountReport _ OrderedCollection with: 'Salida por transferencia de 20.' with: 'Balance = -20'.
	expectedDestinationAccountReport _ OrderedCollection with: 'Entrada por transferencia de 20.' with: 'Balance = 20'.
	
	self assert: expectedSourceAccountReport equals: (sourceAccountSummary report).
	self assert: expectedDestinationAccountReport equals: (destinationAccountSummary report).! !

!ReportTest methodsFor: 'testing - account summary' stamp: 'JDR 5/28/2022 18:56:12'!
test05SummaryOfAPortfolioWithAReceptiveAccountShouldBeAccountSummary

	| account expectedReport portfolio accountSummary |
	
	account _ ReceptiveAccount  new.
	Deposit register: 20 on: account.
	portfolio _ Portfolio with: account.
	accountSummary _ AccountSummary of: portfolio.
	
	expectedReport _ OrderedCollection with: 'Deposito por 20.' with: 'Balance = 20'.
	
	self assert: expectedReport equals: accountSummary report.
	
	! !

!ReportTest methodsFor: 'testing - account summary' stamp: 'JDR 5/28/2022 18:56:50'!
test06SummaryOfAPortfolioWithAnEmptyPortfolioShouldPrintInnerPortfolioBalance

	| expectedReport portfolio portfolioToAdd accountSummary |
	
	portfolioToAdd _ Portfolio new.
	portfolio _ Portfolio with: portfolioToAdd.
	accountSummary _ AccountSummary of: portfolio.
	
	expectedReport _ OrderedCollection  with: 'Balance = 0'.
	
	self assert: expectedReport equals: accountSummary report.
	
	! !

!ReportTest methodsFor: 'testing - account summary' stamp: 'JDR 5/28/2022 18:57:18'!
test07SummaryOfAPortfolioWithAPortfolioShouldBeInnerPortfolioSummary

	| expectedReport portfolio portfolioToAdd account accountSummary |
	
	account _ ReceptiveAccount new.
	Deposit register: 20 on: account.
	portfolioToAdd _ Portfolio with: account.
	portfolio _ Portfolio with: portfolioToAdd .
	accountSummary _ AccountSummary of: portfolio.	
	
	expectedReport _ OrderedCollection  with: 'Deposito por 20.' with: 'Balance = 20'.
	
	self assert: expectedReport equals: accountSummary report.
	
	! !

!ReportTest methodsFor: 'testing - account summary' stamp: 'JDR 5/28/2022 18:59:08'!
test08SummaryOfAPortfolioWithAccountsShouldIncludeItsAccountsSummaries

	| expectedReport portfolio account1 account2 accountSummary |
	
	account1 _ ReceptiveAccount new.
	Deposit register: 20 on: account1.
	account2 _ ReceptiveAccount new.
	Withdraw register: 30 on: account2.
	portfolio _ Portfolio with: account1 with: account2.
	
	accountSummary _ AccountSummary of: portfolio.
	
	expectedReport _ OrderedCollection  with: 'Deposito por 20.' with: 'Extraccion por 30.' with: 'Balance = -10'.
	
	self assert: expectedReport equals: accountSummary report.
	
	! !


!ReportTest methodsFor: 'testing - transfer net' stamp: 'JDR 5/28/2022 18:44:55'!
test09TransferNetOfANewReceptiveAccountShouldBeZero
	
	| destinationAccount sourceAccount sourceTransferNet destinationTransferNet |
	
	sourceAccount _ ReceptiveAccount  new.
	destinationAccount _ ReceptiveAccount  new.
	sourceTransferNet _ TransferNet of: sourceAccount.
	destinationTransferNet _ TransferNet of: destinationAccount.
	
	self assert: 0  equals: (sourceTransferNet report).
	self assert: 0 equals: (destinationTransferNet report).
	! !

!ReportTest methodsFor: 'testing - transfer net' stamp: 'JDR 5/28/2022 19:00:13'!
test10CreatingATransferAffectsBothAccountsTransferNets
	
	| destinationAccount sourceAccount expectedDestinationAccountTransferNet expectedSourceAccountTransferNet transfer1 transfer2 destinationTransferNet sourceTransferNet |
	
	sourceAccount _ ReceptiveAccount  new.
	destinationAccount _ ReceptiveAccount  new.
	transfer1 _ Transfer register: 500 from: sourceAccount to: destinationAccount.
	transfer2 _ Transfer register: 50 from: sourceAccount to: destinationAccount.
	
	sourceTransferNet _ TransferNet of: sourceAccount.
	destinationTransferNet _ TransferNet of: destinationAccount.	
	
	expectedSourceAccountTransferNet _ (transfer1 value + transfer2 value) * (-1).
 	expectedDestinationAccountTransferNet _ (transfer1 value + transfer2 value).
	
	self assert: expectedSourceAccountTransferNet  equals: (sourceTransferNet report).
	self assert: expectedDestinationAccountTransferNet equals: (destinationTransferNet report).
	! !

!ReportTest methodsFor: 'testing - transfer net' stamp: 'JDR 5/28/2022 18:59:50'!
test11TransferNetOfAPortfolioWithAReceptiveAccountShouldBeItsAccountTransferNet
	
	| portfolio destinationAccount sourceAccount transfer transferNet |	
	
	sourceAccount _ ReceptiveAccount  new.
	destinationAccount _ ReceptiveAccount  new.
	portfolio _ Portfolio with: destinationAccount .
	transferNet _ TransferNet of: portfolio.
	
	transfer _ Transfer register: 500 from: sourceAccount to: destinationAccount.
			
	self assert: transfer value equals: (transferNet report).
	! !

!ReportTest methodsFor: 'testing - transfer net' stamp: 'JDR 5/28/2022 19:01:33'!
test12TransferNetOfAPortfolioWithAccountsShouldBeTheSumOfItsAccountsTransferNets
	
	| portfolio destinationAccount sourceAccount1 transfer1 portfolioToAdd sourceAccount2 transfer2 transferNet |	
	
	sourceAccount1 _ ReceptiveAccount  new.
	sourceAccount2 _ ReceptiveAccount  new.
	destinationAccount _ ReceptiveAccount  new.
	portfolioToAdd _ Portfolio with: destinationAccount .
	portfolio _ Portfolio with: sourceAccount2 with: portfolioToAdd .
	
	transferNet _ TransferNet of: portfolio.
	
	transfer1 _ Transfer register: 500 from: sourceAccount1 to: destinationAccount.
	transfer2 _ Transfer register: 50 from: sourceAccount2 to: sourceAccount1.
	
	self assert: transfer1 value - transfer2 value equals: (transferNet report).
	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'testing' stamp: 'JDR 5/28/2022 17:44:52'!
test01ANewTransferAffectsBothAccountsBalance
	
	| sourceAccount destinationAccount amount |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 20.
	
	Transfer register: amount from: sourceAccount to: destinationAccount.
	
	self assert: (sourceAccount balance) equals: (-1 * amount).
	self assert: (destinationAccount balance) equals: amount ! !

!TransferTest methodsFor: 'testing' stamp: 'JDR 5/28/2022 17:44:52'!
test02ANewTransferShouldRegisterSourceAndDestinationAccountsAsTransferPatas
	
	| sourceAccount destinationAccount amount transfer |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 20.
	
	transfer _ Transfer register: amount from: sourceAccount to: destinationAccount.
	
	self assert: (sourceAccount hasRegistered: transfer sourcePata).
	self assert: (destinationAccount hasRegistered: transfer destinationPata)! !

!TransferTest methodsFor: 'testing' stamp: 'JDR 5/28/2022 17:44:52'!
test03BothPatasAreReachableFromEachOther

	| sourceAccount destinationAccount amount transfer |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 20.
	
	transfer _ Transfer register: amount from: sourceAccount to: destinationAccount.
	
	self assert: (transfer destinationPata otherPata) equals: transfer sourcePata.
	self assert: (transfer sourcePata otherPata) equals: transfer destinationPata.! !

!TransferTest methodsFor: 'testing' stamp: 'JDR 5/28/2022 17:44:52'!
test04ValueOfBothPatasShouldBeTransferValue

	| sourceAccount destinationAccount amount transfer |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	amount _ 20.
	
	transfer _ Transfer register: amount from: sourceAccount to: destinationAccount.
	
	self assert: (transfer destinationPata value) equals: transfer value.
	self assert: (transfer sourcePata value) equals: transfer value.! !

!TransferTest methodsFor: 'testing' stamp: 'JDR 5/28/2022 17:46:18'!
test05CreatingATransferWithZeroValueShouldRaiseAnError
	
	| sourceAccount destinationAccount |
	
	sourceAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.
	
	self should: [ Transfer register: 0 from: sourceAccount to: destinationAccount. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException | self assert: anException messageText equals: Transfer emptyTransferErrorDescription ]! !

!TransferTest methodsFor: 'testing' stamp: 'JDR 5/28/2022 17:44:52'!
test06CreatingATransferFromSourceAccountToItselfShouldRaiseAnError

	| sourceAccount amount |
	
	sourceAccount _ ReceptiveAccount new.
	amount _ 20.
	
	self should: [ Transfer register: amount from: sourceAccount to: sourceAccount ]
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


!Account methodsFor: 'reporting' stamp: 'AF 5/28/2022 16:44:19'!
addToReport: aReportToBeCompleted 
	self subclassResponsibility.! !


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


!Portfolio methodsFor: 'reporting' stamp: 'AF 5/28/2022 16:33:54'!
addToReport: aReportToBeCompleted 

	accounts do: [ :anAccount | anAccount addToReport: aReportToBeCompleted	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
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


!ReceptiveAccount methodsFor: 'reporting' stamp: 'AF 5/28/2022 16:46:27'!
addToReport: aReportToBeCompleted 
	
	transactions do: [ :aTransaction | aTransaction includeIn: aReportToBeCompleted.	].! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'accessing' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting' stamp: 'AF 5/28/2022 16:46:27'!
includeIn: anAccountSummaryReportToBeCompleted

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


!Deposit methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reporting' stamp: 'AF 5/28/2022 16:47:52'!
includeIn: aReportToBeCompleted
	aReportToBeCompleted registerDeposit: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDestinationPata category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferDestinationPata
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDestinationPata methodsFor: 'balance' stamp: 'JDR 5/26/2022 21:56:29'!
affectBalance: aSmallInteger 
	
	^aSmallInteger + (transfer value).! !


!TransferDestinationPata methodsFor: 'initialization' stamp: 'JDR 5/26/2022 21:55:42'!
initializeRegisterFrom: aTransfer 
	
	transfer := aTransfer.! !


!TransferDestinationPata methodsFor: 'accessing' stamp: 'JDR 5/28/2022 11:20:07'!
otherPata
	
	^transfer sourcePata 
! !

!TransferDestinationPata methodsFor: 'accessing' stamp: 'JDR 5/28/2022 11:35:43'!
value
	
	^transfer value
! !


!TransferDestinationPata methodsFor: 'reporting' stamp: 'JDR 5/28/2022 17:31:30'!
includeIn: anAccountSummaryReportToBeCompleted

	anAccountSummaryReportToBeCompleted registerDestinationPata: self. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDestinationPata class' category: 'Portfolio-Solucion'!
TransferDestinationPata class
	instanceVariableNames: ''!

!TransferDestinationPata class methodsFor: 'instance creation' stamp: 'JDR 5/26/2022 21:55:34'!
registerFrom: aTransfer 

	^self new initializeRegisterFrom: aTransfer ! !


!classDefinition: #TransferSourcePata category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferSourcePata
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferSourcePata methodsFor: 'initialization' stamp: 'JDR 5/26/2022 21:54:35'!
initializeRegisterFrom: aTransfer 
	
	transfer := aTransfer.! !


!TransferSourcePata methodsFor: 'accessing' stamp: 'JDR 5/28/2022 11:21:05'!
otherPata
	
	^transfer destinationPata ! !

!TransferSourcePata methodsFor: 'accessing' stamp: 'JDR 5/28/2022 11:35:50'!
value
	
	^transfer value
! !


!TransferSourcePata methodsFor: 'balance' stamp: 'JDR 5/26/2022 21:56:05'!
affectBalance: aSmallInteger 
	
	^aSmallInteger - (transfer value) ! !


!TransferSourcePata methodsFor: 'reporting' stamp: 'AF 5/28/2022 16:48:47'!
includeIn: aReportToBeCompleted
	aReportToBeCompleted registerSourcePata: self. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSourcePata class' category: 'Portfolio-Solucion'!
TransferSourcePata class
	instanceVariableNames: ''!

!TransferSourcePata class methodsFor: 'instance creation' stamp: 'JDR 5/26/2022 21:54:09'!
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


!Withdraw methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reporting' stamp: 'AF 5/28/2022 16:49:05'!
includeIn: aReportToBeCompleted
	aReportToBeCompleted registerWithdraw: self. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'reporting protocol' stamp: 'AF 5/28/2022 16:47:52'!
registerDeposit: aDeposit 
	self subclassResponsibility.! !

!Report methodsFor: 'reporting protocol' stamp: 'AF 5/28/2022 16:48:18'!
registerDestinationPata: aDestinationPata 
	
	self subclassResponsibility .! !

!Report methodsFor: 'reporting protocol' stamp: 'AF 5/28/2022 16:48:47'!
registerSourcePata: aSourcePata 
	
	self subclassResponsibility .! !

!Report methodsFor: 'reporting protocol' stamp: 'AF 5/28/2022 16:49:05'!
registerWithdraw: aWithdraw 
	
	self subclassResponsibility .! !


!Report methodsFor: 'accesing' stamp: 'AF 5/28/2022 16:42:25'!
report
	
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'AF 5/28/2022 16:43:02'!
of: anAccount 
	
	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'accountSummaryReport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'JDR 5/28/2022 17:53:16'!
initializeOf: anAccount 
	
	account := anAccount.
	accountSummaryReport _ OrderedCollection new.! !


!AccountSummary methodsFor: 'reporting protocol' stamp: 'JDR 5/28/2022 17:42:42'!
registerDeposit: aDeposit 

	accountSummaryReport add: 'Deposito por ', aDeposit value asString, '.' ! !

!AccountSummary methodsFor: 'reporting protocol' stamp: 'JDR 5/28/2022 17:42:42'!
registerDestinationPata: aDestinationPata 

	accountSummaryReport add: 'Entrada por transferencia de ', aDestinationPata value asString, '.' ! !

!AccountSummary methodsFor: 'reporting protocol' stamp: 'JDR 5/28/2022 17:42:42'!
registerSourcePata: aSourcePata 

	accountSummaryReport add: 'Salida por transferencia de ', aSourcePata value asString, '.'! !

!AccountSummary methodsFor: 'reporting protocol' stamp: 'JDR 5/28/2022 17:42:42'!
registerWithdraw: aWithdraw 

	accountSummaryReport add: 'Extraccion por ', aWithdraw value asString, '.'.! !


!AccountSummary methodsFor: 'accesing' stamp: 'JDR 5/28/2022 17:42:42'!
report
	
	
	accountSummaryReport _ OrderedCollection new.
	
	account addToReport: self.
	
	accountSummaryReport add: 'Balance = ', (account balance asString). 
	
	^accountSummaryReport! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'AF 5/28/2022 15:53:58'!
of: anAccount 
	
	^self new initializeOf: anAccount ! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNetReport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'JDR 5/28/2022 17:52:51'!
initializeOf: anAccount 
	
	account := anAccount.
	transferNetReport _ 0.! !


!TransferNet methodsFor: 'reporting protocol' stamp: 'AF 5/28/2022 16:47:52'!
registerDeposit: aDeposit 
! !

!TransferNet methodsFor: 'reporting protocol' stamp: 'AF 5/28/2022 16:48:18'!
registerDestinationPata: aDestinationPata 
	
	transferNetReport _ (aDestinationPata value) + transferNetReport! !

!TransferNet methodsFor: 'reporting protocol' stamp: 'AF 5/28/2022 16:48:47'!
registerSourcePata: aSourcePata 

	transferNetReport _ (aSourcePata value)* (-1) + transferNetReport ! !

!TransferNet methodsFor: 'reporting protocol' stamp: 'AF 5/28/2022 16:49:05'!
registerWithdraw: aWithdraw 
! !


!TransferNet methodsFor: 'accesing' stamp: 'AF 5/28/2022 16:35:19'!
report
	
	transferNetReport _ 0.
	
	account addToReport: self.
	
	^transferNetReport ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'AF 5/28/2022 15:26:43'!
of: anAccount 
	
	^self new initializeOf: anAccount ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value sourceAccount destinationAccount sourcePata destinationPata'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'JDR 5/28/2022 19:11:44'!
initializeAn: aValue from: aSourceAccount to: aDestinationAccount 

	value := aValue.
	sourceAccount := aSourceAccount.
	destinationAccount := aDestinationAccount.
	
	sourcePata _ TransferSourcePata registerFrom: self.
	destinationPata _ TransferDestinationPata  registerFrom: self.
	
	sourceAccount register: sourcePata.
	destinationAccount register: destinationPata! !


!Transfer methodsFor: 'accessing' stamp: 'AF 5/28/2022 15:39:46'!
destinationPata
	
	^destinationPata ! !

!Transfer methodsFor: 'accessing' stamp: 'JDR 5/28/2022 11:39:34'!
sourcePata
	
	^ sourcePata.! !

!Transfer methodsFor: 'accessing' stamp: 'JDR 5/26/2022 21:57:04'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'JDR 5/28/2022 17:46:18'!
register: aValue from: aSourceAccount to: aDestinationAccount 

	(aSourceAccount = aDestinationAccount) ifTrue: [ self error: Transfer sourceAndDestinationCannotBeEqualErrorDescription ].
	(aValue = 0) ifTrue: [ self error: Transfer emptyTransferErrorDescription ].

	^ self new initializeAn: aValue from: aSourceAccount to: aDestinationAccount! !


!Transfer class methodsFor: 'error descriptions' stamp: 'JDR 5/28/2022 17:46:18'!
emptyTransferErrorDescription

	^'A transfer must have a positive value!!!!'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'JDR 5/28/2022 11:59:59'!
sourceAndDestinationCannotBeEqualErrorDescription

	^'Source and destination accounts cannot be the same'! !
