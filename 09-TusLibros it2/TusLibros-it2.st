!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test - accesing' stamp: 'AF 6/4/2022 11:21:56'!
test01ANewCartShouldBeEmpty

	| cart |
	cart _ Cart with: self catalog.
	
	self assert: cart isEmpty! !

!CartTest methodsFor: 'test - accesing' stamp: 'AF 6/4/2022 11:25:52'!
test06CanConsultCartContents

	| cart book expectedCartContent |
	cart _ Cart with: self catalog.
	book _ self book.
	
	cart add: book amount: 1.
	expectedCartContent _ Bag with: book.
	
	self assert: expectedCartContent equals: cart content
	
	
	
					
	

	

	! !

!CartTest methodsFor: 'test - accesing' stamp: 'JDR 6/8/2022 04:27:23'!
test08CanConsultCartTotalPrice
	
	| cart bookPrice |
	cart _ Cart with: self catalog.
	cart add: self book amount: 3.
	
	bookPrice _ self catalog at: self book.
	
	self assert: 3 * bookPrice equals: cart subtotal.

	! !


!CartTest methodsFor: 'test - adding' stamp: 'AF 6/4/2022 11:46:39'!
test02ACartShouldNotBeEmptyAfterAddingBookToCart

	| cart book |
	cart _ Cart with: self catalog.
	book _ self book.
	
	cart add: book amount: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'test - adding' stamp: 'AF 6/4/2022 11:24:47'!
test03CanAddToCartAnAmountOfACertainBook

	| cart book amount |
	cart _ Cart with: self catalog.
	book _ self book.
	amount _ 3.
	
	cart add: book amount: amount.
	
	self assert: amount equals: (cart occurrencesOf: book)
	
	
	
					
	

	

	! !


!CartTest methodsFor: 'test - exceptions' stamp: 'AF 6/4/2022 11:24:55'!
test04OnlyCanAddToCartBooksInCatalog

	| cart unregisteredBook |
	cart _ Cart with: self catalog.
	unregisteredBook _ 0.				
	
	self 
		should: [ cart add: unregisteredBook amount: 1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart cannotAddBooksNotInCatalogErrorDescription.
			self assert: cart isEmpty.
		]
	

	! !

!CartTest methodsFor: 'test - exceptions' stamp: 'AF 6/4/2022 11:25:31'!
test05OnlyCanAddToCartAPositiveAmountOfABook

	| cart book invalidAmount |
	cart _ Cart with: self catalog.
	book _ self book.			
	invalidAmount _ 0.
	
	self 
		should: [ cart add: book amount: invalidAmount ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidBookAmountErrorDescription .
			self assert: cart isEmpty.
		]
	

	! !

!CartTest methodsFor: 'test - exceptions' stamp: 'JDR 6/6/2022 17:37:38'!
test07OnlyCanAddToCartAnIntegerAmountOfABook

	| cart book invalidAmount |
	cart _ Cart with: self catalog.
	book _ self book.			
	invalidAmount _ 1.1.
	
	self 
		should: [ cart add: book amount: invalidAmount ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidBookAmountErrorDescription .
			self assert: cart isEmpty.
		]
	

	! !


!CartTest methodsFor: 'utils' stamp: 'JDR 6/2/2022 20:58:29'!
book

	^1! !

!CartTest methodsFor: 'utils' stamp: 'JDR 6/6/2022 19:17:17'!
catalog
	
	| catalog |
	catalog _ Dictionary new.
	catalog at: self book put: 100.
	^catalog! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 04:09:02'!
test01CheckoutOfAnEmptyCartShouldRaiseAnError

	| cart cashier xxx |
	xxx _ XXX new.
	cart _ Cart with: xxx catalog.
	cashier _ Cashier new.
	
	self should: [cashier checkout: cart with: xxx validCreditCard on: xxx validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: Cashier cannotCheckoutEmptyCartErrorDescription equals: anError messageText].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 04:08:53'!
test02CheckoutOfACartWithOneBookShouldMatchBookPrice
	
	| cart cashier xxx |
	xxx _ XXX new.
	cart _ Cart with: xxx catalog.
	cart add: xxx book amount: 1.
	cashier _ Cashier new.
		
	self assert: 100 equals: (cashier checkout: cart with: xxx validCreditCard on: xxx validCheckoutMonthOfYear ).
	self assert: cart isEmpty.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 04:08:23'!
test03CheckoutOfACartEqualsCartSubtotal
	
	| cart cashier expectedPrice xxx |
	
	xxx _ XXX new.
	cart _ Cart with: xxx catalog.
	cashier _ Cashier new.	
	
	cart add: xxx book amount: 3.
	cart add: xxx book2 amount: 1.
		
	expectedPrice _ 350.
	
	self assert: expectedPrice equals: (cashier checkout: cart with: xxx validCreditCard on: xxx validCheckoutMonthOfYear).
	self assert: cart isEmpty.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 04:07:31'!
