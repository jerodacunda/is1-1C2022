!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:17:48'!
test05HeadingLoggerShouldRegisterNewHeadingAfterRotatingToEast

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'East' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:17:41'!
test06HeadingLoggerShouldRegisterNewHeadingAfterRotatingToNorth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'l'.
	
	logStream := logger readStream.
	self assert: 'North' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:17:33'!
test07HeadingLoggerShouldRegisterNewHeadingAfterRotatingToSouth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'South' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:17:25'!
test08HeadingLoggerShouldRegisterNewHeadingAfterRotatingToWest

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	logger := MarsRoverLogger followHeadingChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.
! !


!MarsRoverLoggerTest methodsFor: 'testing - position & heading' stamp: 'JDR 6/1/2022 22:18:59'!
test09PositionAndHeadingLoggerShouldRegisterEveryProcessedCommand

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionAndHeadingOn: marsRover.
	
	marsRover process: 'rfr'.
	
	logStream := logger readStream.
	self assert: 'East' equals: logStream nextLine.
	self assert: '2@1' equals: logStream nextLine.
	self assert: 'South' equals: logStream nextLine.
	self assert: logStream atEnd.
! !


!MarsRoverLoggerTest methodsFor: 'testing - position' stamp: 'JDR 6/1/2022 22:02:41'!
test01PositionLoggerOfANewMarsRoverShouldBeEmptyString

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: logger readStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'testing - position' stamp: 'JDR 6/1/2022 22:18:34'!
test02PositionLoggerShouldRegisterNewPositionAfterMovingForward

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'testing - position' stamp: 'JDR 6/1/2022 22:18:28'!
test03PositionLoggerShouldRegisterNewPositionAfterMovingBackwards

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'b'.
	
	logStream := logger readStream.
	self assert: '1@0' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'testing - position' stamp: 'JDR 6/1/2022 22:18:16'!
test04PositionLoggerShouldRegisterEveryMovingCommand

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger followPositionChangesOn: marsRover.
	
	marsRover process: 'fb'.
	
	logStream := logger readStream.
	self assert: '2@1' equals: logStream nextLine.
	self assert: '1@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:23:55'!
test02WindowOfANewMarsRoverShouldExhibitEmptyStringAsLastHeading

	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	window _ MarsRoverWindow followPositionAndHeadingOn: marsRover.
	
	marsRover process: ''.
	
	self assert: '' equals: window lastHeading.
	 
! !

!MarsRoverWindowTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:40:47'!
test04WindowShouldExhibitNewHeadingAfterRotatingEast

	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	window _ MarsRoverWindow followPositionAndHeadingOn: marsRover.
	
	marsRover process: 'r'.
	
	self assert: '' equals: window lastPosition.
	self assert: 'Heading East' equals: window lastHeading.
	 ! !

!MarsRoverWindowTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:41:06'!
test05WindowShouldExhibitNewHeadingAfterRotatingSouth

	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingEast .
	window _ MarsRoverWindow followPositionAndHeadingOn: marsRover.
	
	marsRover process: 'r'.
	
	self assert: '' equals: window lastPosition.
	self assert: 'Heading South' equals: window lastHeading.
	 ! !

!MarsRoverWindowTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:41:30'!
test06WindowShouldExhibitNewHeadingAfterRotatingWest

	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingSouth .
	window _ MarsRoverWindow followPositionAndHeadingOn: marsRover.
	
	marsRover process: 'r'.
	
	self assert: '' equals: window lastPosition.
	self assert: 'Heading West' equals: window lastHeading.
	 ! !

!MarsRoverWindowTest methodsFor: 'testing - heading' stamp: 'JDR 6/1/2022 22:41:49'!
test07WindowShouldExhibitNewHeadingAfterRotatingNorth

	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingWest .
	window _ MarsRoverWindow followPositionAndHeadingOn: marsRover.
	
	marsRover process: 'r'.
	
	self assert: '' equals: window lastPosition.
	self assert: 'Heading North' equals: window lastHeading.
	 ! !


!MarsRoverWindowTest methodsFor: 'testing - position' stamp: 'JDR 6/1/2022 22:23:39'!
test01WindowOfANewMarsRoverShouldExhibitEmptyStringAsLastPosition

	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	window _ MarsRoverWindow followPositionAndHeadingOn: marsRover.
	
	marsRover process: ''.
	
	self assert: '' equals: window lastPosition.
! !

!MarsRoverWindowTest methodsFor: 'testing - position' stamp: 'JDR 6/1/2022 22:25:01'!
test03WindowShouldExhibitNewPositionAfterProcessingAMovingCommand

	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	window _ MarsRoverWindow followPositionAndHeadingOn: marsRover.
	
	marsRover process: 'f'.
	
	self assert: '1@2' equals: window lastPosition.
	self assert: '' equals: window lastHeading.
	 ! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionObservers headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'JDR 6/1/2022 21:58:56'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	positionObservers _ OrderedCollection new.
	headingObservers _ OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'JDR 6/1/2022 23:08:00'!
headEast
	
	self notifyAfterHeadingTo: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JDR 6/1/2022 23:08:00'!
