!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:38:44'!
test01ValidCustomersImportCorrectly

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:46:16'!
test02CustomerIdTypeMustBeC

	self should: [CustomerImporter valueFrom: self invalidIdentificationTypeData into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		 self assert: CustomerImporter invalidIdentificationTypeErrorDescription equals: anError messageText.
		 self assertNoCostumersImported ] .! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:07:37'!
test03AddressIdTypeMustBeA

	self should: [CustomerImporter valueFrom: self invalidAddressIdentificationTypeData into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |   
		self assert: CustomerImporter invalidIdentificationTypeErrorDescription equals: anError messageText.		
		self assertCustomerHasNoAddresses.
		 ] .! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:46:17'!
test04CustomerRecordHasLessThanSixFields

	self should: [CustomerImporter valueFrom: self tooManyCostumerFieldsData into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError | 
		self assert: CustomerImporter tooManyFieldsInCustomerRecordErrorDescription equals: anError messageText.
		self assertNoCostumersImported ] .! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:46:16'!
test05CustomerRecordHasMoreThanFourFields

	self should: [CustomerImporter valueFrom: self tooFewCostumerFieldsData into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError | 
		self assert: CustomerImporter tooFewFieldsInCustomerRecordErrorDescription equals: anError messageText .
		self assertNoCostumersImported] .! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:07:37'!
test06AddressRecordHasLessThanSevenFields

	self should: [CustomerImporter valueFrom: self tooManyAddressFieldsData into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError | 
		self assert: CustomerImporter tooManyFieldsInAddressRecordErrorDescription equals: anError messageText.
		self assertCustomerHasNoAddresses. ] .! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:07:37'!
test07AddressRecordHasMoreThanFiveFields

	self should: [CustomerImporter valueFrom: self tooFewAddressFieldsData into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError | 
		self assert: CustomerImporter tooFewFieldsInAddressRecordErrorDescription equals: anError messageText.
		self assertCustomerHasNoAddresses. ] .! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:46:16'!
test08AddressRecordMustBelongToACostumer

	self should: [CustomerImporter valueFrom: self addressWithoutCustomerData into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError | 
		self assert: CustomerImporter addressWithoutCustomerErrorDescription equals: anError messageText.
		self assertNoCostumersImported ] .! !

!ImportTest methodsFor: 'tests' stamp: 'JDR 6/26/2022 22:49:22'!
test09EmptyRecordShouldNotImport

	self should: [CustomerImporter valueFrom: self invalidEmptyData into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: CustomerImporter invalidEmptyDataErrorDescription equals: anError messageText.
		self assertNoCostumersImported 
		  ] .! !


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

!ImportTest methodsFor: 'assertions' stamp: 'JDR 6/26/2022 22:07:37'!
assertCustomerHasNoAddresses

	^ self assert: ( (session selectAllOfType: Customer) anyOne) addresses isEmpty! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'JDR 6/26/2022 22:46:16'!
assertNoCostumersImported

	^ self assert: 0 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


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
	instanceVariableNames: 'session readStream line newCustomer record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


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

!CustomerImporter methodsFor: 'evaluating' stamp: 'JDR 6/26/2022 22:34:24'!
importCustomer

	self assertCustomerRecordSizeIsFive.	
	
	newCustomer := Customer new.
			newCustomer firstName: (record) second.
			newCustomer lastName: (record) third.
			newCustomer identificationType: (record) fourth.
			newCustomer identificationNumber: (record) fifth.
			session persist: newCustomer! !

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

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


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
