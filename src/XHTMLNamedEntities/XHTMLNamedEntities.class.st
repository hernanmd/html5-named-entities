"
A small utility to obtain a `Dictionary` of XHTML named entities as defined in [the W3C reference](https://www.w3.org/TR/2011/WD-html5-20110113/named-character-references.html)

# Example 

```language=Pharo
XHTMLNamedEntities new readNamedEntities
```

"
Class {
	#name : #XHTMLNamedEntities,
	#superclass : #Object,
	#category : #XHTMLNamedEntities
}

{ #category : #accessing }
XHTMLNamedEntities >> namedEntitiesFilename [
	"Answer a <FileReference> containing the TSV mappings as defined by W3C"

	^ 'named_entities.csv' asFileReference
]

{ #category : #accessing }
XHTMLNamedEntities >> readNamedEntities [
	"Answer a <Dictionary> with named HTML entities mappings : name -> glyph"

	| htmlChars |
	htmlChars := Dictionary new.
	self namedEntitiesFilename asFileReference readStreamDo: [ :stream |
		self readNamedEntitiesFrom: stream to: htmlChars ].
	^ htmlChars.


]

{ #category : #accessing }
XHTMLNamedEntities >> readNamedEntitiesFrom: stream to: htmlDictionary [
	"Read mappings from stream and write them into htmlDictionary"

	^ (NeoCSVReader on: stream) 
			skip: 11;
			separator: Character tab;
			addField; 
			addField; 
			addField;
			do: [ : rowArray | self readNamedEntityFrom: rowArray to: htmlDictionary ]

]

{ #category : #accessing }
XHTMLNamedEntities >> readNamedEntityFrom: rowArray to: htmlDictionary [
	"Read a mapping from rowArray into htmlDictionary"

	rowArray third
		ifNotNil: [ : char |
			htmlDictionary 
				at: char first 
				put: '&' , rowArray first ]
]