headNorth
	
	self notifyAfterHeadingTo: (MarsRoverHeadingNorth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JDR 6/1/2022 23:08:00'!
headSouth
	
	self notifyAfterHeadingTo: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JDR 6/1/2022 23:08:00'!
headWest
	
	self notifyAfterHeadingTo: (MarsRoverHeadingWest for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JDR 6/1/2022 23:08:00'!
notifyAfterHeadingTo: aNewHeading

	head := aNewHeading.
	self notifyHeadingChange.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'JDR 6/1/2022 23:06:45'!
addToPositionAndNotify: aPointToAdd

	position := position + aPointToAdd.
	self notifyPositionChange.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'JDR 6/1/2022 23:02:54'!
moveEast
	
	self addToPositionAndNotify: 1@0.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'JDR 6/1/2022 23:02:54'!
moveNorth
	
	self addToPositionAndNotify: 0@1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'JDR 6/1/2022 23:02:54'!
moveSouth
	
	self addToPositionAndNotify: 0@-1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'JDR 6/1/2022 23:02:54'!
moveWest
	
	self addToPositionAndNotify: -1@0! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'notifying' stamp: 'JDR 6/1/2022 21:59:06'!
notifyHeadingChange

	headingObservers do: [ :anObserver | anObserver headingChangedTo: head ].! !

!MarsRover methodsFor: 'notifying' stamp: 'JDR 6/1/2022 21:59:17'!
notifyPositionChange

	positionObservers do: [ :anObserver | anObserver positionChangedTo: position ].! !


!MarsRover methodsFor: 'attaching' stamp: 'JDR 6/1/2022 21:58:56'!
followHeadingChangesWith: aSuperclaseDeLosLoggersInstance 
	
	headingObservers add: aSuperclaseDeLosLoggersInstance! !

!MarsRover methodsFor: 'attaching' stamp: 'JDR 6/1/2022 21:58:49'!
followPositionChangesWith: aSuperclaseDeLosLoggersInstance 
	
	positionObservers add: aSuperclaseDeLosLoggersInstance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'accessing' stamp: 'JDR 6/1/2022 22:58:02'!
cardinalPointAsString
	
	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'accessing' stamp: 'JDR 6/1/2022 22:37:19'!
cardinalPointAsString
	
	^'East'! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !



!MarsRoverHeadingNorth methodsFor: 'accessing' stamp: 'JDR 6/1/2022 22:37:40'!
cardinalPointAsString
	
	^'North'! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'accessing' stamp: 'JDR 6/1/2022 22:37:57'!
cardinalPointAsString
	
	^'South'! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'accessing' stamp: 'JDR 6/1/2022 22:38:12'!
cardinalPointAsString
	
	^'West'! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'updating' stamp: 'JDR 6/1/2022 20:51:21'!
headingChangedTo: aMarsRoverHeading

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'JDR 6/1/2022 20:51:30'!
positionChangedTo: aPoint 

	self subclassResponsibility! !


!MarsRoverObserver methodsFor: 'attaching' stamp: 'JDR 6/1/2022 22:50:43'!
followPositionAndHeadingOn: aMarsRover 

	self subclassResponsibility! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'accessing' stamp: 'HAW 5/30/2022 20:23:26'!
readStream
	
	^ReadStream on: log contents ! !


!MarsRoverLogger methodsFor: 'attaching' stamp: 'JDR 6/1/2022 21:54:35'!
followHeadingChangesOn: aMarsRover 
	
	aMarsRover followHeadingChangesWith: self! !

!MarsRoverLogger methodsFor: 'attaching' stamp: 'JDR 6/1/2022 20:18:35'!
followPositionAndHeadingOn: aMarsRover 
	
	self followHeadingChangesOn: aMarsRover.
	self followPositionChangesOn: aMarsRover.! !

!MarsRoverLogger methodsFor: 'attaching' stamp: 'JDR 6/1/2022 21:52:47'!
followPositionChangesOn: aMarsRover 
	
	aMarsRover followPositionChangesWith: self! !


!MarsRoverLogger methodsFor: 'initialization' stamp: 'HAW 5/30/2022 20:25:00'!
initialize

	log  := WriteStream on: ''! !


!MarsRoverLogger methodsFor: 'updating' stamp: 'JDR 6/1/2022 22:38:25'!
headingChangedTo: aMarsRoverHeading
	
	log nextPutAll: (aMarsRoverHeading cardinalPointAsString); newLine! !

!MarsRoverLogger methodsFor: 'updating' stamp: 'HAW 5/30/2022 20:22:16'!
positionChangedTo: aPosition

	log print: aPosition; newLine! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'JDR 6/1/2022 20:18:35'!
followHeadingChangesOn: aMarsRover 
	
	^self new followHeadingChangesOn: aMarsRover ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'JDR 6/1/2022 19:47:53'!
followPositionAndHeadingOn: aMarsRover 
	
	^self new followPositionAndHeadingOn: aMarsRover ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'HAW 5/30/2022 20:16:11'!
followPositionChangesOn: aMarsRover 
	
	^self new followPositionChangesOn: aMarsRover ! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'lastPosition lastHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'accessing' stamp: 'JDR 6/1/2022 20:20:39'!
lastHeading
	
	^lastHeading .! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'JDR 6/1/2022 20:20:24'!
lastPosition
	
	^lastPosition ! !


!MarsRoverWindow methodsFor: 'attaching' stamp: 'JDR 6/1/2022 22:46:35'!
followPositionAndHeadingOn: aMarsRover
	
	lastPosition  _ ''.
	lastHeading _ ''.
	
	aMarsRover followHeadingChangesWith: 		self.
	aMarsRover followPositionChangesWith: self.! !


!MarsRoverWindow methodsFor: 'updating' stamp: 'JDR 6/1/2022 22:41:56'!
headingChangedTo: aMarsRoverHeading
	
	lastHeading _ 'Heading ', aMarsRoverHeading cardinalPointAsString.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'JDR 6/1/2022 20:52:49'!
positionChangedTo: aPosition 
	
	lastPosition _ aPosition asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'JDR 6/1/2022 19:51:29'!
followPositionAndHeadingOn: aMarsRover 
	
	^self new followPositionAndHeadingOn: aMarsRover ! !
