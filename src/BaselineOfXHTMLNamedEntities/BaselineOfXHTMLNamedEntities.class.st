Class {
	#name : #BaselineOfXHTMLNamedEntities,
	#superclass : #BaselineOf,
	#category : #BaselineOfXHTMLNamedEntities
}

{ #category : #baselines }
BaselineOfXHTMLNamedEntities >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec postLoadDoIt: #'postLoad'.	
			self neoCsv: spec.
			spec 
				package: 'XHTMLNamedEntities' 			with: [ spec requires: #(NeoCSV) ];
				package: 'XHTMLNamedEntities-Tests'	with: [ spec requires: #(XHTMLNamedEntities) ].
			spec 
				group: 'Core' 						with: #('XHTMLNamedEntities');
				group: 'Tests' 						with: #('XHTMLNamedEntities' 'XHTMLNamedEntities-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]

{ #category : #baselines }
BaselineOfXHTMLNamedEntities >> httpClient [

	^ ZnClient new
		accept: ZnMimeType text;	
		systemPolicy;
		signalProgress: true;	
		ifFail: [ :exception | self error: 'Could not download : ', exception printString ]
		yourself.
]

{ #category : #baselines }
BaselineOfXHTMLNamedEntities >> namedEntitiesResource [

	^ 'https://raw.githubusercontent.com/hernanmd/html5-named-entities/master/named_entities.csv'
]

{ #category : #baselines }
BaselineOfXHTMLNamedEntities >> neoCsv: spec [ 

	spec
		baseline: 'NeoCSV'
		with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
]

{ #category : #baselines }
BaselineOfXHTMLNamedEntities >> postLoad [
	"Download required TSV file"
	
	self httpClient 
		url: self namedEntitiesResource asZnUrl;
		downloadTo: FileLocator imageDirectory
	
]
