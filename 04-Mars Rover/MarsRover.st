!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 11:55:32'!
test01RoverStaysAtOriginWhenReceivingEmptyString

	| marsRover cardinalPoint |
	cardinalPoint _ South new.
	marsRover _ MarsRover createAt: 0@0 facing: cardinalPoint.

	self assert: ((marsRover process: '') isAt: 0@0 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:40:45'!
test02RoverMovesForwardCorrectlyWhenFacingNorth

	| marsRover cardinalPoint |
	
	cardinalPoint _ North new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'f'.
	
	self assert: (marsRover isAt: 0@1 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:41:33'!
test03RoverMovesBackwardsCorrectlyWhenFacingNorth

	| marsRover cardinalPoint |
	
	cardinalPoint _ North new.
	marsRover _ marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'b'.
	
	self assert: (marsRover isAt: 0@-1 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:42:03'!
test04RoverRotatesLeftCorrectlyWhenFacingNorth

	| marsRover cardinalPoint |
	cardinalPoint _ North new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'l'.
	
	self assert: (marsRover isAt: 0@0 facing: West new)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:42:34'!
test05RoverRotatesRightCorrectlyWhenFacingNorth

	| marsRover cardinalPoint |
	cardinalPoint _ North new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'r'.
	
	self assert: (marsRover isAt: 0@0 facing: East new)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:42:56'!
test06RoverMovesForwardCorrectlyWhenFacingSouth

	| marsRover cardinalPoint |
	cardinalPoint _ South new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'f'.
	
	self assert: (marsRover isAt: 0@-1 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:43:23'!
test07RoverMovesBackwardsCorrectlyWhenFacingSouth

	| marsRover cardinalPoint |
	cardinalPoint _ South new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'b'.
	
	self assert: (marsRover isAt: 0@1 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:43:42'!
test08RoverRotatesLeftCorrectlyWhenFacingSouth

	| marsRover cardinalPoint |
	cardinalPoint _ South new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'l'.
	
	self assert: (marsRover isAt: 0@0 facing: East new)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:44:14'!
test09RoverRotatesRightCorrectlyWhenFacingSouth

	| marsRover cardinalPoint |
	cardinalPoint _ South new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'r'.
	
	self assert: (marsRover isAt: 0@0 facing: West new)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:44:38'!
test10RoverMovesForwardCorrectlyWhenFacingWest

	| marsRover cardinalPoint |
	cardinalPoint _ West new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'f'.
	
	self assert: (marsRover isAt: -1@0 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:44:52'!
test11RoverMovesBackwardsCorrectlyWhenFacingWest

	| marsRover cardinalPoint |
	cardinalPoint _ West new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'b'.
	
	self assert: (marsRover isAt: 1@0 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:45:07'!
test12RoverRotatesLeftCorrectlyWhenFacingWest

	| marsRover cardinalPoint |
	cardinalPoint _ West new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'l'.
	
	self assert: (marsRover isAt: 0@0 facing: South new)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:45:20'!
test13RoverRotatesRightCorrectlyWhenFacingWest

	| marsRover cardinalPoint |
	cardinalPoint _ West new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'r'.
	
	self assert: (marsRover isAt: 0@0 facing: North new)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:45:36'!
test14RoverMovesForwardCorrectlyWhenFacingEast

	| marsRover cardinalPoint |
	cardinalPoint _ East new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'f'.
	
	self assert: (marsRover isAt: 1@0 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:45:50'!
test15RoverMovesBackwardsCorrectlyWhenFacingEast

	| marsRover cardinalPoint |
	cardinalPoint _ East new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'b'.
	
	self assert: (marsRover isAt: -1@0 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:46:00'!
test16RoverRotatesLeftCorrectlyWhenFacingEast

	| marsRover cardinalPoint |
	cardinalPoint _ East new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'l'.
	
	self assert: (marsRover isAt: 0@0 facing: North new)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:46:12'!
test17RoverRotatesRightCorrectlyWhenFacingEast

	| marsRover cardinalPoint |
	cardinalPoint _ East new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'r'.
	
	self assert: (marsRover isAt: 0@0 facing: South new)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:46:23'!
test22RoverProcessesAChainOfCommandsCorrectly

	| marsRover cardinalPoint |
	cardinalPoint _ North new.
	marsRover _ self createAMarsRoverAt: 0@0 facing: cardinalPoint andProcess: 'ff'.
	
	self assert: (marsRover isAt: 0@2 facing: cardinalPoint)! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JDR 5/14/2022 13:34:36'!
test23AnInvalidCommandShouldRaiseAnError

	| marsRover cardinalPoint |
	cardinalPoint _ North new.
	marsRover _ MarsRover createAt: 0@0 facing: cardinalPoint.
	
	self  should: [marsRover process: 't'] 
		raise: Error - MessageNotUnderstood 
		withMessageText: MarsRover invalidCommandErrorDescription.
	
	! !


!MarsRoverTests methodsFor: 'initialize & process' stamp: 'JDR 5/14/2022 13:39:40'!
createAMarsRoverAt: aCoordinate facing: aCardinalPoint andProcess: aCommand

	| marsRover |
	marsRover _ MarsRover createAt: aCoordinate facing: aCardinalPoint.
	marsRover process: aCommand.
	
	^marsRover! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'rotations' stamp: 'JDR 5/14/2022 12:37:05'!
turnLeft: aMarsRover

	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'rotations' stamp: 'JDR 5/14/2022 12:37:08'!
turnRight: aMarsRover

	self subclassResponsibility ! !


!CardinalPoint methodsFor: 'moving' stamp: 'JDR 5/14/2022 12:36:58'!
moveBackwards: aMarsRover

	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'moving' stamp: 'JDR 5/14/2022 12:36:52'!
moveForward: aMarsRover

	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'moving' stamp: 'JDR 5/14/2022 13:19:43'!
moveBackwards: aMarsRover

	aMarsRover moveOnePositionToWest
! !

!East methodsFor: 'moving' stamp: 'JDR 5/14/2022 13:19:31'!
moveForward: aMarsRover

	aMarsRover moveOnePositionToEast
! !


!East methodsFor: 'rotations' stamp: 'JDR 5/14/2022 12:36:21'!
turnLeft: aMarsRover

	aMarsRover faceNorth
! !

!East methodsFor: 'rotations' stamp: 'JDR 5/14/2022 12:36:30'!
turnRight: aMarsRover

	aMarsRover faceSouth
! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'moving' stamp: 'JDR 5/14/2022 12:31:37'!
moveBackwards: aMarsRover

	aMarsRover moveOnePositionToSouth.
	! !

!North methodsFor: 'moving' stamp: 'JDR 5/14/2022 12:30:36'!
moveForward: aMarsRover

	aMarsRover moveOnePositionToNorth.
	! !


!North methodsFor: 'rotations' stamp: 'JDR 5/14/2022 12:32:05'!
turnLeft: aMarsRover

	aMarsRover faceWest.
	! !

!North methodsFor: 'rotations' stamp: 'JDR 5/14/2022 13:17:48'!
turnRight: aMarsRover

	aMarsRover faceEast.
	! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'moving' stamp: 'JDR 5/14/2022 12:33:45'!
moveBackwards: aMarsRover

	aMarsRover moveOnePositionToNorth! !

!South methodsFor: 'moving' stamp: 'JDR 5/14/2022 12:33:30'!
moveForward: aMarsRover

	aMarsRover moveOnePositionToSouth! !


!South methodsFor: 'rotations' stamp: 'JDR 5/14/2022 13:17:48'!
turnLeft: aMarsRover

	aMarsRover faceEast! !

!South methodsFor: 'rotations' stamp: 'JDR 5/14/2022 12:34:15'!
turnRight: aMarsRover

	aMarsRover faceWest! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'moving' stamp: 'JDR 5/14/2022 13:19:31'!
moveBackwards: aMarsRover

	aMarsRover moveOnePositionToEast! !

!West methodsFor: 'moving' stamp: 'JDR 5/14/2022 13:19:43'!
moveForward: aMarsRover

	aMarsRover moveOnePositionToWest! !


!West methodsFor: 'rotations' stamp: 'JDR 5/14/2022 12:35:18'!
turnLeft: aMarsRover

	aMarsRover faceSouth
! !

!West methodsFor: 'rotations' stamp: 'JDR 5/14/2022 12:35:24'!
turnRight: aMarsRover

	aMarsRover faceNorth
! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate cardinalPoint validSingleCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'assertions' stamp: 'JDR 5/14/2022 13:16:51'!
assertCommandIsValid: aCommand

	aCommand do: [ :singleCommand | self assertSingleCommandIsValid: singleCommand ]! !

!MarsRover methodsFor: 'assertions' stamp: 'JDR 5/14/2022 13:15:59'!
assertSingleCommandIsValid: aSingleCommand

	(validSingleCommands includes: aSingleCommand) ifFalse: [self error: MarsRover invalidCommandErrorDescription ] ! !


!MarsRover methodsFor: 'moving - private' stamp: 'JDR 5/14/2022 13:19:31'!
moveOnePositionToEast

	^ coordinate _ coordinate + (1@0)! !

!MarsRover methodsFor: 'moving - private' stamp: 'JDR 5/12/2022 21:47:08'!
moveOnePositionToNorth

	^ coordinate _ coordinate + (0@1)! !

!MarsRover methodsFor: 'moving - private' stamp: 'JDR 5/14/2022 12:49:26'!
moveOnePositionToSouth

	^ coordinate _ coordinate + (0@-1)! !

!MarsRover methodsFor: 'moving - private' stamp: 'JDR 5/14/2022 13:19:43'!
moveOnePositionToWest

	^ coordinate _ coordinate + (-1@0)! !


!MarsRover methodsFor: 'rotations - private' stamp: 'JDR 5/14/2022 13:53:23'!
faceEast

	cardinalPoint _ East new.! !

!MarsRover methodsFor: 'rotations - private' stamp: 'JDR 5/14/2022 13:53:19'!
faceNorth

	cardinalPoint _ North new! !

!MarsRover methodsFor: 'rotations - private' stamp: 'JDR 5/14/2022 13:53:14'!
faceSouth

	cardinalPoint _ South new! !

!MarsRover methodsFor: 'rotations - private' stamp: 'JDR 5/14/2022 12:05:22'!
faceWest

	cardinalPoint _ West new! !


!MarsRover methodsFor: 'testing' stamp: 'JDR 5/14/2022 12:09:36'!
isAt: aCoordinate facing: aCardinalPoint
	
	^(aCoordinate = coordinate) and: [aCardinalPoint isKindOf: cardinalPoint class] 
	! !


!MarsRover methodsFor: 'processing - private' stamp: 'JDR 5/14/2022 14:00:51'!
processASingleCommand: aSingleCommand 	

	self processIfCommandIsForward: aSingleCommand.
	
	self processIfCommandIsBackwards: aSingleCommand.
	
	self processIfCommandIsLeft: aSingleCommand.
	
	self processIfCommandIsRight: aSingleCommand.
	
	
	! !

!MarsRover methodsFor: 'processing - private' stamp: 'JDR 5/14/2022 13:59:05'!
processIfCommandIsBackwards: aSingleCommand 	

	(aSingleCommand = $b) ifTrue: [cardinalPoint moveBackwards: self].
! !

!MarsRover methodsFor: 'processing - private' stamp: 'JDR 5/14/2022 13:58:22'!
processIfCommandIsForward: aSingleCommand 	

	(aSingleCommand = $f) ifTrue: [cardinalPoint moveForward: self].
! !

!MarsRover methodsFor: 'processing - private' stamp: 'JDR 5/14/2022 13:59:36'!
processIfCommandIsLeft: aSingleCommand 	

	(aSingleCommand = $l) ifTrue: [cardinalPoint turnLeft: self]
! !

!MarsRover methodsFor: 'processing - private' stamp: 'JDR 5/14/2022 13:59:47'!
processIfCommandIsRight: aSingleCommand 	

	(aSingleCommand = $r) ifTrue: [cardinalPoint turnRight: self].
	! !


!MarsRover methodsFor: 'processing' stamp: 'JDR 5/14/2022 14:01:33'!
process: aCommand 

	self assertCommandIsValid: aCommand.
	
	aCommand do: [ :singleCommand | self processASingleCommand: singleCommand ]! !


!MarsRover methodsFor: 'initialization' stamp: 'JDR 5/14/2022 13:10:13'!
initializeCreateAt: aCoordinate facing: aCardinalPoint 
	
	coordinate := aCoordinate.
	cardinalPoint := aCardinalPoint.
	validSingleCommands := OrderedCollection with: $f with: $b with: $l with: $r.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'JDR 5/12/2022 20:51:26'!
createAt: aCoordinate facing: aCardinalPoint 
	
	^self new initializeCreateAt: aCoordinate facing: aCardinalPoint ! !


!MarsRover class methodsFor: 'error description' stamp: 'JDR 5/14/2022 13:03:43'!
invalidCommandErrorDescription

	^'Cannot process an invalid command'! !
