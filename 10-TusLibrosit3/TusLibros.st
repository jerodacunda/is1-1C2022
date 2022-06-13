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

!CartTest methodsFor: 'test - accesing' stamp: 'AF 6/13/2022 12:39:44'!
test06CanConsultCartContents

	| cart book expectedCartContent testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils bookISBN.
	
	cart add: book amount: 1.
	expectedCartContent _ Bag with: book.
	
	self assert: expectedCartContent equals: cart content
	
	
	
					
	

	

	! !

!CartTest methodsFor: 'test - accesing' stamp: 'AF 6/13/2022 12:39:44'!
test08CanConsultCartTotalPrice
	
	| cart bookPrice testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	cart add: testingUtils bookISBN amount: 3.
	
	bookPrice _ testingUtils catalog at: testingUtils bookISBN.
	
	self assert: 3 * bookPrice equals: cart subtotal.

	! !


!CartTest methodsFor: 'test - adding' stamp: 'AF 6/13/2022 12:39:44'!
test02ACartShouldNotBeEmptyAfterAddingBookToCart

	| cart book testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils bookISBN.
	
	cart add: book amount: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'test - adding' stamp: 'AF 6/13/2022 12:39:44'!
test03CanAddToCartAnAmountOfACertainBook

	| cart book amount testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils bookISBN.
	amount _ 3.
	
	cart add: book amount: amount.
	
	self assert: amount equals: (cart occurrencesOf: book)
	
	
	
					
	

	

	! !


!CartTest methodsFor: 'test - exceptions' stamp: 'AF 6/13/2022 12:40:54'!
test04OnlyCanAddToCartBooksInCatalog

	| cart testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	
	self 
		should: [ cart add: testingUtils unregisteredBookISBN amount: 1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart cannotAddBooksNotInCatalogErrorDescription.
			self assert: cart isEmpty.
		]
	

	! !

!CartTest methodsFor: 'test - exceptions' stamp: 'AF 6/13/2022 12:39:44'!
test05OnlyCanAddToCartAPositiveAmountOfABook

	| cart book invalidAmount testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils bookISBN.			
	invalidAmount _ 0.
	
	self 
		should: [ cart add: book amount: invalidAmount ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidBookAmountErrorDescription .
			self assert: cart isEmpty.
		]
	

	! !

!CartTest methodsFor: 'test - exceptions' stamp: 'AF 6/13/2022 12:39:44'!
test07OnlyCanAddToCartAnIntegerAmountOfABook

	| cart book invalidAmount testingUtils |
	testingUtils _ TestingUtils new.
	cart _ Cart with: testingUtils catalog.
	book _ testingUtils bookISBN.			
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
	instanceVariableNames: 'testingUtils debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'AF 6/13/2022 11:40:35'!
setUp

	testingUtils _ TestingUtils new.
	debitBehavior  _ [:aFinalPrice :aCreditCart :aDate| ]! !

!CashierTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:24:11'!
test01CheckoutOfAnEmptyCartShouldRaiseAnError

	| cart cashier salesBook |
	
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: self.
	self shouldNotDebitOnThisTest.
	
	self should: [cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cashier cannotCheckoutEmptyCartErrorDescription equals: anError messageText.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test02CheckoutOfACartWithOneBookShouldMatchBookPrice
	
	| cart cashier salesBook sale |
	
	cart _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: self.
	cart add: testingUtils bookISBN amount: 1.
	
	sale _ cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
		
	self assert: 100 equals: sale total.	
	self assert: cart isEmpty.
	self assert: (salesBook hasRegistered: sale).! !

!CashierTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test03CheckoutOfACartEqualsCartSubtotal
	
	| cart cashier expectedPrice salesBook merchantProcessor sale |
	
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart add: testingUtils bookISBN amount: 3.
	cart add: testingUtils bookISBN2 amount: 1.
	sale _ cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
		
	expectedPrice _ 350.
	
	self assert: expectedPrice equals: sale total .
	self assert: cart isEmpty.
	self assert: (salesBook hasRegistered: sale).! !

!CashierTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test04CheckoutWithAnExpiredCardShouldRaiseAnError
	
	| cart cashier salesBook purchase |
	
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new..
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: self.
	
	self shouldNotDebitOnThisTest.
	
	cart add: testingUtils bookISBN amount: 1.
	purchase _ cart content.
	

	self should: [ cashier checkout: cart with: testingUtils expiredCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cashier expiredCardErrorDescription equals: anError messageText .
			self deny: cart isEmpty.
			self deny: (salesBook hasRegistered: purchase).
		]! !

!CashierTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test05CheckoutWithAStolenCardShouldRaiseAnError
	
	| cart cashier salesBook purchase |
	
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: self.
	
	cart add: testingUtils bookISBN amount: 1.
	purchase _ cart content.

	debitBehavior _  [ :aFinalPrice :aCreditCard :aDate | 
		(testingUtils stolenCreditCardRegister includes: aCreditCard) ifTrue: [ self error: Cashier stolenCreditCardErrorDescription]
	].

	self should: [ cashier checkout: cart with: testingUtils stolenCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cashier stolenCreditCardErrorDescription equals: anError messageText .
			self deny: cart isEmpty.
			self deny: (salesBook hasRegistered: purchase).
		]! !

!CashierTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit
	
	| cart cashier salesBook purchase |
	
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: self.
	
	cart add: testingUtils bookISBN amount: 1.
	purchase _ cart content.

	debitBehavior _  [ :aFinalPrice :aCreditCard :aDate | self error: Cashier cannotDebitFromAFundlessCreditCard ].

	self should: [ cashier checkout: cart with: testingUtils stolenCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cashier cannotDebitFromAFundlessCreditCard equals: anError messageText .
			self deny: cart isEmpty.
			self deny: (salesBook hasRegistered: purchase).
		]! !

!CashierTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test07CashierChargesCreditCardUsingMerchantProcessor
	
	| cart cashier salesBook sale debitedAmount debitedCreditCard debitedDate |
	
	cart _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.

	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: self.
	
	debitedAmount _ 100.
	debitedCreditCard _ testingUtils validCreditCard.
	debitBehavior _ [ :aFinalPrice :aCreditCard :aDate |  
		debitedAmount _ aFinalPrice.
		debitedCreditCard _ aCreditCard.
		debitedDate _ aDate.
	].
	
	cart add: testingUtils bookISBN amount: 1.
	
	sale _ cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
		
	self assert: debitedAmount equals: sale total.	
	self assert: debitedCreditCard equals: testingUtils validCreditCard.
	self assert: debitedDate equals: testingUtils validCheckoutMonthOfYear.! !


!CashierTest methodsFor: 'merchant processor - protocol' stamp: 'AF 6/13/2022 11:39:53'!
debit: finalPrice from: aCreditCard on: aDate.

	^debitBehavior value: finalPrice value: aCreditCard value: aDate! !


!CashierTest methodsFor: 'merchant procesor - private' stamp: 'AF 6/13/2022 12:19:59'!
shouldNotDebitOnThisTest
	
	debitBehavior _[:aFinalPrice :aCreditCart :aDate | self error: 'should not be debiting'].! !


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


!classDefinition: #SalesBookTest category: 'TusLibros'!
TestCase subclass: #SalesBookTest
	instanceVariableNames: 'testingUtils'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBookTest methodsFor: 'testing' stamp: 'JDR 6/13/2022 03:28:22'!
setUp

	testingUtils _ TestingUtils new.	! !

!SalesBookTest methodsFor: 'testing' stamp: 'JDR 6/8/2022 13:36:12'!
test01ANewSalesBookShouldBeEmpty

	| salesBook |
	salesBook _ SalesBook new.

	self assert: salesBook isEmpty.! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test02CheckoutOfACartWithACashierShouldRegisterSaleOnSalesBook

	| salesBook cart cashier merchantProcessor sale |
	
	cart _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart add: testingUtils bookISBN amount: 1.	
	sale _ cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
	
	self assert: (salesBook hasRegistered: sale).
	self deny: salesBook isEmpty .
	! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test03ClientIDOfACheckedOutSaleShouldBeBuyerID

	| salesBook cart cashier merchantProcessor sale |
	
	cart _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart add: testingUtils bookISBN amount: 1.	
	sale _ cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.	
	
	self assert: testingUtils clientID1 equals: sale clientID.
	! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test04ContentOfACheckedOutSaleShouldBeSaleContent

	| salesBook cart cashier merchantProcessor sale saleContents |
	
	cart _ Cart with: testingUtils catalog.
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart add: testingUtils bookISBN amount: 1.
	saleContents _ cart content.	
	sale _ cashier checkout: cart with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
	
	self assert: saleContents  equals: sale content.
	! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test05TransactionIDOfDifferentCheckoutsShouldBeDifferent

	| salesBook cashier merchantProcessor cart1 cart2 sale1 sale2 |
		
	cart1 _ Cart with: testingUtils catalog.
	cart2 _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart1 add: testingUtils bookISBN amount: 1.
	cart2 add: testingUtils bookISBN amount: 1.
	
	sale1 _ cashier checkout: cart1 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
	sale2 _ cashier checkout: cart2 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
	
	self deny: (sale1 transactionID) = (sale2 transactionID).
	! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test06ASaleShouldBeRegisteredOnSalesBookUnderItsBuyerID

	| salesBook cashier merchantProcessor cart1 cart2 sale1 expectedSaleOfClient |
		
	cart1 _ Cart with: testingUtils catalog.
	cart2 _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
		
	cart1 add: testingUtils bookISBN amount: 1.
	cart2 add: testingUtils bookISBN amount: 1.
	
	sale1 _ cashier checkout: cart1 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
	expectedSaleOfClient _ OrderedCollection with: sale1.
	
	self assert: expectedSaleOfClient equals: (salesBook getSalesBy: testingUtils clientID1).
	! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test07SalesOfDifferentClientsShouldBeDistinguishedOnSalesBook

	| salesBook cashier merchantProcessor cart1 cart2 sale1 sale2 expectedSaleOfClient1 expectedSaleOfClient2 |
		
	cart1 _ Cart with: testingUtils catalog.
	cart2 _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart1 add: testingUtils bookISBN amount: 1.
	cart2 add: testingUtils bookISBN amount: 1.	
	sale1 _ cashier checkout: cart1 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1. 
	sale2 _ cashier checkout: cart2 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID2.
		
	expectedSaleOfClient1 _ OrderedCollection with: sale1.
	expectedSaleOfClient2 _ OrderedCollection with: sale2.
	
	self assert: expectedSaleOfClient1 equals: (salesBook getSalesBy: testingUtils clientID1).
	self assert: expectedSaleOfClient2 equals: (salesBook getSalesBy: testingUtils clientID2).
	! !

!SalesBookTest methodsFor: 'testing' stamp: 'AF 6/13/2022 12:39:44'!
test08MultipleSalesOfASingleClientShouldBeRegisteredOnSalesBookUnderTheSameBuyerID

	| salesBook cashier merchantProcessor cart1 cart2 sale1 sale2 expectedSalesOfClient1 |
		
	cart1 _ Cart with: testingUtils catalog.
	cart2 _ Cart with: testingUtils catalog.	
	salesBook _ SalesBook new.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister .
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cart1 add: testingUtils bookISBN amount: 1.
	cart2 add: testingUtils bookISBN amount: 1.
	
	sale1 _ cashier checkout: cart1 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1. 
	sale2 _ cashier checkout: cart2 with: testingUtils validCreditCard on: testingUtils validCheckoutMonthOfYear for: testingUtils clientID1.
	
	expectedSalesOfClient1 _ OrderedCollection with: sale1 with: sale2.
	
	self assert: expectedSalesOfClient1 equals: (salesBook getSalesBy: testingUtils clientID1).
	! !


!classDefinition: #SystemFacadeTest category: 'TusLibros'!
TestCase subclass: #SystemFacadeTest
	instanceVariableNames: 'testingUtils catalog dateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemFacadeTest methodsFor: 'testing - list purchases' stamp: 'AF 6/13/2022 12:39:44'!
test13ListPurchasesOfAClientWithAPurchaseShouldReturnThatPurchase

	| systemFacade systemAuthenticator merchantProcessor salesBook cartID1 expectedPurchase purchase timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID1.		
	systemFacade checkout: cartID1 with: testingUtils validCreditCard.
	
	expectedPurchase _ Bag with: testingUtils bookISBN.
	purchase _ systemFacade listPurchasesOf: testingUtils clientID1 withPassword: testingUtils password1.
	
	self assert: expectedPurchase equals: purchase key.
	
	 
	! !

!SystemFacadeTest methodsFor: 'testing - list purchases' stamp: 'AF 6/13/2022 12:39:44'!
test14ListPurchasesOfAClientShouldUnifyDifferentPurchasesOfAGivenItem

	| systemFacade systemAuthenticator merchantProcessor salesBook cartID1 expectedPurchase purchase cartID2 timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID1.		
	systemFacade checkout: cartID1 with: testingUtils validCreditCard.
	
	cartID2 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID2.	
	systemFacade add: testingUtils bookISBN2 amount: 1 to: cartID2.		
	systemFacade checkout: cartID2 with: testingUtils validCreditCard.
	
	expectedPurchase _ Bag new.
	expectedPurchase add: testingUtils bookISBN withOccurrences: 2.
	expectedPurchase add: testingUtils bookISBN2 withOccurrences: 1.
	
	purchase _ systemFacade listPurchasesOf: testingUtils clientID1 withPassword: testingUtils password1.
	
	self assert: expectedPurchase equals: purchase key.
	
	 
	! !

!SystemFacadeTest methodsFor: 'testing - list purchases' stamp: 'AF 6/13/2022 12:39:44'!
test15ListPurchasesOfAClientShouldReturnTotalAmountOfThosePurchases

	| systemFacade systemAuthenticator merchantProcessor salesBook cartID1 expectedPurchase purchase expectedTotalAmount timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID1.		
	systemFacade checkout: cartID1 with: testingUtils validCreditCard.
	
	expectedPurchase _ Bag with: testingUtils bookISBN.
	expectedTotalAmount _ testingUtils catalog at: testingUtils bookISBN..
	
	purchase _ systemFacade listPurchasesOf: testingUtils clientID1 withPassword: testingUtils password1.
	
	self assert: expectedPurchase equals: purchase key.
	self assert: expectedTotalAmount equals: purchase value.
	 
	! !

!SystemFacadeTest methodsFor: 'testing - list purchases' stamp: 'JDR 6/13/2022 04:00:46'!
test16ListPurchasesOfAnUnauthenticatedClientShouldRaiseAnError

	| systemFacade systemAuthenticator merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.

	self should: [ systemFacade listPurchasesOf: testingUtils invalidClientID withPassword: testingUtils invalidPassword . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade invalidCredentialsErrorDescription equals: anError messageText ]
	 
	! !

!SystemFacadeTest methodsFor: 'testing - list purchases' stamp: 'AF 6/13/2022 12:39:44'!
test17ListPurchasesOfDifferentClientsShouldReturnClientsPurchasesAndTotalAmountCorrectly

	| systemFacade systemAuthenticator merchantProcessor salesBook cartID1 cartID2 client1Purchases client1expectedPurchase client1expectedTotalAmmount client2Purchases client2expectedPurchase client2expectedTotalAmmount timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID1.		
	systemFacade checkout: cartID1 with: testingUtils validCreditCard.
	
	client1expectedPurchase _ Bag with: testingUtils bookISBN.
	client1expectedTotalAmmount _ testingUtils catalog at: testingUtils bookISBN.
	
	cartID2 _ systemFacade createCartForUser: testingUtils clientID2 withPassword: testingUtils password2.
	systemFacade add: testingUtils bookISBN2 amount: 1 to: cartID2.		
	systemFacade checkout: cartID2 with: testingUtils validCreditCard.
	
	client2expectedPurchase _ Bag with: testingUtils bookISBN2.
	client2expectedTotalAmmount _ testingUtils catalog at: testingUtils bookISBN2.	
	
	client1Purchases _ systemFacade listPurchasesOf: testingUtils clientID1 withPassword: testingUtils password1.
	client2Purchases _ systemFacade listPurchasesOf: testingUtils clientID2 withPassword: testingUtils password2.
	
	self assert: client1expectedPurchase equals: client1Purchases key.
	self assert: client1expectedTotalAmmount equals: client1Purchases value.
	
	self assert: client2expectedPurchase equals: client2Purchases key.
	self assert: client2expectedTotalAmmount equals: client2Purchases value.
	 
	! !


!SystemFacadeTest methodsFor: 'testing - add' stamp: 'AF 6/13/2022 12:39:44'!
test07AddingAnItemToAInvalidCartIDShouldRaiseAnError

	| systemFacade systemAuthenticator merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
			
	self should: [systemFacade add: testingUtils bookISBN amount: 1 to: testingUtils invalidCartID]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cannotAddToAnInvalidCartIdErrorDescription equals: anError messageText ].
