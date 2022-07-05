!classDefinition: #LaddersAndSlidesGameTest category: 'parcial2021-1c'!
TestCase subclass: #LaddersAndSlidesGameTest
	instanceVariableNames: 'collectionOfPlayers startingPoint numberFlorToStart endingPoint numberFlorToEnd listOfSizeingFlors dice ladders slides'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial2021-1c'!

!LaddersAndSlidesGameTest methodsFor: 'testing - is on in' stamp: 'Af 7/4/2022 21:42:46'!
test01aPlayerStartsWhereItHaveToStart

	| aFloorNumber game |
	game _ LaddersAndSlidesGame players: collectionOfPlayers stating: startingPoint in: numberFlorToStart ending: endingPoint in: numberFlorToEnd withFlors: listOfSizeingFlors rollingWith: dice raisingWith: ladders fallingWith: slides.
	aFloorNumber _ 1.
	
	
	self assert: (game is: #player1 on: startingPoint in: aFloorNumber)  ! !

!LaddersAndSlidesGameTest methodsFor: 'testing - is on in' stamp: 'Af 7/4/2022 21:43:23'!
test02MultiplePlayersStartWereTheyShouldStart

	| aCollectionOfPlayers aDice aEndingPoint aFloorNumber aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 1@1.
	aNumberFlorToStart _ 1.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ nil.
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	aFloorNumber _ 1.
	
	
	self deny: (game is: #player2 on: aStartingPoint + (1@1) in: aFloorNumber)  ! !

!LaddersAndSlidesGameTest methodsFor: 'testing - is on in' stamp: 'Af 7/4/2022 21:44:13'!
test04cantCheckThePositionOfAnInexistentPlayer

	| aCollectionOfPlayers aDice aEndingPoint aFloorNumber aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 1@1.
	aNumberFlorToStart _ 1.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ nil.
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	aFloorNumber _ 2.
	
	
	self should: [game is: #invalidPlayer on: aStartingPoint in: aFloorNumber] 
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlidesGame thatPlayerDosentExistErrordescription. 
	! !


!LaddersAndSlidesGameTest methodsFor: 'testing - turns' stamp: 'Af 7/4/2022 21:50:58'!
test12SecondPlayerOnListCantPlayFirst

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 20@20.
	aNumberFlorToStart _ 2.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	
	self should: [game play: aCollectionOfPlayers second]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlidesGame notThatPlayerTurnErrorDescription.
	
	! !

!LaddersAndSlidesGameTest methodsFor: 'testing - turns' stamp: 'Af 7/4/2022 21:53:06'!
test13FirstPLayerOnListcanPlayTwiceInARow

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 20@20.
	aNumberFlorToStart _ 2.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	game play: aCollectionOfPlayers first.
	
	self should: [game play: aCollectionOfPlayers first.]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlidesGame notThatPlayerTurnErrorDescription.
	
	! !

!LaddersAndSlidesGameTest methodsFor: 'testing - turns' stamp: 'Af 7/4/2022 21:54:00'!
test14PlayingTheRoundOfTurnsGoAllTheWayDown

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 20@20.
	aNumberFlorToStart _ 2.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	game play: aCollectionOfPlayers first.
	game play: aCollectionOfPlayers second.
	
	self should: [game play: aCollectionOfPlayers second.]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlidesGame notThatPlayerTurnErrorDescription.
	
	! !


!LaddersAndSlidesGameTest methodsFor: 'testing - ladder and slides' stamp: 'Af 7/4/2022 21:54:51'!
test15PlayerEndsInBegginingOfLadderGoesAllTheWayUP

	| game ladder endingLadderPoint |
	
	endingLadderPoint _ 3@3.
	ladder _ XXXLadder departsFrom: 2@2 in: 1 goingTo: endingLadderPoint  in: 2.
	ladders add: ladder.
	
	startingPoint _ 1@1.
	numberFlorToStart _ 1.
	endingPoint _ 10@10.
	numberFlorToEnd _ 1.
	
	dice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: collectionOfPlayers stating: startingPoint in: numberFlorToStart ending: endingPoint in: numberFlorToEnd withFlors: listOfSizeingFlors rollingWith: dice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on: endingLadderPoint in: 2). ! !

!LaddersAndSlidesGameTest methodsFor: 'testing - ladder and slides' stamp: 'Af 7/4/2022 21:55:32'!
test17GameSupporsMultipleLadders

	| game ladder1 ladder2 |
	
	
	ladder1 _ XXXLadder departsFrom: 2@2 in: 2 goingTo: 2@6  in: 3.
	ladder2 _ XXXLadder departsFrom: 4@4 in: 1 goingTo: 5@5  in: 2.
	listOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20} with: {30. 30}.
	
	ladders add: ladder1.
	ladders add: ladder2.
	
	startingPoint _ 3@3.
	numberFlorToStart _ 1.
	endingPoint _ 10@10.
	numberFlorToEnd _ 1.
	
	dice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: collectionOfPlayers stating: startingPoint in: numberFlorToStart ending: endingPoint in: numberFlorToEnd withFlors: listOfSizeingFlors rollingWith: dice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on: 5@5 in: 2). ! !

