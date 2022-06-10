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


!classDefinition: #XXXTest category: 'TusLibros'!
TestCase subclass: #XXXTest
	instanceVariableNames: 'testingUtils'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!XXXTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:21:15'!
setUp

	testingUtils _ TestingUtils new.! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:22:25'!
test01

	| xxx xxxAuthenticator |
	
	xxxAuthenticator _ XXXAuthenticator with: testingUtils userRegister.
	
	xxx _ XXX authenticatingWith: xxxAuthenticator.

	self should: [ xxx createCartForUser: testingUtils invalidClientID withPassword: testingUtils invalidPassword . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: XXXAuthenticator invalidCredentialsErrorDescription equals: anError messageText ]
	
	 ! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:31:44'!
test01_1

	| xxx xxxAuthenticator |
	
	xxxAuthenticator _ XXXAuthenticator with: testingUtils userRegister.
	
	xxx _ XXX authenticatingWith: xxxAuthenticator.

	self should: [ xxx createCartForUser: testingUtils clientID1 withPassword: testingUtils invalidPassword . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: XXXAuthenticator invalidCredentialsErrorDescription equals: anError messageText ]
	
	 ! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:23:06'!
test02

	| xxx cartID xxxAuthenticator |

	xxxAuthenticator _ XXXAuthenticator with: testingUtils userRegister.
	xxx _ XXX authenticatingWith: xxxAuthenticator.	
	
	cartID _ xxx createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	
	self assert: (xxx listCart: cartID) isEmpty.! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:24:21'!
test03

	| xxx xxxAuthenticator cartID1 |
	
	xxxAuthenticator _ XXXAuthenticator with: testingUtils userRegister.
	xxx _ XXX authenticatingWith: xxxAuthenticator .	
	
	cartID1 _ xxx createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	xxx add: testingUtils book amount: 1 to: cartID1.
	
	xxx createCartForUser: testingUtils clientID2 withPassword: testingUtils password2. 
		
	self deny: (xxx listCart: cartID1) isEmpty.! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:25:23'!
test04

	| xxx xxxAuthenticator cartID1 cartID2 |
	
	xxxAuthenticator _ XXXAuthenticator with: testingUtils userRegister.
	xxx _ XXX authenticatingWith: xxxAuthenticator .	
	
	cartID1 _ xxx createCartForUser: testingUtils clientID1 withPassword: testingUtils password1. 
	xxx add: testingUtils book amount: 1 to: cartID1.
	
	cartID2 _ xxx createCartForUser: testingUtils clientID2 withPassword: testingUtils password2. 
		
	self deny: (xxx listCart: cartID1) isEmpty.
	self assert: (xxx listCart: cartID2) isEmpty.! !


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


!classDefinition: #SalesBook category: 'TusLibros'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'adding' stamp: 'JDR 6/8/2022 11:53:51'!
add: aPurchaseBag

	sales add: aPurchaseBag! !


!SalesBook methodsFor: 'testing' stamp: 'JDR 6/8/2022 11:53:29'!
hasRegistered: aPurchaseBag
 
	^sales includes: aPurchaseBag! !

!SalesBook methodsFor: 'testing' stamp: 'JDR 6/8/2022 11:51:21'!
isEmpty
	^sales isEmpty! !


!SalesBook methodsFor: 'initialization' stamp: 'JDR 6/8/2022 11:42:41'!
initialize

	sales _ OrderedCollection new.! !


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


!classDefinition: #XXX category: 'TusLibros'!
Object subclass: #XXX
	instanceVariableNames: 'xXXAuthenticator carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:15:40'!
add: aBook amount: anAmount to: aCartID

	carts first add: aBook amount: anAmount 
	! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:30:31'!
createCartForUser: aClientID withPassword: aPassword

	
	| currentCartId |
	xXXAuthenticator authenticate: aClientID with: aPassword.
	
	currentCartId _ self idForNewCart. 
	carts at: currentCartId put: (Cart with: TestingUtils new catalog).
	
	^currentCartId.	
	! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 20:37:29'!
idForNewCart

	| idToReturn |
	idToReturn _ currentCartId.
	currentCartId _ currentCartId+ 1.
	^idToReturn
	
	
	! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 21:15:28'!
listCart: aCartId 
	
	^ carts first.! !


!XXX methodsFor: 'initialization' stamp: 'JDR 6/9/2022 21:14:38'!
initializeAuthenticatingWith: aXXXAuthenticator 
	
	carts _ OrderedCollection new.
	xXXAuthenticator := aXXXAuthenticator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXX class' category: 'TusLibros'!
XXX class
	instanceVariableNames: ''!

!XXX class methodsFor: 'instance creation' stamp: 'JDR 6/9/2022 20:19:52'!
authenticatingWith: aXXXAuthenticator 

	^self new initializeAuthenticatingWith: aXXXAuthenticator ! !


!classDefinition: #XXXAuthenticator category: 'TusLibros'!
Object subclass: #XXXAuthenticator
	instanceVariableNames: 'userRegister'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!XXXAuthenticator methodsFor: 'initialization' stamp: 'JDR 6/9/2022 20:19:37'!
initializeWith: aUserRegister 
	
	userRegister := aUserRegister.! !


!XXXAuthenticator methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 20:44:31'!
assert: aClientID isRegisteredWith: aPassword 
	
	^(self assertRegisteredUser: aClientID) and: [ self assertValid: aPassword for: aClientID ]! !

!XXXAuthenticator methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 20:40:59'!
assertRegisteredUser: aUserId 
	
	^ userRegister includesKey: aUserId.! !

!XXXAuthenticator methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 20:41:59'!
assertValid: aPassword for: aClientId

	^ (userRegister at: aClientId ) = aPassword 
	
	! !

!XXXAuthenticator methodsFor: 'as yet unclassified' stamp: 'JDR 6/9/2022 20:44:05'!
authenticate: aClientID with: aPassword
	
	(self assert: aClientID isRegisteredWith: aPassword) ifFalse:  [self error: XXXAuthenticator invalidCredentialsErrorDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXAuthenticator class' category: 'TusLibros'!
XXXAuthenticator class
	instanceVariableNames: ''!

!XXXAuthenticator class methodsFor: 'error descriptions' stamp: 'JDR 6/9/2022 20:08:06'!
invalidCredentialsErrorDescription
	
	^'invalid ID or password'! !


!XXXAuthenticator class methodsFor: 'instance creation' stamp: 'JDR 6/9/2022 20:19:14'!
with: aUserRegister

	^self new initializeWith: aUserRegister ! !