! !

!SystemFacadeTest methodsFor: 'testing - add' stamp: 'AF 6/13/2022 12:40:58'!
test09AddingToCartABookNotInCatalogShouldRaiseAnError

	| systemFacade systemAuthenticator cartID merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
		
	self should: [systemFacade add: testingUtils unregisteredBookISBN amount: 1 to: cartID]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cannotAddBooksNotInCatalogErrorDescription equals: anError messageText ].
! !

!SystemFacadeTest methodsFor: 'testing - add' stamp: 'AF 6/13/2022 12:39:44'!
test20AddingToCartAfter30MinutesOfInactivityShouldRaiseAnError

	| systemFacade cartID systemAuthenticator merchantProcessor salesBook timePassSimulator |

	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.	
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	
	timePassSimulator minutesPassed: 10* minute.		
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID.
	
	timePassSimulator minutesPassed: 25* minute.	
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID.
	
	timePassSimulator minutesPassed: 30* minute.
	self should: [ systemFacade add: testingUtils bookISBN amount: 1 to: cartID.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: CartSession cannotAddToAnExpiredCartErrorDescription equals: anError messageText ]
	
	! !


!SystemFacadeTest methodsFor: 'testing - create cart' stamp: 'JDR 6/13/2022 03:30:32'!
test01CreatingACartForAnUnregisteredClientShouldRaiseAnError

	| systemFacade systemAuthenticator merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.

	self should: [ systemFacade createCartForUser: testingUtils invalidClientID withPassword: testingUtils invalidPassword . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade invalidCredentialsErrorDescription equals: anError messageText ]
	
	 ! !