!LaddersAndSlidesGameTest methodsFor: 'testing - ladder and slides' stamp: 'Af 7/4/2022 21:55:49'!
test18CantCreateLadderThatGoesDown

	self should: [	XXXLadder departsFrom: 2@2 in: 2 goingTo: 4@4  in: 1] 
		raise: Error - MessageNotUnderstood 
		withMessageText: XXXLadder cantCreateALadderThatDoesNotGoesUpErrorDescription.
	! !

!LaddersAndSlidesGameTest methodsFor: 'testing - ladder and slides' stamp: 'Af 7/4/2022 21:56:04'!
test19CantCreateLadderThatGoesToTheSameFloor

	self should: [	XXXLadder departsFrom: 2@2 in: 2 goingTo: 4@4  in: 2] 
		raise: Error - MessageNotUnderstood 
		withMessageText: XXXLadder cantCreateALadderThatDoesNotGoesUpErrorDescription.
	! !

!LaddersAndSlidesGameTest methodsFor: 'testing - ladder and slides' stamp: 'Af 7/4/2022 21:56:36'!
test20PlayerEndsInBegginingOfSlideGoesAllTheWayDown

	| game slide |
	
	
	slide _ XXXSlide departsFrom: 4@4 in: 2 goingTo: 2@6  in: 1.
	
	listOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20} with: {30. 30}.
	
	slides add: slide.
	
	startingPoint _ 3@3.
	numberFlorToStart _ 2.
	endingPoint _ 10@10.
	numberFlorToEnd _ 1.
	
	dice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: collectionOfPlayers stating: startingPoint in: numberFlorToStart ending: endingPoint in: numberFlorToEnd withFlors: listOfSizeingFlors rollingWith: dice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on:  2@6 in: 1). ! !

!LaddersAndSlidesGameTest methodsFor: 'testing - ladder and slides' stamp: 'Af 7/4/2022 21:57:15'!
test21CantSlideCantGoUp

	self should: [	XXXSlide departsFrom: 2@2 in: 1 goingTo: 4@4  in: 2] 
		raise: Error - MessageNotUnderstood 
		withMessageText: XXXSlide cantCreateASlidesThatDoesNotGoesDownErrorDescription.
	! !

!LaddersAndSlidesGameTest methodsFor: 'testing - ladder and slides' stamp: 'Af 7/4/2022 21:57:09'!
test22CantCreateASlideThatGoesToTheSameFloor

	self should: [	XXXSlide departsFrom: 2@2 in: 1 goingTo: 4@4  in: 1] 
		raise: Error - MessageNotUnderstood 
		withMessageText: XXXSlide cantCreateASlidesThatDoesNotGoesDownErrorDescription.
	! !


