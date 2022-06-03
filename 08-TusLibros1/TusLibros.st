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

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 21:32:05'!
test03OnlyCanAddToCartBooksInCatalog

	| cart book |
	cart _ Cart new.
	book _ 0.				
	
	self 
		should: [ cart add: book ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart cannotAddBooksNotInCatalog.
			self assert: cart isEmpty.
		]
	

	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 21:47:48'!
test04CanAddToCartAnAmountOfACertainBook

	| cart book amount |
	cart _ Cart new.
	book _ self book.
	amount _ 3.
	
	cart add: book amount: amount.
	
	self assert: cart content size = 3.
	self assert: cart content includes: book
	
	
	
					
	

	

	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 21:40:38'!
add: aBook 
	
	(catalog includes: aBook) ifFalse: [ self error: Cart cannotAddBooksNotInCatalog ].
	content add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 21:39:48'!
initialize

	content _ OrderedCollection new.
	catalog _ Set with: 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 20:54:21'!
isEmpty
	
	^content isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'JDR 6/2/2022 21:31:11'!
cannotAddBooksNotInCatalog

	^'Book is not edited by TusLibros.com'! !
