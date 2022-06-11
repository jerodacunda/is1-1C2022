!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test - accesing' stamp: 'JDR 6/8/2022 13:50:44'!
test01ANewCartShouldBeEmpty

	| cart testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	
	self assert: cart isEmpty! !

!CartTest methodsFor: 'test - accesing' stamp: 'JDR 6/8/2022 13:51:37'!
test06CanConsultCartContents

	| cart book expectedCartContent testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils book.
	
	cart add: book amount: 1.
	expectedCartContent _ Bag with: book.
	
	self assert: expectedCartContent equals: cart content
	
	
	
					
	

	

	! !

!CartTest methodsFor: 'test - accesing' stamp: 'JDR 6/8/2022 13:51:47'!
test08CanConsultCartTotalPrice
	
	| cart bookPrice testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	cart add: testingUtils book amount: 3.
	
	bookPrice _ testingUtils catalog at: testingUtils book.
	
	self assert: 3 * bookPrice equals: cart subtotal.

	! !


!CartTest methodsFor: 'test - adding' stamp: 'JDR 6/8/2022 13:50:57'!
test02ACartShouldNotBeEmptyAfterAddingBookToCart

	| cart book testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils book.
	
	cart add: book amount: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'test - adding' stamp: 'JDR 6/8/2022 13:51:05'!
test03CanAddToCartAnAmountOfACertainBook

	| cart book amount testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils book.
	amount _ 3.
	
	cart add: book amount: amount.
	
	self assert: amount equals: (cart occurrencesOf: book)
	
	
	
					
	

	

	! !


!CartTest methodsFor: 'test - exceptions' stamp: 'JDR 6/8/2022 13:51:12'!
test04OnlyCanAddToCartBooksInCatalog

	| cart testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	
	self 
		should: [ cart add: testingUtils unregisteredBook amount: 1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart cannotAddBooksNotInCatalogErrorDescription.
			self assert: cart isEmpty.
		]
	

	! !

!CartTest methodsFor: 'test - exceptions' stamp: 'JDR 6/8/2022 13:51:20'!
test05OnlyCanAddToCartAPositiveAmountOfABook

	| cart book invalidAmount testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils book.			
	invalidAmount _ 0.
	
	self 
		should: [ cart add: book amount: invalidAmount ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidBookAmountErrorDescription .
			self assert: cart isEmpty.
		]
	

	! !

!CartTest methodsFor: 'test - exceptions' stamp: 'JDR 6/8/2022 13:51:42'!
test07OnlyCanAddToCartAnIntegerAmountOfABook

	| cart book invalidAmount testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils book.			
	invalidAmount _ 1.1.
	
	self 
		should: [ cart add: book amount: invalidAmount ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidBookAmountErrorDescription .
			self assert: cart isEmpty.
		]
	

	! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:52:16'!
test01CheckoutOfAnEmptyCartShouldRaiseAnError

	| cart cashier testingUtils salesBook merchantProcessor |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	merchantProcessor _ CatchOutMerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	self should: [cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cashier cannotCheckoutEmptyCartErrorDescription equals: anError messageText.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:52:25'!
test02CheckoutOfACartWithOneBookShouldMatchBookPrice
	
	| cart cashier testingUtils salesBook purchase merchantProcessor |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	
	cart add: testingUtils book amount: 1.
	purchase _ cart content.
		
	self assert: 100 equals: (cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear ).	
	self assert: cart isEmpty.
	self assert: (salesBook hasRegistered: purchase).! !

!CashierTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:52:30'!
test03CheckoutOfACartEqualsCartSubtotal
	
	| cart cashier expectedPrice testingUtils salesBook purchase merchantProcessor |
	
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart add: testingUtils book amount: 3.
	cart add: testingUtils book2 amount: 1.
	purchase _ cart content.
		
	expectedPrice _ 350.
	
	self assert: expectedPrice equals: (cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear).
	self assert: cart isEmpty.
	self assert: (salesBook hasRegistered: purchase).! !

!CashierTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:52:35'!
test04CheckoutWithAnExpiredCardShouldRaiseAnError
	
	| cart cashier testingUtils salesBook purchase merchantProcessor |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	merchantProcessor _ CatchOutMerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart add: testingUtils book amount: 1.
	purchase _ cart content.

	self should: [ cashier checkout: cart with: testingUtils expiredCreditCard on: testingUtils validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cashier expiredCardErrorDescription equals: anError messageText .
			self deny: cart isEmpty.
			self deny: (salesBook hasRegistered: purchase).
		]! !

!CashierTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:52:40'!
test05CheckoutWithAStolenCardShouldRaiseAnError
	
	| cart cashier testingUtils salesBook purchase merchantProcessor |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart add: testingUtils book amount: 1.
	purchase _ cart content.

	self should: [ cashier checkout: cart with: testingUtils stolenCreditCard on: testingUtils validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: MerchantProcessorSimulator stolenCreditCardErrorDescription equals: anError messageText .
			self deny: cart isEmpty.
			self deny: (salesBook hasRegistered: purchase).
		]! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:52:46'!
test01CreditCardNumberMustBeLength16	
	
	| testingUtils |
	testingUtils _ TestingUtils new.
	
	self should: [CreditCard ownedBy: testingUtils validCardName with: testingUtils invalidCardNumber expiratingOn: testingUtils validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CreditCard invalidCardNumberErrorDescription equals: anError messageText ]. ! !

!CreditCardTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:52:51'!
test02CreditCardNameMustBeAValidName
	
	| testingUtils |
	testingUtils _ TestingUtils new.
	
	self should: [CreditCard ownedBy: testingUtils invalidCardName with: testingUtils validCardNumber expiratingOn: testingUtils validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CreditCard invalidNameErrorDescription equals: anError messageText ]. ! !

!CreditCardTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:53:00'!
test03CreditCardDateMustBeAMonthOfYear
	
	| testingUtils |
	testingUtils _ TestingUtils new.
	
	self should: [CreditCard ownedBy: testingUtils validCardName with: testingUtils validCardNumber expiratingOn: testingUtils invalidExpirationDate] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CreditCard invalidExpirationDateErrorDescription equals: anError messageText ]. ! !