!SystemFacadeTest methodsFor: 'testing - create cart' stamp: 'JDR 6/13/2022 03:31:51'!
test02CreatingACartForAnUnauthenticatedClientShouldRaiseAnError

	| systemFacade systemAuthenticator merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.

	self should: [ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils invalidPassword . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade invalidCredentialsErrorDescription equals: anError messageText ]
	
	 ! !

!SystemFacadeTest methodsFor: 'testing - create cart' stamp: 'JDR 6/13/2022 03:39:22'!
test04CreatingMultipleCartsShouldAssignThemDifferentCartIDs

	| cartID1 cartID2 merchantProcessor salesBook systemAuthenticator systemFacade timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	cartID2 _ systemFacade createCartForUser: testingUtils clientID2 withPassword: testingUtils password2. 
		
	self deny: cartID1 = cartID2! !


!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'JDR 6/13/2022 03:34:40'!
test03ListCartOfACreatedCartShouldBeEmpty

	| systemFacade cartID systemAuthenticator merchantProcessor salesBook timePassSimulator |

	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	
	self assert: (systemFacade listCart: cartID) isEmpty.! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'AF 6/13/2022 12:39:44'!
test05ListCartOfACartAfterAddingAnItemShouldNotBeEmpty

	| systemFacade systemAuthenticator cartID1 merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID1.
		
	self deny: (systemFacade listCart: cartID1) isEmpty.! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'AF 6/13/2022 12:39:44'!
test06ListCartOfDifferentCartsShouldMatchTheirExpectedContent

	| systemFacade systemAuthenticator cartID1 cartID2 expectedCartContentsForCart1 expectedCartContentsForCart2 merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	cartID2 _ systemFacade createCartForUser: testingUtils clientID2 withPassword: testingUtils password2.
	
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID1.
	systemFacade add: testingUtils bookISBN2 amount: 1 to: cartID2.
	
	expectedCartContentsForCart1 _ Bag with: testingUtils bookISBN.
	expectedCartContentsForCart2 _ Bag with: testingUtils bookISBN2.
		
	self assert: expectedCartContentsForCart1 equals: (systemFacade listCart: cartID1).
	self assert: expectedCartContentsForCart2 equals: (systemFacade listCart: cartID2).! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'JDR 6/13/2022 03:40:08'!
test08ListCartOfAnInvalidCartIDShouldRaiseAnError

	| systemFacade systemAuthenticator merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
		
	self should: [systemFacade listCart: testingUtils invalidCartID ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cannotListAnInvalidCartIdErrorDescription equals: anError messageText ].
! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'JDR 6/13/2022 03:50:12'!
test18ListCartAfter30MinutesOfInactivityShouldRaiseAnError

	| systemFacade cartID systemAuthenticator merchantProcessor salesBook timePassSimulator |

	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.	
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	
	timePassSimulator minutesPassed: 30 * minute .	
	
	self should: [ systemFacade listCart: cartID ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: CartSession cannotListAnExpiredCartErrorDescription equals: anError messageText ]! !

!SystemFacadeTest methodsFor: 'testing - list cart' stamp: 'JDR 6/13/2022 03:51:30'!
test19ListCartShouldRefreshLastCartInteraction

	| systemFacade cartID systemAuthenticator merchantProcessor salesBook timePassSimulator |

	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.	
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	
	timePassSimulator minutesPassed: 10* minute.		
	systemFacade listCart: cartID.
	
	timePassSimulator minutesPassed: 25* minute.	
	systemFacade listCart: cartID.
	! !


!SystemFacadeTest methodsFor: 'testing - checkout' stamp: 'JDR 6/13/2022 03:46:59'!
test10CheckoutOfAnEmptyCartShouldRaiseAnError

	| systemFacade systemAuthenticator cartID1 merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	
	self should: [systemFacade checkout: cartID1 with: (testingUtils validCreditCard)] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | self assert: SystemFacade cannotCheckoutAnEmptyCartErrorDescription  equals: anError messageText] .
	! !

!SystemFacadeTest methodsFor: 'testing - checkout' stamp: 'JDR 6/13/2022 03:47:17'!
test11CheckoutOfAnInvalidCartIDShouldRaiseAnError

	| systemFacade systemAuthenticator merchantProcessor salesBook timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.

	
	self should: [systemFacade checkout: testingUtils invalidCartID with: (testingUtils validCreditCard)] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | self assert: SystemFacade cannotCheckoutWithAnInvalidCartIDErrorDescription  equals: anError messageText] .
	! !

!SystemFacadeTest methodsFor: 'testing - checkout' stamp: 'AF 6/13/2022 12:39:44'!
test12TransactionIDsForDifferentCheckoutsShouldBeDifferent

	| systemFacade systemAuthenticator merchantProcessor salesBook cartID1 cartID2 transactionID1 transactionID2 timePassSimulator |
	
	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID1 _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1.
	cartID2 _ systemFacade createCartForUser: testingUtils clientID2 withPassword: testingUtils password2.
	
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID1.
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID2.
		
	transactionID1 _ systemFacade checkout: cartID1 with: testingUtils validCreditCard.
	transactionID2 _ systemFacade checkout: cartID2 with: testingUtils validCreditCard	.
	
	self deny: transactionID1 = transactionID2
	
	
	 
	! !