test04CheckoutWithAnExpiredCardShouldRaiseAnError
	
	| cart cashier xxx |
	xxx _ XXX new.
	cart _ Cart with: xxx catalog.
	cashier _ Cashier new.
	
	cart add: xxx book amount: 1.

	self should: [ cashier checkout: cart with: xxx expiredCreditCard on: xxx validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cashier expiredCardErrorDescription equals: anError messageText .
			self deny: cart isEmpty.
		]! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:44:40'!
test01CreditCardNumberMustBeLength16	
	
	| xxx |
	xxx _ XXX new.
	
	self should: [CreditCard ownedBy: xxx validCardName with: xxx invalidCardNumber expiratingOn: xxx validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CreditCard invalidCardNumberErrorDescription equals: anError messageText ]. ! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:45:19'!
test02CreditCardNameMustBeAValidName
	
	| xxx |
	xxx _ XXX new.
	
	self should: [CreditCard ownedBy: xxx invalidCardName with: xxx validCardNumber expiratingOn: xxx validCheckoutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CreditCard invalidNameErrorDescription equals: anError messageText ]. ! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:55:44'!
test03CreditCardDateMustBeAMonthOfYear
	
	| xxx |
	xxx _ XXX new.
	
	self should: [CreditCard ownedBy: xxx validCardName with: xxx validCardNumber expiratingOn: xxx invalidExpirationDate] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CreditCard invalidExpirationDateErrorDescription equals: anError messageText ]. ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accesing' stamp: 'JDR 6/3/2022 03:37:46'!
content
	
	^content copy! !

!Cart methodsFor: 'accesing' stamp: 'JDR 6/2/2022 20:54:21'!
isEmpty
	
	^content isEmpty! !

!Cart methodsFor: 'accesing' stamp: 'AF 6/4/2022 11:19:41'!
occurrencesOf: aBook

	^ content occurrencesOf: aBook.! !


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


!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 19:23:56'!
clearContent

	content _ Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 19:30:55'!
subtotal
	
	^content sum: [ :aBook | (catalog at: aBook)].
! !

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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:41:14'!
checkout: aCart with: aCreditCard on: aDate
	
	| subtotal |
	
	(aCart isEmpty) ifTrue:[self error: Cashier cannotCheckoutEmptyCartErrorDescription].
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: Cashier expiredCardErrorDescription]. 
	
	subtotal _ aCart subtotal.
	
	aCart clearContent.
	
	^subtotal! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'JDR 6/6/2022 21:25:27'!
cannotCheckoutEmptyCartErrorDescription
	
	^'cant checkout an empty cart'! !

!Cashier class methodsFor: 'instance creation' stamp: 'JDR 6/6/2022 20:23:39'!
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


!CreditCard methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:26:50'!
isExpiredOn: aMonthOfYear

	^expirationDate < aMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JDR 6/8/2022 04:20:50'!
ownedBy: aName with: aCardNumber expiratingOn: anExpirationMonthOfYear 

	((aName withoutSeparators) size between: 4 and: 30) ifFalse: [self error: CreditCard invalidNameErrorDescription ].	
	(aCardNumber size = 16) ifFalse: [self error: CreditCard invalidCardNumberErrorDescription].
	(anExpirationMonthOfYear isKindOf: GregorianMonthOfYear) ifFalse: [self error: CreditCard invalidExpirationDateErrorDescription ].	
	
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


!classDefinition: #XXX category: 'TusLibros'!
Object subclass: #XXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:37:06'!
book

	^1! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:37:19'!
book2

	^2! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:37:33'!
catalog
	
	| catalog |
	catalog _ Dictionary new.
	catalog at: self book put: 100.
	catalog at: self book2 put: 50.
	^catalog! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:41:37'!
expiredCreditCard
	
	^CreditCard ownedBy: self validCardName with: self validCardNumber expiratingOn: (July of: 2020)! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 04:18:21'!
invalidCardName

	^ ' Jaigsrepgepiosegaisdgoipoñjasdjkljjdhfjlljafnv'! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:42:27'!
invalidCardNumber
	^'1'! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:58:03'!
invalidExpirationDate
	
	^GregorianYear number: 2050! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:53:35'!
validCardName

	^'Juancito'! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:53:42'!
validCardNumber
	^'4444555566667777'. ! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:42:47'!
validCheckoutMonthOfYear
	^July of: 2022. ! !

!XXX methodsFor: 'as yet unclassified' stamp: 'JDR 6/8/2022 03:42:47'!
validCreditCard
	
	^CreditCard ownedBy: self validCardName with: self validCardNumber 	expiratingOn: self validCheckoutMonthOfYear . ! !