!classDefinition: #MerchantProcessorSimulatorTest category: 'TusLibros'!
TestCase subclass: #MerchantProcessorSimulatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulatorTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:53:04'!
test01DebitFromAnythingButACreditCardShouldRaiseAnError

	| merchantProcessor amount notACreditCard testingUtils |
	testingUtils _ TestingUtils new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	amount _ 100.
	notACreditCard _ 'this is not a credit card'.
	
	self should: [merchantProcessor debit: amount from: notACreditCard on: testingUtils validCheckoutMonthOfYear ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: MerchantProcessorSimulator onlyCanDebitFromACreditCardErrorDescription equals: anError messageText .]
	
	! !

!MerchantProcessorSimulatorTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:53:09'!
test02DebitFromAnExpiredCreditCardShouldRaiseAnError

	| merchantProcessor amount testingUtils |
	testingUtils _ TestingUtils new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	amount _ 100.
	
	self should: [ merchantProcessor debit: amount from: testingUtils expiredCreditCard on: testingUtils validCheckoutMonthOfYear ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: MerchantProcessorSimulator expiredCreditCardErrorDescription equals: anError messageText .]
	
	! !

!MerchantProcessorSimulatorTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:53:13'!
test03DebitFromAStolenCreditCardShouldRaiseAnError

	| merchantProcessor amount testingUtils |
	testingUtils _ TestingUtils new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	amount _ 100.
	
	self should: [ merchantProcessor debit: amount from: testingUtils stolenCreditCard on: testingUtils validCheckoutMonthOfYear ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: MerchantProcessorSimulator stolenCreditCardErrorDescription equals: anError messageText .]
	
	! !

!MerchantProcessorSimulatorTest methodsFor: 'testing' stamp: 'JDR 6/9/2022 19:53:27'!
test04DebitFromAFundlessCreditCardShouldRaiseAnError

	"| merchantProcessor amount testingUtils |
	testingUtils _ TestingUtils new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.
	amount _ 100.
	
	self should: [ merchantProcessor debit: amount from: testingUtils fundlessCreditCard on: testingUtils validCheckoutMonthOfYear ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: MerchantProcessorSimulator fundlessCreditCardErrorDescription equals: anError messageText .]"
	
	! !


!classDefinition: #SalesBookTest category: 'TusLibros'!
TestCase subclass: #SalesBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBookTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:36:12'!
test01ANewSalesBookShouldBeEmpty

	| salesBook |
	salesBook _ SalesBook new.

	self assert: salesBook isEmpty.! !

!SalesBookTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:53:18'!
test02CheckoutOfACartWithACashierShouldRegisterPurchaseOnSalesBook

	| salesBook cart cashier testingUtils purchase merchantProcessor |
	testingUtils _ TestingUtils new.	
	cart _ Cart with: testingUtils catalog.
	cart add: testingUtils book amount: 1.
	purchase _ cart content.
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear.
	
	self assert: (salesBook hasRegistered: purchase).
	self deny: salesBook isEmpty .
	! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF\ 6/11/2022 14:49:26'!
test06
	
	| cart cashier testingUtils salesBook purchase merchantProcessor expectedPurchases |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	
	cart add: testingUtils book amount: 1.
	purchase _ Sale with: cart content for: testingUtils clientID1.
	expectedPurchases _ OrderedCollection  with: purchase.
		
	self assert: 100 equals: (cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1).	
	self assert: cart isEmpty.
	self assert: (salesBook hasRegistered: purchase).
	self assert: expectedPurchases equals: (salesBook purchasesOf: testingUtils clientID1) ! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF\ 6/11/2022 14:49:44'!
test07
	
	| cashier testingUtils salesBook merchantProcessor cart1 cart2 purchaseForClient1 purchaseForClient2 purchasesOfClient1 purchasesOfClient2 |
	testingUtils _ TestingUtils new.
	
	cart1 _ Cart with: testingUtils catalog.
	cart2 _ Cart with: testingUtils catalog	.
	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	
	cart1 add: testingUtils book amount: 1.
	purchaseForClient1 _ Sale with: cart1 content for: testingUtils clientID1.
	purchasesOfClient1 _ OrderedCollection  with: purchaseForClient1.
	
	
	cart2 add: testingUtils book2 amount: 1.
	purchaseForClient2 _ Sale with: cart2 content for: testingUtils clientID2.
	purchasesOfClient2 _ OrderedCollection  with: purchaseForClient2.
	
	self assert: 100 equals: (cashier checkout: cart1 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1).	
	self assert: cart1 isEmpty.
	self assert: (salesBook hasRegistered: purchaseForClient1).
	self assert: purchasesOfClient1 equals: (salesBook purchasesOf: testingUtils clientID1).
	
	self assert: 50 equals: (cashier checkout: cart2 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID2).	
	self assert: cart2 isEmpty.
	self assert: (salesBook hasRegistered: purchaseForClient2).
	self assert: purchasesOfClient2 equals: (salesBook purchasesOf: testingUtils clientID2) ! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF\ 6/11/2022 17:37:38'!