!SystemFacadeTest methodsFor: 'testing - checkout' stamp: 'AF 6/13/2022 12:39:44'!
test21CheckoutOfACartAfter30MinutesOfInactivityShouldRaiseAnError

	| systemFacade cartID systemAuthenticator merchantProcessor salesBook timePassSimulator |

	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.	
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID.	
	
	timePassSimulator minutesPassed: 30 * minute.
	
	self should: [ systemFacade checkout: cartID with: (testingUtils validCreditCard) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: CartSession cannotCheckoutAnExpiredCartErrorDescription equals: anError messageText ]
	
	! !

!SystemFacadeTest methodsFor: 'testing - checkout' stamp: 'AF 6/13/2022 12:39:44'!
test22CheckoutOfACartShouldRemoveCartIDFromSystem

	| systemFacade cartID systemAuthenticator merchantProcessor salesBook timePassSimulator |

	systemAuthenticator _ SystemAuthenticator with: testingUtils userRegister.
	merchantProcessor _ MerchantProcessorSimulator with: testingUtils stolenCreditCardRegister.	
	salesBook _ SalesBook new.	
	timePassSimulator _ TimePassSimulator startingOn: dateTime.
	systemFacade _ SystemFacade authenticatingWith: systemAuthenticator with: catalog registeringSalesOn: salesBook debitingFrom: merchantProcessor measuringTimeWith: timePassSimulator.
	
	cartID _ systemFacade createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	systemFacade add: testingUtils bookISBN amount: 1 to: cartID.	
	systemFacade checkout: cartID with: (testingUtils validCreditCard).
		
	self should: [ systemFacade listCart: cartID ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cannotListAnInvalidCartIdErrorDescription equals: anError messageText ].
		
	self should: [ systemFacade add: testingUtils bookISBN amount: 1 to: cartID ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cannotAddToAnInvalidCartIdErrorDescription equals: anError messageText ].
		
	self should: [ systemFacade checkout: cartID with: (testingUtils validCreditCard) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: SystemFacade cannotCheckoutWithAnInvalidCartIDErrorDescription equals: anError messageText ].		
	
	! !


!SystemFacadeTest methodsFor: 'setUp' stamp: 'JDR 6/13/2022 01:55:58'!
setUp

	testingUtils _ TestingUtils new.
	catalog _ testingUtils catalog.
	dateTime _ testingUtils dateTime.
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


!classDefinition: #CartSession category: 'TusLibros'!
Object subclass: #CartSession
	instanceVariableNames: 'cart cartID clientID lastInteractionDateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'JDR 6/13/2022 01:37:03'!
initializeWith: aCart identifyingAs: aCartID of: aClientID createdOn: aDateTime 
	
	cart := aCart.
	cartID := aCartID.
	clientID := aClientID.
	lastInteractionDateTime := aDateTime.! !


!CartSession methodsFor: 'accessing - private' stamp: 'AF 6/12/2022 21:42:47'!
cart
	
	^cart! !

!CartSession methodsFor: 'accessing - private' stamp: 'AF 6/12/2022 21:42:36'!
cartID
	
	^cartID! !

!CartSession methodsFor: 'accessing - private' stamp: 'AF 6/12/2022 21:49:46'!
clientID
	
	^clientID! !


!CartSession methodsFor: 'updating' stamp: 'JDR 6/13/2022 01:37:03'!
updateLastInteraction: aDateTime

	lastInteractionDateTime _ aDateTime
	
	! !


!CartSession methodsFor: 'expiration handling' stamp: 'JDR 6/13/2022 01:37:03'!
isExpiredOn: aDateTime do: anExceptionBlock 
	
	(aDateTime >= (lastInteractionDateTime next: 30*minute)) ifTrue: anExceptionBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'JDR 6/12/2022 23:50:22'!
with: aCart identifyingAs: aCartID of: aClientID createdOn: aDateTime 
	
	^self new initializeWith: aCart identifyingAs: aCartID of: aClientID createdOn: aDateTime

	! !


!CartSession class methodsFor: 'error descriptions' stamp: 'JDR 6/13/2022 00:21:41'!
cannotAddToAnExpiredCartErrorDescription

	^'cannot add to an expired cart'! !

!CartSession class methodsFor: 'error descriptions' stamp: 'JDR 6/13/2022 00:25:36'!
cannotCheckoutAnExpiredCartErrorDescription

	^'cannot checkout an expired cart'! !

!CartSession class methodsFor: 'error descriptions' stamp: 'JDR 6/12/2022 23:22:47'!
cannotListAnExpiredCartErrorDescription

	^'cannot list an expired cart'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checking out' stamp: 'AF 6/13/2022 11:37:42'!
assert: aCreditCard isNotExpiredOn: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: Cashier expiredCardErrorDescription]. ! !

!Cashier methodsFor: 'checking out' stamp: 'AF 6/13/2022 11:36:50'!
assertIsNotEmpty: aCart

	(aCart isEmpty) ifTrue:[self error: Cashier cannotCheckoutEmptyCartErrorDescription].! !

!Cashier methodsFor: 'checking out' stamp: 'AF 6/13/2022 12:35:47'!
checkout: aCart with: aCreditCard on: aDate for: aClientID 

	| sale finalPrice |
	self assertIsNotEmpty: aCart.
	self assert: aCreditCard isNotExpiredOn: aDate. 
	
	finalPrice _ self finalPrice: aCart subtotal.
	merchantProcessor debit: finalPrice from: aCreditCard on: aDate.
	sale _ salesBook addSaleWith: aCart content pricing: finalPrice for: aClientID.	
	
	aCart clearContent.
	
	^sale! !

!Cashier methodsFor: 'checking out' stamp: 'AF 6/12/2022 20:22:26'!
finalPrice: aSubtotal

	^ aSubtotal! !


!Cashier methodsFor: 'initialization' stamp: 'AF 6/13/2022 12:35:47'!
initializeRegisteringSalesOn: aSalesBook debitingFrom: aMerchantProcessor 
	
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AF 6/13/2022 12:35:30'!
registeringSalesOn: aSalesBook debitingFrom: aMerchantProcessor 
	
	^self new initializeRegisteringSalesOn: aSalesBook debitingFrom: aMerchantProcessor ! !


