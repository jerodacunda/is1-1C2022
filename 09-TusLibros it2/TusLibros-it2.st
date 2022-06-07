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

!CartTest methodsFor: 'test - exceptions' stamp: 'JDR 6/6/2022 19:15:21'!
test08
	
	| cart bookPrice |
	cart _ Cart with: self catalog.
	cart add: self book amount: 1.
	
	bookPrice _ self catalog at: self book.
	
	self assert: bookPrice equals: cart subtotal.

	! !

!CartTest methodsFor: 'test - exceptions' stamp: 'JDR 6/6/2022 19:23:14'!
test09
	
	| cart bookPrice |
	cart _ Cart with: self catalog.
	cart add: self book amount: 3.
	
	bookPrice _ self catalog at: self book.
	
	self assert: 3 * bookPrice equals: cart subtotal.

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

!CashierTest methodsFor: 'utils' stamp: 'JDR 6/6/2022 18:52:25'!
book

	^1! !

!CashierTest methodsFor: 'utils' stamp: 'JDR 6/6/2022 19:35:05'!
book2

	^2! !

!CashierTest methodsFor: 'utils' stamp: 'JDR 6/6/2022 19:35:56'!
catalog
	
	| catalog |
	catalog _ Dictionary new.
	catalog at: self book put: 100.
	catalog at: self book2 put: 50.
	^catalog! !

!CashierTest methodsFor: 'utils' stamp: 'JDR 6/6/2022 20:38:59'!
expiredCreditCard
	
	^CreditCard with: '1111222233334444' expiratingOn: (July of: 2020)! !

!CashierTest methodsFor: 'utils' stamp: 'JDR 6/6/2022 21:43:29'!
validCheckOutMonthOfYear
	^July of: 2022. ! !

!CashierTest methodsFor: 'utils' stamp: 'JDR 6/6/2022 20:38:39'!
validCreditCard
	^CreditCard with: '4444555566667777' 	expiratingOn: (July of: 2024). ! !


!CashierTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:44:29'!
test01CheckoutOfAnEmptyCartShouldRaiseAnError

	| cart cashier |
	cart _ Cart with: self catalog.
	cashier _ Cashier new.
	
	self should: [cashier checkout: cart with: self validCreditCard on: self validCheckOutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: Cashier cannotCheckoutEmptyCartErrorDescription equals: anError messageText].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:44:20'!
test02ChekoutOfACartWithOneBookShouldBeBookPrice
	
	| cart cashier |
	cart _ Cart with: self catalog.
	cart add: self book amount: 1.
	cashier _ Cashier new.
	
	self assert: 100 equals: (cashier checkout: cart with: self validCreditCard on: self validCheckOutMonthOfYear ).
	self assert: cart isEmpty.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:44:01'!
test03CheckoutOfACartEqualsCartSubtotal
	
	| cart cashier expectedPrice |
	cart _ Cart with: self catalog.
	cashier _ Cashier new.
	
	cart add: self book amount: 3.
	cart add: self book2 amount: 1.
		
	expectedPrice _ 350.
	
	self assert: expectedPrice equals: (cashier checkout: cart with: self validCreditCard on: self validCheckOutMonthOfYear).
	self assert: cart isEmpty.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:45:06'!
test04CheckoutWithAnExpiredCardShouldRaiseAnError
	
	| cart cashier |
	cart _ Cart with: self catalog.
	cashier _ Cashier new.
	
	cart add: self book amount: 1.

	self should: [ cashier checkout: cart with: self expiredCreditCard on: self validCheckOutMonthOfYear] 
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

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:50:15'!
invalidCreditCardNumber
	^'1'! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:52:31'!
test01	
	
	self should: [CreditCard ownedBy: self validCardName with: self invalidCreditCardNumber expiratingOn: self validCheckOutMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: CreditCard invalidCardNumberErrorDescription equals: anError messageText ]. ! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:51:21'!
validCheckOutMonthOfYear
	^July of: 2022. ! !


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

!Cashier methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:27:22'!
checkout: aCart with: aCreditCard 
	
	| subtotal currentDate |
	
	(aCart isEmpty) ifTrue:[self error: Cashier cannotCheckoutEmptyCartErrorDescription].
	
	currentDate _ GregorianMonthOfYear current .
	(aCreditCard isExpiredOn: currentDate) ifTrue: [self error: Cashier expiredCardErrorDescription]. 
	
	subtotal _ aCart subtotal.
	
	aCart clearContent.
	
	^subtotal! !

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
	instanceVariableNames: 'cardNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'JDR 6/6/2022 20:05:31'!
initializeWith: aCardNumber expiratingOn: aExpirationDate 
	
	cardNumber := aCardNumber.
	expirationDate := aExpirationDate.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'JDR 6/6/2022 21:26:50'!
isExpiredOn: aMonthOfYear

	^expirationDate < aMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JDR 6/6/2022 21:53:49'!
ownedBy: aName with: aCardNumber expiratingOn: aExpirationMonthOfYear 
	
	(aCardNumber size = 16) ifFalse: [self error: CreditCard invalidCardNumberErrorDescription].
	
	^self new initializeWith: aCardNumber expiratingOn: aExpirationMonthOfYear ! !

!CreditCard class methodsFor: 'instance creation' stamp: 'JDR 6/6/2022 20:06:05'!
with: aCardNumber expiratingOn: aExpirationMonthOfYear 
	
	(aCardNumber size = 16) ifFalse: [self error: CreditCard invalidCardNumberErrorDescription].
	
	^self new initializeWith: aCardNumber expiratingOn: aExpirationMonthOfYear ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'JDR 6/6/2022 19:55:38'!
invalidCardNumberErrorDescription
	^ 'the credit card number must be 16'! !
