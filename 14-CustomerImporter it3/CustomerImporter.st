!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 20:24:44'!
test01ValidCustomersImportCorrectly

	CustomerImporter valueFrom: self validImportData using: system.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 19:41:29'!
test02CustomerIdTypeMustBeC

	self shouldFailImporting: self invalidIdentificationTypeData
		withMessageText: CustomerImporter invalidIdentificationTypeErrorDescription
		asserting: [self assertNoCostumersImported].! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 19:47:34'!
test03AddressIdTypeMustBeA

	self shouldFailImporting: self invalidAddressIdentificationTypeData
		withMessageText: CustomerImporter invalidIdentificationTypeErrorDescription
		asserting: [self assertCustomerHasNoAddresses].
		
	! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 19:48:14'!
test04CustomerRecordHasLessThanSixFields

	self shouldFailImporting: self tooManyCostumerFieldsData
		withMessageText: CustomerImporter tooManyFieldsInCustomerRecordErrorDescription
		asserting: [self assertNoCostumersImported].
		
! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 19:48:47'!
test05CustomerRecordHasMoreThanFourFields

	self shouldFailImporting: self tooFewCostumerFieldsData
		withMessageText: CustomerImporter tooFewFieldsInCustomerRecordErrorDescription
		asserting: [self assertNoCostumersImported].! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 19:49:19'!
test06AddressRecordHasLessThanSevenFields

	self shouldFailImporting: self tooManyAddressFieldsData
		withMessageText: CustomerImporter tooManyFieldsInAddressRecordErrorDescription
		asserting: [self assertCustomerHasNoAddresses].! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 19:49:48'!
test07AddressRecordHasMoreThanFiveFields

	self shouldFailImporting: self tooFewAddressFieldsData
		withMessageText: CustomerImporter tooFewFieldsInAddressRecordErrorDescription
		asserting: [self assertCustomerHasNoAddresses].! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 19:50:10'!
test08AddressRecordMustBelongToACostumer

	self shouldFailImporting: self addressWithoutCustomerData
		withMessageText: CustomerImporter addressWithoutCustomerErrorDescription
		asserting: [self assertNoCostumersImported].! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/27/2022 19:50:38'!
test09EmptyRecordShouldNotImport

	self shouldFailImporting: self invalidEmptyData
		withMessageText: CustomerImporter invalidEmptyDataErrorDescription
		asserting: [self assertNoCostumersImported].! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'JDR 6/27/2022 20:01:49'!
assertCustomerHasNoAddresses

	^ self assert: ( system allClients anyOne) addresses isEmpty! !

!ImportTest methodsFor: 'assertions' stamp: 'JDR 6/27/2022 20:27:10'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'JDR 6/27/2022 20:02:00'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system allClients size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'JDR 6/27/2022 20:02:09'!
assertNoCostumersImported

	^ self assert: 0 equals: system allClients size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'JDR 6/27/2022 20:24:44'!
shouldFailImporting: data withMessageText: anErrorDescription asserting: aBlock 

	self 
		should: [CustomerImporter valueFrom: data using: system] 
		raise: Error - MessageNotUnderstood 
		withMessageText: anErrorDescription.
	
	aBlock value.! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'JDR 6/27/2022 20:51:24'!
setUp
	
	system _ Environment current createCustomerSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'JDR 6/27/2022 20:11:58'!
tearDown

	system commit.
	system stop.
	! !


!ImportTest methodsFor: 'test data' stamp: 'JDR 6/23/2022 21:02:37'!
addressWithoutCustomerData
	
	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'JDR 6/23/2022 20:09:00'!
invalidAddressIdentificationTypeData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444	
Aj,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'JDR 6/26/2022 22:13:21'!
invalidEmptyData

	^ReadStream on: '
'.! !

!ImportTest methodsFor: 'test data' stamp: 'JDR 6/23/2022 19:58:12'!
invalidIdentificationTypeData
	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'JDR 6/23/2022 20:56:04'!
tooFewAddressFieldsData
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322'! !

!ImportTest methodsFor: 'test data' stamp: 'JDR 6/23/2022 20:38:27'!
tooFewCostumerFieldsData
	
	^ReadStream on: 'C,Pepe,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'JDR 6/23/2022 20:49:32'!
