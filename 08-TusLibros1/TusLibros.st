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


!CartTest methodsFor: 'utils' stamp: 'JDR 6/2/2022 20:58:29'!
book

	^1! !

!CartTest methodsFor: 'utils' stamp: 'AF 6/4/2022 11:24:32'!
catalog
	^Set with: self book! !


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


!Cart methodsFor: 'adding' stamp: 'JDR 6/3/2022 03:59:33'!
add: aBook amount: anAmount 
	
	self assertPositiveAmount: anAmount.
	self assertBookIncludedInCatalog: aBook.
	content add: aBook withOccurrences: anAmount! !


!Cart methodsFor: 'initialization' stamp: 'AF 6/4/2022 11:23:58'!
initializeWith: aCatalog 
	
	catalog := aCatalog.
	content _ Bag new.! !


!Cart methodsFor: 'assertions' stamp: 'JDR 6/3/2022 03:53:56'!
assertBookIncludedInCatalog: aBook

	^ (catalog includes: aBook) ifFalse: [ self error: Cart cannotAddBooksNotInCatalogErrorDescription ]! !

!Cart methodsFor: 'assertions' stamp: 'JDR 6/3/2022 03:59:33'!
assertPositiveAmount: anAmount

	^ anAmount strictlyPositive ifFalse: [ self error: Cart invalidBookAmountErrorDescription ]! !

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
