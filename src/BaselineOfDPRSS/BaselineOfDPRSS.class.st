Class {
	#name : #BaselineOfDPRSS,
	#superclass : #BaselineOf,
	#category : #BaselineOfDPRSS
}

{ #category : #loading }
BaselineOfDPRSS class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'DP-RSS' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfDPRSS >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'DP-RSS'.
			spec package: 'DP-RSS'
		]
]