test08
	
	| cashier testingUtils salesBook merchantProcessor cart1 cart2 expectedFirstPurchaseContents expectedSecondPurchaseContents purchasesOfClient |
	testingUtils _ TestingUtils new.
	
	cart1 _ Cart with: testingUtils catalog.
	cart2 _ Cart with: testingUtils catalog	.
	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	
	cart1 add: testingUtils book amount: 1.
	expectedFirstPurchaseContents _ Bag with: testingUtils book.
		
	cart2 add: testingUtils book2 amount: 1.
	expectedSecondPurchaseContents _ Bag with: testingUtils book2.

		
	self assert: 100 equals: (cashier checkout: cart1 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1).	
	self assert: cart1 isEmpty.

	self assert: 50 equals: (cashier checkout: cart2 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1).	
	self assert: cart2 isEmpty.
	
	purchasesOfClient _ salesBook purchasesOf: testingUtils clientID1.
	
	self assert: testingUtils clientID1 equals: purchasesOfClient first clientID.
	self assert: expectedFirstPurchaseContents equals:  purchasesOfClient first cartContentsSAFASFDFS.
	
	self assert: testingUtils clientID1 equals: purchasesOfClient second clientID.
	self assert: expectedSecondPurchaseContents equals:  purchasesOfClient second cartContentsSAFASFDFS.
	

	self deny: purchasesOfClient first saleID = purchasesOfClient second saleID! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF\ 6/11/2022 14:55:36'!
test09
	
	| cashier testingUtils salesBook merchantProcessor cart1 cart2 purchasesOfClient |
	testingUtils _ TestingUtils new.
	
	cart1 _ Cart with: testingUtils catalog.
	cart2 _ Cart with: testingUtils catalog	.
	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	
	cart1 add: testingUtils book amount: 1.
	cart2 add: testingUtils book2 amount: 1.
		
	self assert: 100 equals: (cashier checkout: cart1 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1).	
	self assert: cart1 isEmpty.
	
	self assert: 50 equals: (cashier checkout: cart2 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1).	
	self assert: cart2 isEmpty.
	
	purchasesOfClient _ salesBook purchasesOf: testingUtils clientID1.
	self deny: purchasesOfClient first saleID = purchasesOfClient second saleID.! !


!classDefinition: #SystemFacadeTest category: 'TusLibros'!
TestCase subclass: #SystemFacadeTest
	instanceVariableNames: 'testingUtils catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'AF\ 6/11/2022 12:28:53'!
setUp

	testingUtils _ TestingUtils new.
	catalog _ testingUtils catalog.! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'AF\ 6/11/2022 17:03:27'!
test01CreatingACartWithAnUnregisteredUsernameShouldRaiseAnError

	| systemFacade systemAuthenticator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.

	self should: [ systemFacade createCartForUser: testingUtils invalidClientID withPassword: testingUtils invalidPassword . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemAuthenticator invalidCredentialsErrorDescription equals: anError messageText ]
	
	 ! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'AF\ 6/11/2022 17:05:53'!
test02CreatingACartWithARegisteredUsernameAndAWrongPassworrdShouldRiseError

	| systemFacade systemAuthenticator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.

	self should: [ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils invalidPassword . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemAuthenticator invalidCredentialsErrorDescription equals: anError messageText ]
	
	 ! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'AF\ 6/11/2022 17:06:45'!
test03NewCartShouldBeEmpy

	| systemFacade cartID systemAuthenticator |

	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	
	self assert: (systemFacade listCart: cartID) isEmpty.! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'AF\ 6/11/2022 17:08:38'!
test04TwoCreatedCartsShouldHaveDifferentsIDs

	| systemFacade systemAuthenticator cartID1 cartID2 |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	cartID2 _ systemFacade createCartForUser: testingUtils clientID2 withPassword: testingUtils password2. 
		
	self assert: (cartID1 = cartID2) not! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'AF\ 6/11/2022 17:09:15'!
test08CantListCartOfAnInvalidCartID

	| systemFacade systemAuthenticator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.
	
	systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
		
	self should: [systemFacade listCart: testingUtils invalidCartID ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cantListAnInvalidCartIdErrorDescription equals: anError messageText ].
! !


!SystemFacadeTest methodsFor: 'testing' stamp: 'AF\ 6/11/2022 17:20:27'!
test10CheckoutOfAnEmotyCartShouldRiseError

	| systemFacade systemAuthenticator cartID1 merchantProcessor salesBook |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	
	self should: [systemFacade checkout: cartID1 with: (testingUtils validCreditCard) on: testingUtils validCheckoutMonthOfYear ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | self assert: SystemFacade cantCheckoutAnEmptyCartErrorDescription  equals: anError messageText] .
	! !

!SystemFacadeTest methodsFor: 'testing' stamp: 'AF\ 6/11/2022 17:20:58'!
test11CheckoutOfAnInvalidCartIDShouldRaiseError

	| systemFacade systemAuthenticator merchantProcessor salesBook |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor.

	
	self should: [systemFacade checkout: testingUtils invalidCartID with: (testingUtils validCreditCard) on: testingUtils validCheckoutMonthOfYear ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | self assert: SystemFacade cantCheckoutWithAnInvalidCartIDErrorDescription  equals: anError messageText] .
	! !

