!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'testing' stamp: 'JDR 6/23/2022 14:02:07'!
test01Import

	| allCustomers customer1 customer1Address1 customer1Address2 customer2 customer2Address |
	self importCustomers: self openStream. 
	
	allCustomers _ session selectAllOfType: Customer.
	customer1 _ self giveMeACostumerOfType: 'D' identifiedWithNumber: '22333444'.
	customer1Address1 _ customer1 giveMeAnAddressAt: 3322 withName: 'San Martin' .
	customer1Address2 _ customer1 giveMeAnAddressAt: 888 withName: 'Maipu'.
	customer2 _ self giveMeACostumerOfType: 'C' identifiedWithNumber: '23-25666777-9'.
	customer2Address _ customer2 giveMeAnAddressAt: 1122 withName: 'Alem'. 
	
	self assert: 2 equals: allCustomers size.	
	self assert: customer1 firstNameIs: 'Pepe' lastNameIs: 'Sanchez' withType: 'D' identifiedWithNumber: '22333444'.	
	self assert: customer1Address1 isNamed: 'San Martin' at: 3322 with: 1636 inTown: 'Olivos' inProvince: 'BsAs'.	
	self assert: customer1Address2 isNamed: 'Maipu' at: 888 with: 1122 inTown: 'Florida' inProvince: 'Buenos Aires'.
	self assert: customer2 firstNameIs: 'Juan' lastNameIs: 'Perez' withType: 'C' identifiedWithNumber: '23-25666777-9'.	
	self assert: customer2Address isNamed: 'Alem' at: 1122 with: 1001 inTown: 'CABA' inProvince: 'CABA'.

! !


!ImportTest methodsFor: 'setUp' stamp: 'AF 6/16/2022 21:31:27'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !


!ImportTest methodsFor: 'tearDown' stamp: 'AF 6/16/2022 21:30:49'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'assertions' stamp: 'JDR 6/23/2022 13:47:21'!
assert: aCustomer firstNameIs: aFirstName lastNameIs: aLastName withType: anIdentificationType identifiedWithNumber: anIdentificationNumber    

	self assert: aFirstName equals: aCustomer firstName.
	self assert: aLastName equals: aCustomer lastName.
	self assert: anIdentificationType equals: aCustomer identificationType .
	self assert: anIdentificationNumber equals: aCustomer identificationNumber! !

!ImportTest methodsFor: 'assertions' stamp: 'AF 6/16/2022 21:46:06'!
assert: aCustomerAddress isNamed: aStreetName at: aStreetNumber with: aZipCode inTown: aTown inProvince: aProvince     

	self assert: aStreetName equals: aCustomerAddress streetName.
	self assert: aStreetNumber equals: aCustomerAddress streetNumber.
	self assert: aZipCode equals: aCustomerAddress zipCode.
	self assert: aTown equals: aCustomerAddress town.
	self assert: aProvince equals: aCustomerAddress province! !


!ImportTest methodsFor: 'as yet unclassified' stamp: 'JDR 6/23/2022 14:01:22'!
giveMeACostumerOfType: anIdentificationType identifiedWithNumber: anIdentificationNumber 

	^ (session select: [ :aCustomer | (aCustomer identificationType = anIdentificationType) and: [aCustomer identificationNumber = anIdentificationNumber]] ofType: Customer) anyOne! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/16/2022 21:37:38'!
importCustomers: aStream
	(ImportClients from: session importClientsTo: aStream) value! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AF 6/16/2022 21:20:00'!
openStream

	^ ReadStream on:'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !


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


!Address methodsFor: 'street' stamp: 'AF 6/16/2022 21:10:35'!
isNamed: aStreetName withNumber: aStreetNumber 
	
	^(streetName = aStreetName) and: [streetNumber = aStreetNumber ]! !

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


!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


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


!Customer methodsFor: 'as yet unclassified' stamp: 'JDR 6/23/2022 13:44:32'!
giveMeAnAddressAt: aStreetNumber withName: aStreetName 
	
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


!classDefinition: #ImportClients category: 'CustomerImporter'!
Object subclass: #ImportClients
	instanceVariableNames: 'session stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportClients methodsFor: 'initialization' stamp: 'AF 6/16/2022 21:37:10'!
initializeFrom: aSession importClientsTo: aStream
	session := aSession.
	stream := aStream.! !


!ImportClients methodsFor: 'evaluating' stamp: 'AF 6/16/2022 21:35:19'!
value

	"
	self importCustomers
	"
	| inputStream  newCustomer line |

	inputStream := stream.

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ImportClients class' category: 'CustomerImporter'!
ImportClients class
	instanceVariableNames: ''!

!ImportClients class methodsFor: 'instance creation' stamp: 'AF 6/16/2022 21:37:19'!
from: aSession importClientsTo: aStream
	^self new initializeFrom: aSession importClientsTo: aStream! !
