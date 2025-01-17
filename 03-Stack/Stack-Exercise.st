!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AF 4/26/2022 21:12:54'!
test01FindAPrefixInAnEmptyStackShouldReturnAnEmptyList

	| sentenceFinder stack |
	stack _ OOStack new.
	sentenceFinder _ SentenceFinderByPrefix with: stack.
	
	self assert: (OrderedCollection new) equals: (sentenceFinder find: 'melocoton').  
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AF 4/26/2022 21:15:09'!
test02FindASentenceInAStackWithSentenceShouldReturnAListWithThatSentence

	| sentenceFinder stack word1 expectedList |
	stack _ OOStack new.
	sentenceFinder _ SentenceFinderByPrefix with: stack.
	
	word1 _ 'Melocoton'.
	expectedList _ OrderedCollection with: word1.
	
	stack push: word1.
	
	self assert: expectedList equals: (sentenceFinder find: word1).  
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AF 4/26/2022 21:18:39'!
test03FindAPrefixInAStackShouldReturnAListWithSentencesThatBeginWithThatPrefix

	| sentenceFinder stack word1 expectedList word2 word3 |
	stack _ OOStack new.
	sentenceFinder _ SentenceFinderByPrefix with: stack.
	
	word1 _ 'melocoton'.
	word2 _ 'melodramatico'.
	word3 _ 'drama'.
	
	expectedList _ OrderedCollection with: word2 with: word1.
	
	stack push: word1.
	stack push: word2.
	stack push: word3.
	
	self assert: expectedList equals: (sentenceFinder find: 'melo').  
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AF 4/26/2022 21:20:07'!
test04FindAPrefixShouldKeepStackUnchanged

	| sentenceFinder stack word1 expectedList word2 word3 |
	stack _ OOStack new.
	sentenceFinder _ SentenceFinderByPrefix with: stack.
	
	word1 _ 'melocoton'.
	word2 _ 'melodramatico'.
	word3 _ 'drama'.
	
	
	expectedList _ OrderedCollection with: word2 with: word1.
	
	stack push: word1.
	stack push: word2.
	stack push: word3.
	
	self assert: expectedList equals: (sentenceFinder find: 'melo').  
	self assert: word3 equals: stack pop.
	self assert: word2 equals: stack pop.
	self assert: word1 equals: stack pop.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JDR 4/27/2022 21:11:36'!
test05FindAnEmptyPrefixShouldRaiseAnError

	| sentenceFinder stack word1 |
	stack _ OOStack new.
	sentenceFinder _ SentenceFinderByPrefix with: stack.
	
	word1 _ 'melocoton'.
	stack push: word1.
	
	self should: [sentenceFinder find: ''] 
	raise: Error
	description:[:anErrorDescription | self assert: anErrorDescription messageText equals: SentenceFinderByPrefix prefixCannotBeEmptyErrorDescription ].
	
	self assert: word1 equals: stack pop.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JDR 4/27/2022 21:05:55'!
test06FindAPrefixWithEmptySpacesShouldRaiseAnError

	| sentenceFinder stack word1 |
	stack _ OOStack new.
	sentenceFinder _ SentenceFinderByPrefix with: stack.
	
	word1 _ 'melocoton'.
	stack push: word1.
	
	self should: [sentenceFinder find: 'melo coton'] 
	raise: Error
	description:[:anErrorDescription | self assert: anErrorDescription messageText equals: SentenceFinderByPrefix prefixCannotHaveEmptySpacesErrorDescription ].
	
	self assert: word1 equals: stack pop.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JDR 4/27/2022 21:09:06'!
test07FindAPrefixInAnEmptyStackShouldKeepStackEmpty

	| sentenceFinder stack     |
	stack _ OOStack new.
	sentenceFinder _ SentenceFinderByPrefix with: stack.

	sentenceFinder find: 'melo'.
	
	self assert: stack isEmpty  
! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'contents state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'AF 4/25/2022 21:40:31'!
initialize
	
	state _ StackStateEmpty new.
	contents _ OrderedCollection new.! !


!OOStack methodsFor: 'adding' stamp: 'AF 4/25/2022 21:36:40'!
push: anElement
 
	contents add: anElement.! !


!OOStack methodsFor: 'accessing & removing' stamp: 'AF 4/25/2022 21:36:54'!
isEmpty
	^contents isEmpty ! !

!OOStack methodsFor: 'accessing & removing' stamp: 'AF 4/25/2022 21:37:38'!
pop
	| element |
	element _ self top.
	contents remove: element.
	^element.! !

!OOStack methodsFor: 'accessing & removing' stamp: 'AF 4/25/2022 21:39:38'!
size

	^contents size.! !