!SystemFacadeTest methodsFor: 'testing' stamp: 'AF\ 6/11/2022 17:22:24'!
test12ListingPurchasesOfClientMustHaveChackedoutCartsSADFDFERGTEGRDFSGDFSG

	| systemFacade systemAuthenticator merchantProcessor salesBook cartID expectedPurchases |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	systemFacade add: testingUtils book amount: 1 to: cartID.
	
	systemFacade checkout: cartID with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear.
	
	expectedPurchases _  OrderedCollection with: (Bag with: testingUtils book).
	 
	self assert: expectedPurchases equals: (systemFacade listPurchasesFor: testingUtils clientID1 withPassword: testingUtils password1).
	! !

!SystemFacadeTest methodsFor: 'testing' stamp: 'AF\ 6/11/2022 13:44:23'!
test13

	| systemFacade systemAuthenticator merchantProcessor salesBook cartID cartID2 expectedPurchases1 expectedPurchases2 |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	systemFacade add: testingUtils book amount: 1 to: cartID.
	systemFacade checkout: cartID with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear.
	
	cartID2 _ systemFacade createCartForUser: testingUtils clientID2 withPassword: testingUtils password2.
	systemFacade add: testingUtils book2 amount: 1 to: cartID2.
	systemFacade checkout: cartID2 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear.
	
	expectedPurchases1 _ OrderedCollection with: (Bag with: testingUtils book).
	expectedPurchases2 _ OrderedCollection with: (Bag with: testingUtils book2).
	 
	self assert: expectedPurchases1 equals: (systemFacade listPurchasesFor: testingUtils clientID1 withPassword: testingUtils password1).
	self assert: expectedPurchases2 equals: (systemFacade listPurchasesFor: testingUtils clientID2 withPassword: testingUtils password2).
	! !


!SystemFacadeTest methodsFor: 'testing - add' stamp: 'AF\ 6/11/2022 17:12:52'!
test05ListCartShouldNotBeEmptyAfterAddingAProduct

	| systemFacade systemAuthenticator cartID1 |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	systemFacade add: testingUtils book amount: 1 to: cartID1.
		
	self deny: (systemFacade listCart: cartID1) isEmpty.! !

!SystemFacadeTest methodsFor: 'testing - add' stamp: 'AF\ 6/11/2022 17:17:50'!
test06ListingTwoDifferentCartsMustHaveAddedProductsRespectively

	| systemFacade systemAuthenticator cartID1 cartID2 expectedCartContentsForCart1 expectedCartContentsForCart2 |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	cartID2 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	
	systemFacade add: testingUtils book amount: 1 to: cartID1.
	systemFacade add: testingUtils book2 amount: 1 to: cartID2.
	
	expectedCartContentsForCart1 _ Bag with: testingUtils book.
	expectedCartContentsForCart2 _ Bag with: testingUtils book2.
		
	self assert: expectedCartContentsForCart1 equals: (systemFacade listCart: cartID1).
	self assert: expectedCartContentsForCart2 equals: (systemFacade listCart: cartID2).! !

!SystemFacadeTest methodsFor: 'testing - add' stamp: 'AF\ 6/11/2022 17:19:19'!
test07AddingProductsWithAnInvalidCartIDShouldRaiseError

	| systemFacade systemAuthenticator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.
	
	systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
		
	self should: [systemFacade add: testingUtils book amount: 1 to: testingUtils invalidCartID]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cantAddToAnInvalidCartIdErrorDescription equals: anError messageText ].
! !

!SystemFacadeTest methodsFor: 'testing - add' stamp: 'AF\ 6/11/2022 17:19:52'!
test09AddingAProductNotInCatalogShouldRaiseError

	| systemFacade systemAuthenticator cartID |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
		
	self should: [systemFacade add: testingUtils unregisteredBook amount: 1 to: cartID]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cannotAddBooksNotInCatalogErrorDescription equals: anError messageText ].
! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'JDR 6/3/2022 03:37:46'!
content
	
	^content copy! !

!Cart methodsFor: 'accessing' stamp: 'JDR 6/2/2022 20:54:21'!
isEmpty
	
	^content isEmpty! !

!Cart methodsFor: 'accessing' stamp: 'AF 6/4/2022 11:19:41'!
occurrencesOf: aBook

	^ content occurrencesOf: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'JDR 6/6/2022 19:30:55'!
subtotal
	
	^content sum: [ :aBook | (catalog at: aBook)].
! !


!Cart methodsFor: 'adding' stamp: 'JDR 6/6/2022 17:38:28'!
add: aBook amount: anAmount 
	
	self assertValidAmount: anAmount.
	self assertBookIncludedInCatalog: aBook.
	content add: aBook withOccurrences: anAmount! !


!Cart methodsFor: 'initialization' stamp: 'AF 6/4/2022 11:23:58'!
initializeWith: aCatalog 
	
	catalog := aCatalog.
	content _ Bag new.! !


!Cart methodsFor: 'assertions' stamp: 'JDR 6/6/2022 19:18:00'!
assertBookIncludedInCatalog: aBook

	^ (catalog includesKey: aBook) ifFalse: [ self error: Cart cannotAddBooksNotInCatalogErrorDescription ]! !

!Cart methodsFor: 'assertions' stamp: 'JDR 6/6/2022 17:39:26'!
assertValidAmount: anAmount
	
	anAmount isInteger ifFalse: [ self error: Cart invalidBookAmountErrorDescription ].
	anAmount strictlyPositive ifFalse: [ self error: Cart invalidBookAmountErrorDescription ]! !


!Cart methodsFor: 'removing' stamp: 'JDR 6/6/2022 19:23:56'!
clearContent

	content _ Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error descriptions' stamp: 'JDR 6/3/2022 03:53:56'!
cannotAddBooksNotInCatalogErrorDescription

	^'Book is not edited by TusLibros.com'! !

