!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 20:57:35'!
test01RoverStaysAtOriginWhenReceivingEmptyString

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #south.

	self assert: ((marsRover process: '') isAt: 0@0 facing: #south)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 20:55:23'!
test02

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #north.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 0@1 facing: #north)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 20:58:22'!
test03

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #north.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@-1 facing: #north)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 20:59:43'!
test04

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #north.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 0@0 facing: #west)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:04:30'!
test05

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #north.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 0@0 facing: #east)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:06:31'!
test06

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #south.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 0@-1 facing: #south)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:29:35'!
test07

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #south.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@1 facing: #south)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:29:14'!
test08

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #south.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 0@0 facing: #east)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:29:03'!
test09

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #south.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 0@0 facing: #west)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:28:54'!
test10

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #west.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: -1@0 facing: #west)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:28:49'!
test11

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #west.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@0 facing: #west)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:28:44'!
test12

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #west.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 0@0 facing: #south)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:28:41'!
test13

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #west.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 0@0 facing: #north)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:28:39'!
test14

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #east.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@0 facing: #east)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:28:35'!
test15

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #east.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: -1@0 facing: #east)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:28:32'!
test16

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #east.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 0@0 facing: #north)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:28:24'!
test17

	| marsRover |
	marsRover _ MarsRover createAt: 0@0 facing: #east.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 0@0 facing: #south)! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:37:17'!
test18

	| marsRover |
	marsRover _ MarsRover createAt: 1@3 facing: #north.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@4 facing: #north)! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate cardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:51:49'!
faceNorth

	^ cardinalPoint _ #north! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:51:31'!
faceSouth

	^ cardinalPoint _ #south! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:51:31'!
faceToEast

	^ cardinalPoint _ #east! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:51:31'!
faceWest

	^ cardinalPoint _ #west! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 20:56:50'!
isAt: aCoordinate facing: aCardinalPoint
	
	^aCoordinate = coordinate! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:47:08'!
moveOnePositionToNorth

	^ coordinate _ coordinate + (0@1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:47:31'!
moveOnePositionToSouth

	^ coordinate _ 0@-1! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:49:49'!
moveToEast

	^ coordinate _ -1@0! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:50:10'!
moveToWest

	^ coordinate _ 1@0! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'JDR 5/12/2022 21:51:49'!
process: aString 
	
	cardinalPoint = #north ifTrue: [
		aString = 'f' ifTrue: [self moveOnePositionToNorth].
		aString = 'b' ifTrue: [self moveOnePositionToSouth].
		aString = 'l' ifTrue: [self faceWest].
		aString = 'r' ifTrue: [self faceToEast].
	].

	cardinalPoint = #south ifTrue: [
		aString = 'f' ifTrue: [self moveOnePositionToSouth].
		aString = 'b' ifTrue: [self moveOnePositionToNorth].
		aString = 'l' ifTrue: [self faceToEast].
		aString = 'r' ifTrue: [self faceWest].
	].

	cardinalPoint = #west ifTrue: [
		aString = 'f' ifTrue: [self moveToEast].
		aString = 'b' ifTrue: [self moveToWest].
		aString = 'l' ifTrue: [self faceSouth].
		aString = 'r' ifTrue: [self faceNorth].
	].

	cardinalPoint = #east ifTrue: [
		aString = 'f' ifTrue: [self moveToWest].
		aString = 'b' ifTrue: [self moveToEast].
		aString = 'l' ifTrue: [self faceNorth].
		aString = 'r' ifTrue: [self faceSouth].
	].

	! !


!MarsRover methodsFor: 'initialization' stamp: 'JDR 5/12/2022 21:51:31'!
initializeCreateAt: aCoordinate facing: aCardinalPoint 
	
	coordinate := aCoordinate.
	cardinalPoint := aCardinalPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'JDR 5/12/2022 20:51:26'!
createAt: aCoordinate facing: aCardinalPoint 
	
	^self new initializeCreateAt: aCoordinate facing: aCardinalPoint ! !