!LaddersAndSlidesGameTest methodsFor: 'setUp' stamp: 'Af 7/4/2022 20:35:50'!
setUp

	collectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	startingPoint _ 1@1.
	numberFlorToStart _ 1.
	endingPoint _ 10@10.
	numberFlorToEnd _ 1.
	listOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	dice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	ladders _ OrderedCollection new.
	slides _ OrderedCollection new.
	
	
	! !


!LaddersAndSlidesGameTest methodsFor: 'testing - movement' stamp: 'Af 7/4/2022 21:45:54'!
test05PlayingAndGettingSixtySixFromDiceLeavesPlayerInItsPlace

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 1@1.
	aNumberFlorToStart _ 1.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(6 6) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on: 1@1 in: 1)! !

!LaddersAndSlidesGameTest methodsFor: 'testing - movement' stamp: 'Af 7/4/2022 21:46:13'!
test06PlayingMovesPlayer

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 1@1.
	aNumberFlorToStart _ 1.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on: 2@2 in: 1)! !

!LaddersAndSlidesGameTest methodsFor: 'testing - movement' stamp: 'Af 7/4/2022 21:48:33'!
test07PlayingMovingBackwardsOnXTrunckatesOnEdgeOfFloor

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 1@1.
	aNumberFlorToStart _ 1.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(5 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on: 1@2 in: 1)! !

!LaddersAndSlidesGameTest methodsFor: 'testing - movement' stamp: 'Af 7/4/2022 21:48:26'!
test08PlayingMovinFowardOnXTrunckatesOnEdgeOfFloor

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 10@5.
	aNumberFlorToStart _ 1.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on: 10@6 in: 1)! !

!LaddersAndSlidesGameTest methodsFor: 'testing - movement' stamp: 'Af 7/4/2022 21:49:11'!
test09PlayingMovingFowardOnYTrunckatesOnEdgeOfFloor

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 10@1.
	aNumberFlorToStart _ 1.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(7 5) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on: 10@1 in: 1)! !