!Cart class methodsFor: 'error descriptions' stamp: 'JDR 6/3/2022 03:57:03'!
invalidBookAmountErrorDescription

	^'Amount must be 1 or greater'! !


!Cart class methodsFor: 'instance creation' stamp: 'AF 6/4/2022 11:23:08'!
with: aCatalog 

	^self new initializeWith: aCatalog! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook merchantProcessorSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checking out' stamp: 'JDR 6/8/2022 13:09:31'!
checkout: aCart with: aCreditCard on: aDate
	
	| subtotal |
	
	(aCart isEmpty) ifTrue:[self error: Cashier cannotCheckoutEmptyCartErrorDescription].
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: Cashier expiredCardErrorDescription]. 
	
	subtotal _ aCart subtotal.
	
	merchantProcessorSimulator debit: subtotal from: aCreditCard on: aDate.
	
	salesBook add: aCart content.	
	
	aCart clearContent.
	
	^subtotal! !

!Cashier methodsFor: 'checking out' stamp: 'AF\ 6/11/2022 15:03:51'!
checkout: aCart with: aCreditCard on: aDate for: aClientID 
	
	| subtotal |
	
	(aCart isEmpty) ifTrue:[self error: Cashier cannotCheckoutEmptyCartErrorDescription].
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: Cashier expiredCardErrorDescription]. 
	
	subtotal _ aCart subtotal.
	
	merchantProcessorSimulator debit: subtotal from: aCreditCard on: aDate.
	
	salesBook addSaleOf: aCart for: aClientID. 
	
	aCart clearContent.
	
	^subtotal! !


!Cashier methodsFor: 'initialization' stamp: 'JDR 6/8/2022 13:06:38'!
initializeRegisteringSalesOn: aSalesBook debitingFrom: aMerchantProcessorSimulator 
	
	salesBook := aSalesBook.
	merchantProcessorSimulator := aMerchantProcessorSimulator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'JDR 6/8/2022 13:05:47'!
registeringSalesOn: aSalesBook debitingFrom: aMerchantProcessorSimulator 
	
	^self new initializeRegisteringSalesOn: aSalesBook debitingFrom: aMerchantProcessorSimulator ! !


!Cashier class methodsFor: 'error descriptions' stamp: 'JDR 6/6/2022 21:25:27'!
cannotCheckoutEmptyCartErrorDescription
	
	^'cant checkout an empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'JDR 6/6/2022 20:23:39'!
expiredCardErrorDescription
	
	^'credit card is out of date'! !


!classDefinition: #CatchOutMerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #CatchOutMerchantProcessorSimulator
	instanceVariableNames: 'stolenCardRegister'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CatchOutMerchantProcessorSimulator methodsFor: 'initialization' stamp: 'JDR 6/8/2022 13:25:00'!
initializeWith: aStolenCardRegister 

	stolenCardRegister := aStolenCardRegister.! !


!CatchOutMerchantProcessorSimulator methodsFor: 'debiting' stamp: 'JDR 6/8/2022 13:27:35'!
debit: anAmount from: aCreditCard on: aMonthOfYear 

	self error: CatchOutMerchantProcessorSimulator shouldNotBeDebitingErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatchOutMerchantProcessorSimulator class' category: 'TusLibros'!
CatchOutMerchantProcessorSimulator class
	instanceVariableNames: ''!

!CatchOutMerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'JDR 6/8/2022 13:24:40'!
with: aStolenCardRegister 
	
	^self new initializeWith: aStolenCardRegister ! !


!CatchOutMerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'JDR 6/8/2022 13:29:02'!
shouldNotBeDebitingErrorDescription

	'You should not be trying to debit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'cardNumber expirationDate name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'JDR 6/8/2022 04:03:03'!
initializeFor: aName with: aCardNumber expiratingOn: aExpirationDate 
	
	name := aName.
	cardNumber := aCardNumber.
	expirationDate := aExpirationDate.! !


!CreditCard methodsFor: 'testing' stamp: 'JDR 6/6/2022 21:26:50'!
isExpiredOn: aMonthOfYear

	^expirationDate < aMonthOfYear! !


!CreditCard methodsFor: 'comparing' stamp: 'JDR 6/8/2022 12:58:44'!
= aCreditCard

	^(name = aCreditCard name) and: [cardNumber = aCreditCard cardNumber and: [ expirationDate = aCreditCard expirationDate ]] ! !


!CreditCard methodsFor: 'accessing' stamp: 'JDR 6/8/2022 12:54:54'!
cardNumber

	^cardNumber ! !

!CreditCard methodsFor: 'accessing' stamp: 'JDR 6/8/2022 12:55:06'!
expirationDate

	^expirationDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'JDR 6/8/2022 12:54:59'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JDR 6/8/2022 11:11:46'!
ownedBy: aName with: aCardNumber expiratingOn: anExpirationMonthOfYear 

	self assertNameIsValid: aName.	
	
	self assertCardNumberIsValid: aCardNumber.
	
	self assertExpirationDateIsValid: anExpirationMonthOfYear.	
	
	^self new initializeFor: aName with: aCardNumber expiratingOn: anExpirationMonthOfYear ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'JDR 6/6/2022 19:55:38'!
invalidCardNumberErrorDescription
	^ 'the credit card number must be 16'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JDR 6/8/2022 03:58:52'!
invalidExpirationDateErrorDescription

	^'Expiration date must be a month and a year'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JDR 6/8/2022 04:22:07'!
invalidNameErrorDescription

	'Name is too short/long'! !


!CreditCard class methodsFor: 'assertions' stamp: 'JDR 6/8/2022 11:11:32'!
assertCardNumberIsValid: aCardNumber

	^ (aCardNumber size = 16) ifFalse: [self error: CreditCard invalidCardNumberErrorDescription]! !