!OOStack methodsFor: 'accessing & removing' stamp: 'AF 4/26/2022 19:46:53'!
top
	
	state _ StackState with: self size.
	state assertStackIsNotEmpty.
	^contents last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'ooStack backupData'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'JDR 4/27/2022 20:45:28'!
initializeWith: anOOStack 
	
	ooStack _ anOOStack ! !


!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'JDR 4/27/2022 20:58:06'!
find: aPrefix

	| returnList|
	self assertPrefixIsNotEmpty: aPrefix.
	self assertPrefixHasNoEmptySpaces: aPrefix.
	
	backupData _ OOStack new.
	returnList _ self findSentencesStartingWith: aPrefix.
	self restoreStack.
	
	^returnList 
	
		! !


!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'JDR 4/27/2022 21:05:35'!
assertPrefixHasNoEmptySpaces: aPrefix
	
	(aPrefix includesSubString: ' ') ifTrue:[self error: SentenceFinderByPrefix prefixCannotHaveEmptySpacesErrorDescription].! !

!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'JDR 4/27/2022 21:03:22'!
assertPrefixIsNotEmpty: aPrefix
	
	aPrefix isEmpty ifTrue:[self error: SentenceFinderByPrefix prefixCannotBeEmptyErrorDescription].! !


!SentenceFinderByPrefix methodsFor: 'accessing - private' stamp: 'AF 4/26/2022 21:01:56'!
findSentencesStartingWith: aPrefix

	| returnList |

	returnList _ OrderedCollection new.
	
	[ooStack isEmpty] whileFalse: [ | currentSentence | 
		currentSentence _ ooStack pop.
		self if: currentSentence startsWith: aPrefix addItTo: returnList
	].

	^returnList.
	! !

!SentenceFinderByPrefix methodsFor: 'accessing - private' stamp: 'AF 4/26/2022 21:01:48'!
if: currentSentence startsWith: aPrefix addItTo: returnList

	backupData push: currentSentence.
		(currentSentence beginsWith: aPrefix) ifTrue:[ returnList add: currentSentence]! !


!SentenceFinderByPrefix methodsFor: 'restoring - private' stamp: 'AF 4/26/2022 20:46:26'!
restoreStack

	^ [backupData isEmpty] whileFalse: [ooStack push: backupData pop]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JDR 4/27/2022 21:03:22'!
prefixCannotBeEmptyErrorDescription
	^'A prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JDR 4/27/2022 21:03:12'!
prefixCannotHaveEmptySpacesErrorDescription
	^'A prefix cannot have empty spaces'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'JDR 4/27/2022 20:45:28'!
with: aOOStack

	^self new initializeWith: aOOStack ! !


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'assertions' stamp: 'AF 4/26/2022 19:47:15'!
assertStackIsNotEmpty

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackState class' category: 'Stack-Exercise'!
StackState class
	instanceVariableNames: ''!

!StackState class methodsFor: 'instance creation' stamp: 'AF 4/26/2022 19:35:37'!
canHandle: aStackSize
	
	self subclassResponsibility.! !

!StackState class methodsFor: 'instance creation' stamp: 'AF 4/26/2022 19:40:54'!
with: aStackSize

	| subclass |
	subclass _ self subclasses 
		detect:[:aSubclass | aSubclass canHandle: aStackSize ] 
		ifNone: [self error:'No hay ningun estado posible con ese size'].
	^subclass new.! !


!classDefinition: #StackStateEmpty category: 'Stack-Exercise'!
StackState subclass: #StackStateEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackStateEmpty methodsFor: 'assertions' stamp: 'AF 4/26/2022 19:46:52'!
assertStackIsNotEmpty
	
	self error: OOStack stackEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackStateEmpty class' category: 'Stack-Exercise'!
StackStateEmpty class
	instanceVariableNames: ''!

!StackStateEmpty class methodsFor: 'instance creation' stamp: 'AF 4/26/2022 19:34:03'!
canHandle: aStackSize

	^aStackSize = 0! !


!classDefinition: #StackStateNotEmpty category: 'Stack-Exercise'!
StackState subclass: #StackStateNotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackStateNotEmpty methodsFor: 'assertions' stamp: 'AF 4/26/2022 19:46:52'!
assertStackIsNotEmpty
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackStateNotEmpty class' category: 'Stack-Exercise'!
StackStateNotEmpty class
	instanceVariableNames: ''!

!StackStateNotEmpty class methodsFor: 'instance creation' stamp: 'AF 4/26/2022 19:34:46'!
canHandle: aStackSize

	^aStackSize > 0	! !