tooManyAddressFieldsData
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San,Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'JDR 6/23/2022 20:37:26'!
tooManyCostumerFieldsData 

	^ReadStream on: 'C,Pepe,San,chez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'JDR 6/27/2022 20:24:11'!
initializeFrom: aReadStream using: aSystem 
	readStream := aReadStream.
	system _ aSystem.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/26/2022 22:35:19'!
assertRecordIsNotEmpty

	^ (record isEmpty) ifTrue: [self error: CustomerImporter invalidEmptyDataErrorDescription ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/23/2022 20:21:42'!
createRecord

	record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/23/2022 19:41:57'!
hasLineToImport

	line := readStream nextLine.
	^ line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/23/2022 21:06:49'!
importAddress

	| newAddress |
	
	self assertAddressRecordSizeIsSix.
	
			newAddress := Address new.
			newCustomer 
				ifNil: [self error: CustomerImporter addressWithoutCustomerErrorDescription ]
				ifNotNil:[ newCustomer addAddress: newAddress].
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth.			
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/27/2022 20:22:48'!
importCustomer

	self assertCustomerRecordSizeIsFive.	
	
	newCustomer := Customer new.
			newCustomer firstName: (record) second.
			newCustomer lastName: (record) third.
			newCustomer identificationType: (record) fourth.
			newCustomer identificationNumber: (record) fifth.
			system addCustomer: newCustomer.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/26/2022 22:35:19'!
importRecord

	self assertRecordIsNotEmpty.
	
	(self isCustomerRecord) ifTrue: [^self importCustomer].
	(self isAddressRecord) ifTrue: [^self importAddress].
	
	self error: CustomerImporter invalidIdentificationTypeErrorDescription.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/23/2022 20:09:54'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/23/2022 20:35:46'!
isCustomerRecord

	^ record first = 'C' ! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/23/2022 19:42:15'!
value

	[ self hasLineToImport ] whileTrue: [ 
		self createRecord.
		self importRecord. 
	].

	! !


!CustomerImporter methodsFor: 'assertions' stamp: 'JDR 6/23/2022 20:57:10'!
assertAddressRecordSizeGreaterThanFive

	(record size > 5) ifFalse:[ self error: CustomerImporter tooFewFieldsInAddressRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JDR 6/23/2022 20:58:06'!
assertAddressRecordSizeIsSix

	self assertAddressRecordSizeLowerThanSeven.
	self assertAddressRecordSizeGreaterThanFive! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JDR 6/23/2022 20:53:03'!
assertAddressRecordSizeLowerThanSeven

	(record size < 7) ifFalse: [ 	self error: CustomerImporter tooManyFieldsInAddressRecordErrorDescription. ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JDR 6/23/2022 20:45:13'!
assertCostumerRecordSizeGreaterThanFour
	
	(record size > 4) ifFalse:[ self error: CustomerImporter tooFewFieldsInCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JDR 6/23/2022 20:31:12'!
assertCostumerRecordSizeLowerThanSix
	
	(record size < 6) ifFalse: [ 	self error: CustomerImporter tooManyFieldsInCustomerRecordErrorDescription. ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JDR 6/23/2022 20:46:20'!
assertCustomerRecordSizeIsFive

	self assertCostumerRecordSizeLowerThanSix.
	self assertCostumerRecordSizeGreaterThanFour! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'JDR 6/27/2022 20:24:26'!
from: aReadStream using: aSystem 
	^self new initializeFrom: aReadStream using: aSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'JDR 6/27/2022 20:24:43'!
valueFrom: aReadStream using: aSystem 

	^(self from: aReadStream using: aSystem) value! !


!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JDR 6/23/2022 21:03:24'!
addressWithoutCustomerErrorDescription

	^'an address must follow up a costumer'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JDR 6/23/2022 20:33:12'!
invalidAmountOfFieldsErrorDescription

	^'incorrect amount of fields'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JDR 6/26/2022 22:15:31'!
invalidEmptyDataErrorDescription

	  ^'no data to load costumers'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JDR 6/23/2022 20:03:32'!
invalidIdentificationTypeErrorDescription
	^'Invalid indentification data'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JDR 6/23/2022 20:57:39'!
tooFewFieldsInAddressRecordErrorDescription

	^'address record cannot have less than six fields'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JDR 6/23/2022 20:40:36'!
tooFewFieldsInCustomerRecordErrorDescription

	^'customer record cannot have less than five fields'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JDR 6/23/2022 20:50:27'!
tooManyFieldsInAddressRecordErrorDescription

	^'address record cannot have more than six fields'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JDR 6/23/2022 20:33:37'!
tooManyFieldsInCustomerRecordErrorDescription

	^'customer record cannot have more than five fields'! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'adding' stamp: 'JDR 6/27/2022 21:13:19'!
addCustomer: aCustomer

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'accessing' stamp: 'JDR 6/27/2022 21:13:29'!
allClients

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'accessing' stamp: 'JDR 6/27/2022 21:14:01'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'transaction' stamp: 'JDR 6/27/2022 21:13:48'!
beginTransaction

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'transaction' stamp: 'JDR 6/27/2022 21:13:39'!
commit

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'system life cycle' stamp: 'JDR 6/27/2022 21:13:31'!
start

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'system life cycle' stamp: 'JDR 6/27/2022 21:13:34'!
stop

	self subclassResponsibility ! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'adding' stamp: 'JDR 6/27/2022 20:21:19'!
addCustomer: aCustomer

	^session persist: aCustomer! !


!PersistentCustomerSystem methodsFor: 'accessing' stamp: 'JDR 6/27/2022 19:55:27'!
allClients

	^session selectAllOfType: Customer! !

!PersistentCustomerSystem methodsFor: 'accessing' stamp: 'JDR 6/27/2022 20:26:09'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!PersistentCustomerSystem methodsFor: 'transaction' stamp: 'JDR 6/27/2022 20:06:55'!
beginTransaction

	^ session beginTransaction! !

!PersistentCustomerSystem methodsFor: 'transaction' stamp: 'JDR 6/27/2022 20:11:49'!
commit

	^session commit! !


!PersistentCustomerSystem methodsFor: 'system life cycle' stamp: 'JDR 6/27/2022 20:13:22'!
start

	session _ DataBaseSession for: (Array with: Address with: Customer)! !

!PersistentCustomerSystem methodsFor: 'system life cycle' stamp: 'JDR 6/27/2022 20:10:54'!
stop

	^session close! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'adding' stamp: 'JDR 6/27/2022 20:43:57'!
addCustomer: aCustomer

	customers add: aCustomer ! !


!TransientCustomerSystem methodsFor: 'accessing' stamp: 'JDR 6/27/2022 20:44:19'!
allClients

	^ customers copy! !

!TransientCustomerSystem methodsFor: 'accessing' stamp: 'JDR 6/27/2022 20:45:39'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ customers	
		detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		! !


!TransientCustomerSystem methodsFor: 'transaction' stamp: 'JDR 6/27/2022 20:44:29'!
beginTransaction! !

!TransientCustomerSystem methodsFor: 'transaction' stamp: 'JDR 6/27/2022 20:44:44'!
commit! !


!TransientCustomerSystem methodsFor: 'system life cycle' stamp: 'JDR 6/27/2022 20:43:57'!
start

	customers _ OrderedCollection new.! !

!TransientCustomerSystem methodsFor: 'system life cycle' stamp: 'JDR 6/27/2022 20:44:56'!
stop

	customers _ nil! !


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


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'creating system' stamp: 'JDR 6/27/2022 20:52:10'!
createCustomerSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'JDR 6/27/2022 21:07:44'!
current

	^(self subclasses detect: [:aSubclass | aSubclass isCurrent ]) new.! !



!classDefinition: #DevelopingEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopingEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopingEnvironment methodsFor: 'creating system' stamp: 'JDR 6/27/2022 21:06:05'!
createCustomerSystem

	^TransientCustomerSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopingEnvironment class' category: 'CustomerImporter'!
DevelopingEnvironment class
	instanceVariableNames: ''!

!DevelopingEnvironment class methodsFor: 'current' stamp: 'JDR 6/27/2022 21:04:12'!
isCurrent
	
	^(Smalltalk at: #ENV) = #DEV! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'creating system' stamp: 'JDR 6/27/2022 21:05:36'!
createCustomerSystem

	^PersistentCustomerSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'JDR 6/27/2022 21:04:32'!
isCurrent
	
	^(Smalltalk at: #ENV) = #INTR! !