!CreditCard class methodsFor: 'assertions' stamp: 'JDR 6/8/2022 11:11:46'!
assertExpirationDateIsValid: anExpirationMonthOfYear

	^ (anExpirationMonthOfYear isKindOf: GregorianMonthOfYear) ifFalse: [self error: CreditCard invalidExpirationDateErrorDescription ]! !

!CreditCard class methodsFor: 'assertions' stamp: 'JDR 6/8/2022 11:11:18'!
assertNameIsValid: aName

	^ ((aName withoutSeparators) size between: 4 and: 30) ifFalse: [self error: CreditCard invalidNameErrorDescription ]! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'stolenCardRegister'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'debiting' stamp: 'JDR 6/8/2022 13:57:54'!
assert: aCreditCard isNotExpiredOn: aMonthOfYear

	^ (aCreditCard isExpiredOn: aMonthOfYear) ifTrue: [ self error: MerchantProcessorSimulator expiredCreditCardErrorDescription ]! !

!MerchantProcessorSimulator methodsFor: 'debiting' stamp: 'JDR 6/8/2022 13:57:26'!
assertCreditCardIsAValidObject: aCreditCard

	^ (aCreditCard isKindOf: CreditCard) ifFalse: [ self error: MerchantProcessorSimulator onlyCanDebitFromACreditCardErrorDescription ]! !

!MerchantProcessorSimulator methodsFor: 'debiting' stamp: 'JDR 6/8/2022 13:58:26'!
assertCreditCardIsNotStolen: aCreditCard

	^ (stolenCardRegister includes: aCreditCard) ifTrue: [ self error: MerchantProcessorSimulator stolenCreditCardErrorDescription ]! !

!MerchantProcessorSimulator methodsFor: 'debiting' stamp: 'JDR 6/8/2022 13:58:26'!
debit: anAmount from: aCreditCard on: aMonthOfYear 

	self assertCreditCardIsAValidObject: aCreditCard.
	self assert: aCreditCard isNotExpiredOn: aMonthOfYear.
	self assertCreditCardIsNotStolen: aCreditCard.! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'JDR 6/8/2022 13:46:13'!
initializeWith: aStolenCardsRegister 

	stolenCardRegister := aStolenCardsRegister.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'JDR 6/8/2022 12:33:28'!
expiredCreditCardErrorDescription
	
	^'credit card has expired'! !

!MerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'JDR 6/9/2022 17:56:59'!
fundlessCreditCardErrorDescription

	'fundless credit card'! !

!MerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'JDR 6/8/2022 12:27:49'!
onlyCanDebitFromACreditCardErrorDescription
	
	^'invalid credit card format'! !

!MerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'JDR 6/8/2022 12:40:37'!
stolenCreditCardErrorDescription

	^'that credit card is stolen'! !


!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'JDR 6/8/2022 12:39:13'!
with: aStolenCardsRegister
	
	^self new initializeWith: aStolenCardsRegister ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'cartContentsAFDGRGESG clientID saleID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'AF\ 6/11/2022 14:23:46'!
= aSale

	^(clientID = aSale clientID) and: [cartContentsAFDGRGESG = aSale cartContentsSAFASFDFS].! !

!Sale methodsFor: 'initialization' stamp: 'AF\ 6/11/2022 15:12:14'!
initializeWith: aCartContents for: aClientID 
	
	cartContentsAFDGRGESG := aCartContents.
	clientID := aClientID.! !

!Sale methodsFor: 'initialization' stamp: 'AF\ 6/11/2022 15:11:08'!
initializeWith: aCartContents for: aClientID withSaleID: aSaleID 
	
	cartContentsAFDGRGESG := aCartContents.
	clientID := aClientID.
	saleID := aSaleID.! !


!Sale methodsFor: 'accesing' stamp: 'AF\ 6/11/2022 14:24:20'!
cartContentsSAFASFDFS
	
	^cartContentsAFDGRGESG ! !

!Sale methodsFor: 'accesing' stamp: 'AF\ 6/11/2022 14:24:08'!
clientID
	
	^clientID! !

!Sale methodsFor: 'accesing' stamp: 'AF\ 6/11/2022 15:12:40'!
saleID
	
	^saleID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AF\ 6/11/2022 14:15:13'!
with: aCartContents for: aClientID 
	
	^self new initializeWith: aCartContents for: aClientID ! !

!Sale class methodsFor: 'instance creation' stamp: 'AF\ 6/11/2022 15:10:39'!
with: aCartContents for: aClientID withSaleID: aSaleID 
	
	^self new initializeWith: aCartContents for: aClientID withSaleID: aSaleID ! !


!classDefinition: #SalesBook category: 'TusLibros'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales lastSaleID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'adding' stamp: 'JDR 6/8/2022 11:53:51'!
add: aPurchaseBag

	sales add: aPurchaseBag! !

!SalesBook methodsFor: 'adding' stamp: 'AF\ 6/11/2022 15:09:39'!
addSaleOf: aCart for: aClientID 
	
	| sale idForThisSale |
	
	idForThisSale _ lastSaleID. 
	lastSaleID _ lastSaleID + 1.
	
	sale _  Sale with: aCart content for: aClientID withSaleID: idForThisSale.
	
	sales add: sale.! !


!SalesBook methodsFor: 'testing' stamp: 'AF\ 6/11/2022 14:20:24'!
hasRegistered: aSale
 
	^sales includes: aSale! !

!SalesBook methodsFor: 'testing' stamp: 'JDR 6/8/2022 11:51:21'!
isEmpty
	^sales isEmpty! !


