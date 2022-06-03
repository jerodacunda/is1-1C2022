!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 20:58:29'!
book

	^1! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 20:41:02'!
test01ANewCartShouldBeEmpty

	| cart |
	cart _ Cart new.
	
	self assert: cart isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 21:33:54'!
test02ACartShouldNotBeEmptyAfterAddingBookToCart

	| cart book |
	cart _ Cart new.
	book _ self book.
	
	cart add: book.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 04:04:09'!
test03CanAddToCartAnAmountOfACertainBook

	| cart book amount |
	cart _ Cart new.
	book _ self book.
	amount _ 3.
	
	cart add: book amount: amount.
	
	self assert: amount equals: (cart content occurrencesOf: book)
	
	
	
					
	

	

	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:53:56'!
test04OnlyCanAddToCartBooksInCatalog

	| cart unregisteredBook |
	cart _ Cart new.
	unregisteredBook _ 0.				
	
	self 
		should: [ cart add: unregisteredBook amount: 1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart cannotAddBooksNotInCatalogErrorDescription.
			self assert: cart isEmpty.
		]
	

	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:58:31'!
test05OnlyCanAddToCartAPositiveAmountOfABook

	| cart book invalidAmount |
	cart _ Cart new.
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

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:54:07'!
test06CanConsultCartContents

	| cart book expectedCartContent |
	cart _ Cart new.
	book _ self book.
	
	cart add: book amount: 1.
	expectedCartContent _ Bag with: book.
	
	self assert: expectedCartContent equals: cart content
	
	
	
					
	

	

	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:40:25'!
add: aBook 
	
	self assertBookIncludedInCatalog: aBook.
	content add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:59:33'!
add: aBook amount: anAmount 
	
	self assertPositiveAmount: anAmount.
	self assertBookIncludedInCatalog: aBook.
	content add: aBook withOccurrences: anAmount! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:53:56'!
assertBookIncludedInCatalog: aBook

	^ (catalog includes: aBook) ifFalse: [ self error: Cart cannotAddBooksNotInCatalogErrorDescription ]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:59:33'!
assertPositiveAmount: anAmount

	^ anAmount strictlyPositive ifFalse: [ self error: Cart invalidBookAmountErrorDescription ]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:37:46'!
content
	
	^content copy! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:25:11'!
initialize

	content _ Bag new.
	catalog _ Set with: 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 20:54:21'!
isEmpty
	
	^content isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:53:56'!
cannotAddBooksNotInCatalogErrorDescription

	^'Book is not edited by TusLibros.com'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'JDR 6/3/2022 03:57:03'!
invalidBookAmountErrorDescription

	^'Amount must be 1 or greater'! !
