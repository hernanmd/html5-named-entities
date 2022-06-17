"
A XHTMLNamedEntitiesTest is a test class for testing the behavior of XHTMLNamedEntities
"
Class {
	#name : #XHTMLNamedEntitiesTest,
	#superclass : #TestCase,
	#instVars : [
		'reader'
	],
	#category : #'XHTMLNamedEntities-Tests'
}

{ #category : #accessing }
XHTMLNamedEntitiesTest >> reader [

	^ reader
]

{ #category : #running }
XHTMLNamedEntitiesTest >> setUp [

	super setUp.
	reader := XHTMLNamedEntities new.	
]

{ #category : #test }
XHTMLNamedEntitiesTest >> testNamedEntitiesFilename [

	self assert: (self reader namedEntitiesFilename isKindOf: FileReference).
	self assert: self reader namedEntitiesFilename exists.
]

{ #category : #test }
XHTMLNamedEntitiesTest >> testReadNamedEntities [

	| neDictionary neItemFirst neItemLast |
	
	neDictionary := self reader readNamedEntities.
	neItemFirst := (neDictionary keyAtValue: '&sharp;') asString utf8Encoded.
	neItemLast := (neDictionary keyAtValue: '&NotTildeFullEqual;') asString utf8Encoded.
	self assert: (neDictionary isKindOf: Dictionary).
	self deny: neDictionary isEmpty.
	self assert: neItemFirst equals: #[226 153 175].
	self assert: neItemLast equals: #[226 137 135].

]