!Cashier class methodsFor: 'error descriptions - merchant processor' stamp: 'AF 6/13/2022 11:53:39'!
cannotDebitFromAFundlessCreditCard
	
	^'Cant debit from a fundless credit card'! !

!Cashier class methodsFor: 'error descriptions - merchant processor' stamp: 'AF 6/13/2022 11:49:46'!
stolenCreditCardErrorDescription
	
	^'cannot debit from a stolen credit card'! !


!Cashier class methodsFor: 'error descriptions' stamp: 'JDR 6/6/2022 21:25:27'!
cannotCheckoutEmptyCartErrorDescription
	
	^'cant checkout an empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'JDR 6/6/2022 20:23:39'!
expiredCardErrorDescription
	
	^'credit card is out of date'! !


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

!CreditCard class methodsFor: 'instance creation' stamp: 'JDR 6/13/2022 04:08:01'!
ownedBy: aName with: aCardNumber expiratingOn: anExpirationMonthOfYear 

	self assertNameIsValid: aName.	
	
	self assertCardNumberIsValid: aCardNumber.

	^self new initializeFor: aName with: aCardNumber expiratingOn: anExpirationMonthOfYear ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'JDR 6/6/2022 19:55:38'!
invalidCardNumberErrorDescription
	^ 'the credit card number must be 16'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JDR 6/8/2022 04:22:07'!
invalidNameErrorDescription

	'Name is too short/long'! !


!CreditCard class methodsFor: 'assertions' stamp: 'JDR 6/8/2022 11:11:32'!
assertCardNumberIsValid: aCardNumber

	^ (aCardNumber size = 16) ifFalse: [self error: CreditCard invalidCardNumberErrorDescription]! !

!CreditCard class methodsFor: 'assertions' stamp: 'AF 6/13/2022 12:43:06'!
assertNameIsValid: aName

	((aName withoutSeparators isEmpty not) and: [self assertOnlyLetters: (aName withoutSeparators)]) 		ifFalse: [self error: CreditCard invalidNameErrorDescription ]
		! !

!CreditCard class methodsFor: 'assertions' stamp: 'JDR 6/13/2022 04:14:40'!
assertOnlyLetters: aName

	^aName allSatisfy: [ :aCharacter | aCharacter isLetter ] ! !


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

!MerchantProcessorSimulator methodsFor: 'debiting' stamp: 'AF 6/13/2022 12:29:13'!
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
	instanceVariableNames: 'finalPrice clientID saleContents transactionID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'JDR 6/12/2022 23:08:12'!
initializeWith: aSaleContents pricing: aFinalPrice for: aClientID identifyingAs: aTransactionID 
	
	saleContents := aSaleContents.
	finalPrice := aFinalPrice.
	clientID := aClientID.
	transactionID := aTransactionID.! !


!Sale methodsFor: 'accessing' stamp: 'AF 6/12/2022 19:02:27'!
clientID

	^clientID! !

!Sale methodsFor: 'accessing' stamp: 'JDR 6/13/2022 02:50:53'!
content

	^saleContents ! !

!Sale methodsFor: 'accessing' stamp: 'AF 6/12/2022 18:53:04'!
total
	
	^finalPrice ! !

!Sale methodsFor: 'accessing' stamp: 'JDR 6/12/2022 23:06:16'!
transactionID
	
	^transactionID ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'JDR 6/13/2022 02:50:42'!
with: aSaleContent pricing: aFinalPrice for: aClientID identifyingBy: aTransactionID 
	
	^self new initializeWith: aSaleContent pricing: aFinalPrice for: aClientID identifyingAs: aTransactionID ! !


!classDefinition: #SalesBook category: 'TusLibros'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales currentSaleID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'adding - private' stamp: 'AF 6/13/2022 12:38:13'!
getCurrentSaleID
	
	| saleID |
	saleID _ currentSaleID.
	currentSaleID _ currentSaleID + 1	.
	^saleID! !


!SalesBook methodsFor: 'adding' stamp: 'AF 6/13/2022 12:38:13'!
addSaleWith: aSaleContents pricing: aFinalPrice for: aClientID 
	
	| sale saleID |
	saleID _ self getCurrentSaleID.
	sale _ Sale with: aSaleContents pricing: aFinalPrice for: aClientID identifyingBy: saleID.
	sales add: sale.
	
	^sale.! !


!SalesBook methodsFor: 'testing' stamp: 'JDR 6/8/2022 11:53:29'!
hasRegistered: aPurchaseBag
 
	^sales includes: aPurchaseBag! !

!SalesBook methodsFor: 'testing' stamp: 'JDR 6/8/2022 11:51:21'!
isEmpty
	^sales isEmpty! !


!SalesBook methodsFor: 'initialization' stamp: 'AF 6/13/2022 12:37:22'!
initialize

	sales _ OrderedCollection new.
	currentSaleID _ 1.! !


!SalesBook methodsFor: 'accessing' stamp: 'AF 6/12/2022 19:38:20'!
getSalesBy: aClientID
	
	
	^sales select: [ :aSale | (aSale clientID = aClientID)].
	! !


!classDefinition: #SystemAuthenticator category: 'TusLibros'!
Object subclass: #SystemAuthenticator
	instanceVariableNames: 'userRegister'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemAuthenticator methodsFor: 'initialization' stamp: 'JDR 6/9/2022 20:19:37'!
initializeWith: aUserRegister 
	
	userRegister := aUserRegister.! !


!SystemAuthenticator methodsFor: 'authenticating' stamp: 'AF 6/12/2022 21:16:00'!
authenticate: aClientID with: aPassword
	
	^self assert: aClientID isRegisteredWith: aPassword! !


!SystemAuthenticator methodsFor: 'assertions' stamp: 'JDR 6/9/2022 20:44:31'!
assert: aClientID isRegisteredWith: aPassword 
	
	^(self assertRegisteredUser: aClientID) and: [ self assertValid: aPassword for: aClientID ]! !

!SystemAuthenticator methodsFor: 'assertions' stamp: 'JDR 6/9/2022 20:40:59'!
assertRegisteredUser: aUserId 
	
	^ userRegister includesKey: aUserId.! !