!LaddersAndSlidesGameTest methodsFor: 'testing - movement' stamp: 'Af 7/4/2022 21:49:50'!
test11PlatingMovingTrunckatesOnMultipleFloors

	| aCollectionOfPlayers aDice aEndingPoint aListOfSizeingFlors aNumberFlorToEnd aNumberFlorToStart aStartingPoint game |
	aCollectionOfPlayers  _ OrderedCollection with: #player1 with: #player2.
	aStartingPoint _ 20@20.
	aNumberFlorToStart _ 2.
	aEndingPoint _ 10@10.
	aNumberFlorToEnd _ 1.
	aListOfSizeingFlors _ OrderedCollection with: {10. 10} with: {20. 20}.
	aDice _ SimulatedDice with: (CircularReadStream on: #(7 7) moving: NullUnit new).
	
	game _ LaddersAndSlidesGame players: aCollectionOfPlayers stating: aStartingPoint in: aNumberFlorToStart ending: aEndingPoint in: aNumberFlorToEnd withFlors: aListOfSizeingFlors rollingWith: aDice raisingWith: ladders fallingWith: slides.
	
	game play: #player1.
	
	self assert: (game is: #player1 on: 20@20 in: 2)! !


!classDefinition: #LaddersAndSlidesGame category: 'parcial2021-1c'!
Object subclass: #LaddersAndSlidesGame
	instanceVariableNames: 'listOfPlayers startingPoint florToStart endingPoint florToEnd floorSizes dice playerPositions turn listOfLadders listOfSlides'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial2021-1c'!

!LaddersAndSlidesGame methodsFor: 'initialization' stamp: 'Af 7/4/2022 21:57:34'!
initializePlayers: aListOfPlayers stating: aStartingPoint in: aFlorToStart ending: aEndingPoint in: aFlorToEnd withFlors: aFloorSizes rollingWith: aDice raisingWith: aListOfLadders fallingWith: aListOfSlides   
	
	listOfPlayers := aListOfPlayers.
	
	
	playerPositions _ OrderedCollection new.
	
	listOfPlayers do:[:aPlayer | playerPositions add: (PlayerPosition add: aPlayer on: aStartingPoint in: aFlorToStart floorsWith: aFloorSizes) ].
	turn _ 1.
	
	endingPoint := aEndingPoint.
	florToEnd := aFlorToEnd.
	floorSizes := aFloorSizes.
	dice := aDice.
	
	listOfLadders _ aListOfLadders .
	listOfSlides _ aListOfSlides.
	
	! !


!LaddersAndSlidesGame methodsFor: 'testing' stamp: 'Af 7/4/2022 21:11:56'!
is: aPlayer on: aPosition in: aFloorNumber 
	| tile |
	
	tile _ playerPositions detect: [ :aSquare | aSquare doYouHave: aPlayer] ifNone:[self error: self class thatPlayerDosentExistErrordescription] .
	
	
	^ (tile isInFloor: aFloorNumber) and: [tile isInPosition: aPosition]! !


!LaddersAndSlidesGame methodsFor: 'accesing - private' stamp: 'Af 7/4/2022 20:03:55'!
advanceTurn

	turn _ (turn + 1).
	(turn > 	listOfPlayers size) ifTrue:[turn _ 1]! !

!LaddersAndSlidesGame methodsFor: 'accesing - private' stamp: 'Af 7/4/2022 20:02:45'!
getMovement
	^ dice throw - 6.
	! !


!LaddersAndSlidesGame methodsFor: 'playing' stamp: 'Af 7/4/2022 21:29:31'!
play: aPlayer 
	
	| xMotion yMotion playerPosition |
	
	((listOfPlayers at: turn) = aPlayer) ifFalse:[self error: self class notThatPlayerTurnErrorDescription ].
	
	xMotion _ self getMovement.
	yMotion _ self getMovement.
	
	playerPosition _ playerPositions detect: [ :aSquare | aSquare doYouHave: aPlayer].
	
	playerPosition moveInX: xMotion andInY: yMotion.
	
	listOfLadders do: [:aLadder | aLadder aPlayerJustMovedOn: playerPosition.].
	listOfSlides do: [:aLadder | aLadder aPlayerJustMovedOn: playerPosition.].
	
	self advanceTurn.
	
	
	
	

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LaddersAndSlidesGame class' category: 'parcial2021-1c'!
LaddersAndSlidesGame class
	instanceVariableNames: ''!

!LaddersAndSlidesGame class methodsFor: 'instance creation' stamp: 'Af 7/4/2022 20:40:14'!
players: aListOfPlayers stating: aStartingPoint in: aFlorToStart ending: aEndingPoint in: aFlorToEnd withFlors: aSizeOfFlors rollingWith: aDice raisingWith: aListOfLadders fallingWith: aListOfSlides   
	
	
	^self new initializePlayers: aListOfPlayers stating: aStartingPoint in: aFlorToStart ending: aEndingPoint in: aFlorToEnd withFlors: aSizeOfFlors rollingWith: aDice raisingWith: aListOfLadders fallingWith: aListOfSlides ! !


!LaddersAndSlidesGame class methodsFor: 'error descritpions' stamp: 'Af 7/4/2022 19:51:28'!
notThatPlayerTurnErrorDescription
	
	^ 'is not that player turn'! !

!LaddersAndSlidesGame class methodsFor: 'error descritpions' stamp: 'Af 7/4/2022 18:09:54'!
thatPlayerDosentExistErrordescription
	
	^'invalid player'! !


!classDefinition: #PlayerPosition category: 'parcial2021-1c'!
Object subclass: #PlayerPosition
	instanceVariableNames: 'player position floorNumber floorSizes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial2021-1c'!

!PlayerPosition methodsFor: 'initialization' stamp: 'Af 7/4/2022 20:18:28'!
initializeAdd: aPlayer on: aPoint in: aFloorNumber floorsWith: aFloorSizes  

	player := aPlayer.
	position := aPoint.
	floorNumber := aFloorNumber.
	floorSizes _ aFloorSizes.! !


!PlayerPosition methodsFor: 'testing' stamp: 'Af 7/4/2022 18:54:33'!
doYouHave: aSymbol 
	^ player = aSymbol.! !

!PlayerPosition methodsFor: 'testing' stamp: 'Af 7/4/2022 18:55:18'!
isInFloor: aFloorNumber 
	
	^floorNumber = aFloorNumber ! !

!PlayerPosition methodsFor: 'testing' stamp: 'Af 7/4/2022 18:56:01'!
isInPosition: aPosition 
	^position = aPosition ! !


!PlayerPosition methodsFor: 'moving' stamp: 'Af 7/4/2022 20:19:34'!
correct: aPointToMove

	| newPoint playerFloor |
	newPoint _ aPointToMove copy.

	(newPoint x < 1) ifTrue:[ newPoint _ 1@newPoint y ].
	(newPoint y < 1) ifTrue:[ newPoint _ (newPoint x)@1].
	
	playerFloor _ (floorSizes at: floorNumber).
	
	(playerFloor first < newPoint x) ifTrue:[newPoint _ (playerFloor first )@newPoint y].
	(playerFloor second < newPoint y) ifTrue:[newPoint _ (newPoint x )@playerFloor second].
	
	^newPoint
	! !

!PlayerPosition methodsFor: 'moving' stamp: 'Af 7/4/2022 21:35:54'!
goTo: aEndingLadderPositon on: aEndingLadderFloor 

	position _ aEndingLadderPositon .
	floorNumber _ aEndingLadderFloor .! !

!PlayerPosition methodsFor: 'moving' stamp: 'Af 7/4/2022 20:23:41'!
moveInX: xMotion andInY: yMotion

	| newPoint |
	newPoint _ position + (xMotion@yMotion).
	position  _ self correct: newPoint.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerPosition class' category: 'parcial2021-1c'!
PlayerPosition class
	instanceVariableNames: ''!

!PlayerPosition class methodsFor: 'instance creation' stamp: 'Af 7/4/2022 20:11:24'!
add: aPlayer on: aPoint in: aFloorNumber floorsWith: aFloorSizes  
	
	^self new initializeAdd: aPlayer on: aPoint in: aFloorNumber floorsWith: aFloorSizes.! !


!classDefinition: #Shortcut category: 'parcial2021-1c'!
Object subclass: #Shortcut
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial2021-1c'!

!Shortcut methodsFor: 'goin thru' stamp: 'Af 7/4/2022 22:00:58'!
aPlayerJustMovedOn: aPlayerPosition 

	self subclassResponsibility ! !


!Shortcut methodsFor: 'initialization' stamp: 'Af 7/4/2022 22:01:12'!
initializeDepartsFrom: aDeparturePosition in: aDepartureFloor goingTo: aDestinationPostion in: aDestiantionFloor 
	
	self subclassResponsibility.! !


!classDefinition: #XXXLadder category: 'parcial2021-1c'!
Shortcut subclass: #XXXLadder
	instanceVariableNames: 'departurePosition departureFloor destinationPostion destiantionFloor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial2021-1c'!

!XXXLadder methodsFor: 'going up' stamp: 'Af 7/4/2022 21:39:02'!
aPlayerJustMovedOn: aPlayerPosition 
	
	((aPlayerPosition isInFloor: departureFloor) and: [aPlayerPosition isInPosition: departurePosition ]) ifTrue: [aPlayerPosition goTo: destinationPostion on: destiantionFloor ]! !


!XXXLadder methodsFor: 'initialization' stamp: 'Af 7/4/2022 21:10:55'!
initializeDepartsFrom: aDeparturePosition in: aDepartureFloor goingTo: aDestinationPostion in: aDestiantionFloor 
	
	departurePosition := aDeparturePosition.
	departureFloor := aDepartureFloor.
	destinationPostion := aDestinationPostion.
	destiantionFloor := aDestiantionFloor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXLadder class' category: 'parcial2021-1c'!
XXXLadder class
	instanceVariableNames: ''!

!XXXLadder class methodsFor: 'instance creation' stamp: 'Af 7/4/2022 21:32:33'!
cantCreateALadderThatDoesNotGoesUpErrorDescription
	
	^'a ladder can only go up'! !

!XXXLadder class methodsFor: 'instance creation' stamp: 'Af 7/4/2022 21:35:09'!
departsFrom: aDeparturePosition in: aDepartureFloor goingTo: aDestinationPostion in: aDestiantionFloor 
	
	(aDepartureFloor >= aDestiantionFloor) ifTrue: [self error: (self cantCreateALadderThatDoesNotGoesUpErrorDescription)].
	
	^self new initializeDepartsFrom: aDeparturePosition in: aDepartureFloor goingTo: aDestinationPostion in: aDestiantionFloor ! !



!classDefinition: #XXXSlide category: 'parcial2021-1c'!
Shortcut subclass: #XXXSlide
	instanceVariableNames: 'departurePosition departureFloor destinationPostion destinationFloor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial2021-1c'!

!XXXSlide methodsFor: 'initialization' stamp: 'Af 7/4/2022 21:38:52'!
aPlayerJustMovedOn: aPlayerPosition 
	
	((aPlayerPosition isInFloor: departureFloor) and: [aPlayerPosition isInPosition: departurePosition ]) ifTrue: [aPlayerPosition goTo: destinationPostion on: destinationFloor ]! !


!XXXSlide methodsFor: 'falling' stamp: 'Af 7/4/2022 21:28:10'!
initializeDepartsFrom: aDeparturePosition in: aDepartureFloor goingTo: aDestinationPostion in: aDestinationFloor 
	departurePosition := aDeparturePosition.
	departureFloor := aDepartureFloor.
	destinationPostion := aDestinationPostion.
	destinationFloor := aDestinationFloor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXSlide class' category: 'parcial2021-1c'!
XXXSlide class
	instanceVariableNames: ''!

!XXXSlide class methodsFor: 'instance creation' stamp: 'Af 7/4/2022 21:41:20'!
departsFrom: aDeparturePosition in: aDepartureFloor goingTo: aDestinationPostion in: aDestinationFloor 
	
	
	(aDepartureFloor <= aDestinationFloor) ifTrue: [self error: (self cantCreateASlidesThatDoesNotGoesDownErrorDescription )].
	
	^self new initializeDepartsFrom: aDeparturePosition in: aDepartureFloor goingTo: aDestinationPostion in: aDestinationFloor ! !


!XXXSlide class methodsFor: 'error descriptions' stamp: 'Af 7/4/2022 21:41:09'!
cantCreateASlidesThatDoesNotGoesDownErrorDescription
	
	^'a slide must go down'! !


!classDefinition: #SimulatedDice category: 'parcial2021-1c'!
Object subclass: #SimulatedDice
	instanceVariableNames: 'circularReadStream time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial2021-1c'!

!SimulatedDice methodsFor: 'initialization' stamp: 'Af 7/4/2022 18:27:05'!
initializeWith: aCircularReadStream 
	
	circularReadStream := aCircularReadStream.
	time _ true.! !


!SimulatedDice methodsFor: 'throwing' stamp: 'Af 7/4/2022 18:34:00'!
throw
	time ifTrue: [
		time _ time not.
		^circularReadStream current] 
	ifFalse: [
		time _ time not.
		^circularReadStream next].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimulatedDice class' category: 'parcial2021-1c'!
SimulatedDice class
	instanceVariableNames: ''!

!SimulatedDice class methodsFor: 'instance creation' stamp: 'Af 7/4/2022 18:20:30'!
with: aCircularReadStream 

	^self new initializeWith: aCircularReadStream ! !