!SalesBook methodsFor: 'initialization' stamp: 'AF\ 6/11/2022 15:06:44'!
initialize

	sales _ OrderedCollection new.
	lastSaleID _ 1.! !


!SalesBook methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 13:31:21'!
contents
	^ sales copy! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 13:48:46'!
getPurchasesOf: clientID

	^ sales copy! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 14:40:50'!
purchasesOf: aClientID
	
	| salesOfClient |
	salesOfClient _ OrderedCollection new.
	sales do:[:aSale | aSale clientID = aClientID  ifTrue: [salesOfClient add: aSale]].
	
	^salesOfClient! !


!classDefinition: #SystemAuthenticator category: 'TusLibros'!
Object subclass: #SystemAuthenticator
	instanceVariableNames: 'userRegister'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemAuthenticator methodsFor: 'initialization' stamp: 'JDR 6/9/2022 20:19:37'!
initializeWith: aUserRegister 
	
	userRegister := aUserRegister.! !


!SystemAuthenticator methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 20:44:31'!
assert: aClientID isRegisteredWith: aPassword 
	
	^(self assertRegisteredUser: aClientID) and: [ self assertValid: aPassword for: aClientID ]! !

!SystemAuthenticator methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 20:40:59'!
assertRegisteredUser: aUserId 
	
	^ userRegister includesKey: aUserId.! !

!SystemAuthenticator methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 20:41:59'!
assertValid: aPassword for: aClientId

	^ (userRegister at: aClientId ) = aPassword 
	
	! !