!SystemAuthenticator methodsFor: 'assertions' stamp: 'JDR 6/9/2022 20:41:59'!
assertValid: aPassword for: aClientId

	^ (userRegister at: aClientId ) = aPassword 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemAuthenticator class' category: 'TusLibros'!
SystemAuthenticator class
	instanceVariableNames: ''!

!SystemAuthenticator class methodsFor: 'instance creation' stamp: 'JDR 6/9/2022 20:19:14'!
with: aUserRegister

	^self new initializeWith: aUserRegister ! !


!classDefinition: #SystemFacade category: 'TusLibros'!
Object subclass: #SystemFacade
	instanceVariableNames: 'systemAuthenticator currentCartId catalog salesBook merchantProcessor cartSessions timePass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemFacade methodsFor: 'creating' stamp: 'JDR 6/13/2022 01:43:51'!
createCartForUser: aClientID withPassword: aPassword

	| cartIDToReturn cartSession |
	self assert: aClientID authenticatedWith: aPassword.	
	
	cartIDToReturn _ self idForNewCart.
	cartSession _ CartSession with: (Cart with: catalog) identifyingAs: cartIDToReturn of: aClientID createdOn: timePass now.
	cartSessions add: cartSession.
	
	^cartIDToReturn.	
	! !


!SystemFacade methodsFor: 'initialization' stamp: 'AF 6/13/2022 12:35:08'!
initializeAuthenticatingWith: aSystemAuthenticator with: aCatalog registeringSalesOn: aSalesBook debitingFrom: aMerchantProcessor measuringTimeWith: aTimePass 
	
	currentCartId _ 1.
	cartSessions _ OrderedCollection new.
	systemAuthenticator := aSystemAuthenticator.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	timePass := aTimePass.! !


!SystemFacade methodsFor: 'adding' stamp: 'JDR 6/13/2022 03:24:07'!
add: aBook amount: anAmount to: aCartID

	| cartSession |
	cartSession _ self getCartSessionBy: aCartID ifAbsent: [self error: SystemFacade cannotAddToAnInvalidCartIdErrorDescription].
	self assertRegisteredProduct: aBook.	
	
	cartSession isExpiredOn: (timePass now) do: [ self error: CartSession cannotAddToAnExpiredCartErrorDescription ].
	cartSession updateLastInteraction: timePass now.
	cartSession cart add: aBook amount: anAmount 
	! !


!SystemFacade methodsFor: 'checkout' stamp: 'AF 6/13/2022 12:34:59'!
checkout: aCartID with: aCreditCard 
	
	| cart cashier sale cartSession |
	cartSession _ self getCartSessionBy: aCartID ifAbsent: [self error: SystemFacade cannotCheckoutWithAnInvalidCartIDErrorDescription].
	cart _ cartSession cart.
	
	cart isEmpty ifTrue: [self error: SystemFacade cannotCheckoutAnEmptyCartErrorDescription].
	cashier _ Cashier registeringSalesOn: salesBook debitingFrom: merchantProcessor.
	
	cartSession isExpiredOn: timePass now do: [ self error: CartSession cannotCheckoutAnExpiredCartErrorDescription ].
	sale _ cashier checkout: cart with: aCreditCard on: timePass nowAsMonthOfYear for: cartSession clientID .
	
	cartSessions remove: cartSession.
	
	^sale transactionID.! !


!SystemFacade methodsFor: 'accessing - private' stamp: 'JDR 6/13/2022 01:29:18'!
getCartSessionBy: aCartID ifAbsent: exceptionBlock.
	
	^cartSessions detect: [ :aCartSessione | aCartSessione cartID = aCartID ] ifNone: exceptionBlock.! !

!SystemFacade methodsFor: 'accessing - private' stamp: 'JDR 6/13/2022 01:49:39'!
getContentOfAll: clientPurchases

	| productsBoughtByClient |	
	
	productsBoughtByClient _ Bag new.
	clientPurchases do:[ :aSale | 		productsBoughtByClient addAll: aSale content	].
	^productsBoughtByClient ! !

!SystemFacade methodsFor: 'accessing - private' stamp: 'AF\ 6/11/2022 11:53:43'!
idForNewCart

	| idToReturn |
	idToReturn _ currentCartId.
	currentCartId _ currentCartId + 1.
	^idToReturn
	
	
	! !


!SystemFacade methodsFor: 'accessing' stamp: 'JDR 6/13/2022 03:24:42'!
listCart: aCartID 
	
	| cartSession |	
	cartSession _ self getCartSessionBy: aCartID ifAbsent: [self error: SystemFacade cannotListAnInvalidCartIdErrorDescription ].
	cartSession isExpiredOn: timePass now do: [ self error: CartSession cannotListAnExpiredCartErrorDescription ].
	cartSession updateLastInteraction: timePass now.
	^ cartSession cart content.! !

!SystemFacade methodsFor: 'accessing' stamp: 'JDR 6/13/2022 01:50:00'!
listPurchasesOf: aClientID withPassword: aPassword 
	
	| clientPurchases productsBoughtByClient totalPrice |
	
	self assert: aClientID authenticatedWith: aPassword.	
	
	clientPurchases _ salesBook getSalesBy: aClientID.		
	totalPrice _ clientPurchases sum: [:aSale | aSale total ].	
	productsBoughtByClient _ self getContentOfAll: clientPurchases.	
	
	^ productsBoughtByClient -> totalPrice. 
	! !


!SystemFacade methodsFor: 'assertions' stamp: 'JDR 6/13/2022 01:44:02'!
assert: aClientID authenticatedWith: aPassword.	
	
	(systemAuthenticator authenticate: aClientID with: aPassword) ifFalse: [self error: SystemFacade invalidCredentialsErrorDescription].! !

