!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/16/2022 21:16:27'!
importCustomers: aStream

	"
	self importCustomers
	"
	| inputStream  newCustomer line |

	inputStream := aStream.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].


	inputStream close.
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/16/2022 21:20:00'!
openStream

	^ ReadStream on:'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/16/2022 21:20:00'!
test01Import

	| allCustomers customer1 customerAddress1 customerAddress2 |
	self importCustomers: self openStream. 
	
	allCustomers _ session selectAllOfType: Customer.
	
	self assert: 2 equals: allCustomers size.
	customer1 _ (session select: [ :aCustomer | (aCustomer identificationType = 'D') and: [aCustomer identificationNumber = '22333444']] ofType: Customer) anyOne.
	self assert: 'Pepe' equals: customer1 firstName.
	self assert: 'Sanchez' equals: customer1 lastName.
	self assert: 'D' equals: customer1 identificationType .
	self assert: '22333444' equals: customer1 identificationNumber.
	
	customerAddress1 _ customer1 giveMeAnAddressAt: 3322 namedFFFFFFFFFFFFFFF: 'San Martin' .
	
	self assert: 'San Martin' equals: customerAddress1 streetName.
	self assert: 3322 equals: customerAddress1 streetNumber.
	self assert: 1636 equals: customerAddress1 zipCode.
	self assert: 'Olivos' equals: customerAddress1 town.
	self assert: 'BsAs' equals: customerAddress1 province.
	
	customerAddress2 _ customer1 giveMeAnAddressAt: 888 namedFFFFFFFFFFFFFFF: 'Maipu'.

	self assert: 'Maipu' equals: customerAddress2 streetName.
	self assert: 888 equals: customerAddress2 streetNumber.
	self assert: 1122 equals: customerAddress2 zipCode.
	self assert: 'Florida' equals: customerAddress2 town.
	self assert: 'Buenos Aires' equals: customerAddress2 province.	

	
	session commit.
	session close.! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'as yet unclassified' stamp: 'AF 6/16/2022 21:10:35'!
isNamed: aStreetName withNumber: aStreetNumber 
	
	^(streetName = aStreetName) and: [streetNumber = aStreetNumber ]! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'as yet unclassified' stamp: 'AF 6/16/2022 21:09:01'!
giveMeAnAddressAt: aStreetNumber namedFFFFFFFFFFFFFFF: aStreetName 
	
	^addresses detect: [:anAddress | anAddress isNamed: aStreetName withNumber: aStreetNumber ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'importing' stamp: 'HAW 5/22/2022 00:25:18'!
importCustomers

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := StandardFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData fourth ].

		line := inputStream nextLine. ].

	session commit.
	session close.

	inputStream close.
	! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