!SystemAuthenticator methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 11:47:15'!
authenticate: aClientID with: aPassword
	
	(self assert: aClientID isRegisteredWith: aPassword) ifFalse:  [self error: SystemAuthenticator invalidCredentialsErrorDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemAuthenticator class' category: 'TusLibros'!
SystemAuthenticator class
	instanceVariableNames: ''!

!SystemAuthenticator class methodsFor: 'error descriptions' stamp: 'JDR 6/9/2022 20:08:06'!
invalidCredentialsErrorDescription
	
	^'invalid ID or password'! !


!SystemAuthenticator class methodsFor: 'instance creation' stamp: 'JDR 6/9/2022 20:19:14'!
with: aUserRegister

	^self new initializeWith: aUserRegister ! !


!classDefinition: #SystemFacade category: 'TusLibros'!
Object subclass: #SystemFacade
	instanceVariableNames: 'systemAuthenticator carts currentCartId catalog salesBook merchantProcessorSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemFacade methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 12:37:22'!
add: aBook amount: anAmount to: aCartID

	(carts includesKey: aCartID ) ifFalse: [ self error: SystemFacade cantAddToAnInvalidCartIdErrorDescription ].
	(catalog includesKey: aBook ) ifFalse: [ self error: SystemFacade cannotAddBooksNotInCatalogErrorDescription ].
	(carts at: aCartID) add: aBook amount: anAmount 
	! !

!SystemFacade methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 13:23:40'!
checkout: aCartID with: aCreditCard on: aMonthOfYear
	
	| cashier |
	(carts includesKey: aCartID) ifFalse: [self error: SystemFacade cantCheckoutWithAnInvalidCartIDErrorDescription].
	(carts at: aCartID) isEmpty ifTrue: [self error: SystemFacade cantCheckoutAnEmptyCartErrorDescription].
	
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessorSimulator.

	cashier checkout: (carts at: aCartID)  with: aCreditCard on: aMonthOfYear.
	
	^nil! !

!SystemFacade methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 12:32:56'!
createCartForUser: aClientID withPassword: aPassword

	| cartIDToReturn |
	systemAuthenticator authenticate: aClientID with: aPassword.

	cartIDToReturn _ self idForNewCart. 
	carts at: cartIDToReturn put: (Cart with: catalog).
	
	^cartIDToReturn.	
	! !

!SystemFacade methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 11:53:43'!
idForNewCart

	| idToReturn |
	idToReturn _ currentCartId.
	currentCartId _ currentCartId + 1.
	^idToReturn
	
	
	! !

!SystemFacade methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 12:23:30'!
listCart: aCartId 
	
	(carts includesKey: aCartId ) ifFalse: [ self error: SystemFacade cantListAnInvalidCartIdErrorDescription ].
	^ (carts at: aCartId) content.! !

!SystemFacade methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 13:39:32'!
listPurchasesFor: aClientID withPassword: aPassword 
	
	^ salesBook contents! !


!SystemFacade methodsFor: 'initialization' stamp: 'AF\ 6/11/2022 12:09:44'!
initializeAuthenticatingWith: aXXXAuthenticator 
	
	currentCartId _ 1.
	carts _ Dictionary new.
	systemAuthenticator := aXXXAuthenticator.! !

!SystemFacade methodsFor: 'initialization' stamp: 'AF\ 6/11/2022 12:31:04'!
initializeAuthenticatingWith: aSystemAuthenticator with: aCatalog 

	currentCartId _ 1.
	carts _ Dictionary new.
	systemAuthenticator := aSystemAuthenticator.
	catalog := aCatalog.! !

!SystemFacade methodsFor: 'initialization' stamp: 'AF\ 6/11/2022 12:53:03'!
initializeAuthenticatingWith: aSystemAuthenticator with: aCatalog registeringSalesOn: aSalesBook debitingFrom: aMerchantProcessorSimulator 
	
	currentCartId _ 1.
	carts _ Dictionary new.
	systemAuthenticator := aSystemAuthenticator.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessorSimulator := aMerchantProcessorSimulator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemFacade class' category: 'TusLibros'!
SystemFacade class
	instanceVariableNames: ''!

!SystemFacade class methodsFor: 'instance creation' stamp: 'JDR 6/9/2022 20:19:52'!
authenticatingWith: aXXXAuthenticator 

	^self new initializeAuthenticatingWith: aXXXAuthenticator ! !

!SystemFacade class methodsFor: 'instance creation' stamp: 'AF\ 6/11/2022 12:30:32'!
authenticatingWith: aSystemAuthenticator with: aCatalog 
	
	^self new initializeAuthenticatingWith: aSystemAuthenticator with: aCatalog ! !

!SystemFacade class methodsFor: 'instance creation' stamp: 'AF\ 6/11/2022 12:52:36'!
authenticatingWith: aSystemAuthenticator with: aCatalog registeringSalesOn: aSalesBook debitingFrom: aMerchantProcessorSimulator 
	
	^self new initializeAuthenticatingWith: aSystemAuthenticator with: aCatalog registeringSalesOn: aSalesBook debitingFrom: aMerchantProcessorSimulator ! !


!SystemFacade class methodsFor: 'error descriptions' stamp: 'AF\ 6/11/2022 12:36:54'!
cannotAddBooksNotInCatalogErrorDescription

	^'Book is not edited by TusLibros.com'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'AF\ 6/11/2022 12:18:06'!
cantAddToAnInvalidCartIdErrorDescription
	^'cant add to an invalid cartID'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'AF\ 6/11/2022 13:05:24'!
cantCheckoutAnEmptyCartErrorDescription
	
	^ 'cant checkout an empty cart'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'AF\ 6/11/2022 13:04:54'!
cantCheckoutWithAnInvalidCartIDErrorDescription
	
	^'cant checkout to an invalid cartID'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'AF\ 6/11/2022 12:22:22'!
cantListAnInvalidCartIdErrorDescription
	
	^'cant list an invalid cartID'! !


!classDefinition: #TestingUtils category: 'TusLibros'!
Object subclass: #TestingUtils
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:47:10'!
creditCardFundRegister

	| dictionary |
	dictionary _ Dictionary new.
	dictionary at: self validCardNumber put: 100000.
	dictionary at: self stolenCreditCardNumber put: 100000.
	dictionary at: self expiredCreditCardNumber put: 100000.
	dictionary at: self fundlessCardNumber put: 0.
	^dictionary! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:43:51'!
expiredCreditCard
	
	^CreditCard ownedBy: self validCardName with: self expiredCreditCardNumber expiratingOn: (July of: 2020)! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:43:51'!
expiredCreditCardNumber

	^ '8888888888888888'! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:47:40'!
fundlessCardNumber 

	^'3333333333333333'! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:48:35'!
fundlessCreditCard
	
	^CreditCard ownedBy: 'Jorge Sin Fondos' with: self fundlessCardNumber expiratingOn: self validCheckoutMonthOfYear ! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 04:18:21'!
invalidCardName

	^ ' Jaigsrepgepiosegaisdgoipoñjasdjkljjdhfjlljafnv'! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 03:42:27'!
invalidCardNumber
	^'1'! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 03:58:03'!
invalidExpirationDate
	
	^GregorianYear number: 2050! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:42:39'!
stolenCreditCard
	
	^CreditCard ownedBy: 'Enrique' with: self stolenCreditCardNumber expiratingOn: self validCheckoutMonthOfYear ! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:42:39'!
stolenCreditCardNumber

	^ '1111222233334444'! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 13:01:07'!
stolenCreditCardRegister 
	^ OrderedCollection with: self stolenCreditCard.! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 03:53:35'!
validCardName

	^'Juancito'! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 03:53:42'!
validCardNumber
	^'4444555566667777'. ! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 03:42:47'!
validCheckoutMonthOfYear
	^July of: 2022. ! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 03:42:47'!
validCreditCard
	
	^CreditCard ownedBy: self validCardName with: self validCardNumber 	expiratingOn: self validCheckoutMonthOfYear . ! !


!TestingUtils methodsFor: 'book' stamp: 'JDR 6/8/2022 03:37:06'!
book

	^1! !

!TestingUtils methodsFor: 'book' stamp: 'JDR 6/8/2022 03:37:19'!
book2

	^2! !

!TestingUtils methodsFor: 'book' stamp: 'JDR 6/8/2022 11:20:13'!
unregisteredBook
	^0! !


!TestingUtils methodsFor: 'catalog' stamp: 'JDR 6/8/2022 03:37:33'!
catalog
	
	| catalog |
	catalog _ Dictionary new.
	catalog at: self book put: 100.
	catalog at: self book2 put: 50.
	^catalog! !


!TestingUtils methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:19:15'!
clientID1

	^'firstRegisteredID'! !

!TestingUtils methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:19:25'!
clientID2

	^'secondRegisteredID'! !

!TestingUtils methodsFor: 'as yet unclassified' stamp: 'AF\ 6/11/2022 12:40:58'!
invalidCartID

	^nil! !

!TestingUtils methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:19:34'!
invalidClientID

	^'unregisteredID'! !

!TestingUtils methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:19:48'!
invalidPassword
	
	^'invalidPassword'
	! !

!TestingUtils methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:20:27'!
password1

	^'validPasswordForFirstClientID'! !

!TestingUtils methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:20:39'!
password2

	^'validPasswordForSecondClientID'! !

!TestingUtils methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:18:10'!
userRegister
	| register |
	register _ Dictionary new. 
	register at: self clientID1 put: self password1.
	register at: self clientID2 put: self password2.
	^register! !