!SystemFacade methodsFor: 'assertions' stamp: 'JDR 6/13/2022 01:31:42'!
assertRegisteredProduct: aBook
	
	(catalog includesKey: aBook ) ifFalse: [ self error: SystemFacade cannotAddBooksNotInCatalogErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemFacade class' category: 'TusLibros'!
SystemFacade class
	instanceVariableNames: ''!

!SystemFacade class methodsFor: 'instance creation' stamp: 'AF 6/13/2022 12:35:16'!
authenticatingWith: aSystemAuthenticator with: aCatalog registeringSalesOn: aSalesBook debitingFrom: aMerchantProcessor measuringTimeWith: aTimePass 
	
	^self new initializeAuthenticatingWith: aSystemAuthenticator with: aCatalog registeringSalesOn: aSalesBook debitingFrom: aMerchantProcessor measuringTimeWith: aTimePass ! !


!SystemFacade class methodsFor: 'error descriptions' stamp: 'AF\ 6/11/2022 12:36:54'!
cannotAddBooksNotInCatalogErrorDescription

	^'Book is not edited by TusLibros.com'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'JDR 6/13/2022 03:24:07'!
cannotAddToAnInvalidCartIdErrorDescription
	^'cant add to an invalid cartID'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'JDR 6/13/2022 03:24:23'!
cannotCheckoutAnEmptyCartErrorDescription
	
	^ 'cant checkout an empty cart'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'JDR 6/13/2022 03:24:33'!
cannotCheckoutWithAnInvalidCartIDErrorDescription
	
	^'cant checkout to an invalid cartID'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'JDR 6/13/2022 03:24:42'!
cannotListAnInvalidCartIdErrorDescription
	
	^'cant list an invalid cartID'! !

!SystemFacade class methodsFor: 'error descriptions' stamp: 'AF 6/12/2022 21:16:52'!
invalidCredentialsErrorDescription
	
	^'invalid ID or password'! !


!classDefinition: #TestingUtils category: 'TusLibros'!
Object subclass: #TestingUtils
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:43:51'!
expiredCreditCard
	
	^CreditCard ownedBy: self validCardName with: self expiredCreditCardNumber expiratingOn: (July of: 2020)! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/9/2022 17:43:51'!
expiredCreditCardNumber

	^ '8888888888888888'! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/13/2022 04:11:03'!
invalidCardName

	^ '        6¿¿40      '! !

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

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/13/2022 01:58:48'!
validCheckoutMonthOfYear
	^(self validMonth) of: self validYear. ! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/8/2022 03:42:47'!
validCreditCard
	
	^CreditCard ownedBy: self validCardName with: self validCardNumber 	expiratingOn: self validCheckoutMonthOfYear . ! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/13/2022 01:59:05'!
validMonth

	^July! !

!TestingUtils methodsFor: 'credit card' stamp: 'JDR 6/13/2022 01:59:30'!
validYear

	^2022! !


!TestingUtils methodsFor: 'book' stamp: 'AF 6/13/2022 12:39:44'!
bookISBN

	^1! !

!TestingUtils methodsFor: 'book' stamp: 'AF 6/13/2022 12:39:25'!
bookISBN2

	^2! !

!TestingUtils methodsFor: 'book' stamp: 'AF 6/13/2022 12:40:03'!
unregisteredBookISBN
	^0! !


!TestingUtils methodsFor: 'catalog' stamp: 'AF 6/13/2022 12:39:44'!
catalog
	
	| catalog |
	catalog _ Dictionary new.
	catalog at: self bookISBN put: 100.
	catalog at: self bookISBN2 put: 50.
	^catalog! !


!TestingUtils methodsFor: 'client authentication' stamp: 'JDR 6/9/2022 21:19:15'!
clientID1

	^'firstRegisteredID'! !

!TestingUtils methodsFor: 'client authentication' stamp: 'JDR 6/9/2022 21:19:25'!
clientID2

	^'secondRegisteredID'! !

!TestingUtils methodsFor: 'client authentication' stamp: 'JDR 6/9/2022 21:19:34'!
invalidClientID

	^'unregisteredID'! !

!TestingUtils methodsFor: 'client authentication' stamp: 'JDR 6/9/2022 21:19:48'!
invalidPassword
	
	^'invalidPassword'
	! !

!TestingUtils methodsFor: 'client authentication' stamp: 'JDR 6/9/2022 21:20:27'!
password1

	^'validPasswordForFirstClientID'! !

!TestingUtils methodsFor: 'client authentication' stamp: 'JDR 6/9/2022 21:20:39'!
password2

	^'validPasswordForSecondClientID'! !

!TestingUtils methodsFor: 'client authentication' stamp: 'JDR 6/9/2022 21:18:10'!
userRegister
	| register |
	register _ Dictionary new. 
	register at: self clientID1 put: self password1.
	register at: self clientID2 put: self password2.
	^register! !


!TestingUtils methodsFor: 'cart' stamp: 'AF\ 6/11/2022 12:40:58'!
invalidCartID

	^nil! !


!TestingUtils methodsFor: 'time' stamp: 'JDR 6/13/2022 02:01:23'!
dateTime
	^GregorianDateTime
			date: (FixedGregorianDate yearNumber: (self validYear) monthNumber: self validMonth number dayNumber: 11)
			timeOfDay: (TimeOfDay  hours: 00).! !


!classDefinition: #TimePassSimulator category: 'TusLibros'!
Object subclass: #TimePassSimulator
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimePassSimulator methodsFor: 'time simulating' stamp: 'JDR 6/13/2022 01:05:10'!
minutesPassed: anAmountOfMinutes
	
	now _ now next: anAmountOfMinutes .! !


!TimePassSimulator methodsFor: 'accessing' stamp: 'JDR 6/13/2022 01:05:10'!
now

	^now! !

!TimePassSimulator methodsFor: 'accessing' stamp: 'JDR 6/13/2022 02:05:00'!
nowAsMonthOfYear
		
	^now monthOfYear ! !


!TimePassSimulator methodsFor: 'initialization' stamp: 'JDR 6/13/2022 01:08:51'!
initializeStartingOn: aGregorianDateTime 
	
	now := aGregorianDateTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TimePassSimulator class' category: 'TusLibros'!
TimePassSimulator class
	instanceVariableNames: ''!

!TimePassSimulator class methodsFor: 'instance creation' stamp: 'JDR 6/13/2022 01:08:23'!
startingOn: aGregorianDateTime 
	
	^self new initializeStartingOn: aGregorianDateTime ! !
