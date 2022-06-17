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
BaselineOfXHTMLNamedEntities >> neoCsv: spec [ 

	spec
		baseline: 'NeoCSV'
		with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
]

{ #category : #baselines }
BaselineOfXHTMLNamedEntities >> postLoad [
	"Download required TSV file"
	"postLoadDoIt: #'postLoadDoIt';"
	
	ZnClient get: ''
]
