Class {
	#name : #RSSChannel,
	#superclass : #Object,
	#instVars : [
		'url',
		'title',
		'link',
		'description',
		'docs',
		'generator',
		'lastBuildDate',
		'type',
		'channelItems',
		'version',
		'language',
		'pubDate',
		'copyright',
		'webmaster',
		'managingEditor'
	],
	#category : #'DP-RSS-rss'
}

{ #category : #parsing }
RSSChannel class >> elementNamed: aString inNode: aNode [
	| value |
	value := ((aNode elementAt: aString) ifNil: [^ '']).
	((value nodes) isEmpty) ifTrue: [
		^ (value attributeAt: 'href' ifAbsent: '')].
	((value nodes) size = 1)
		ifTrue: [ ^ value nodes at: 1 ]
		ifFalse: [ ^ Error new signal: 'RSS Element expecting single node' ].
]

{ #category : #instantiation }
RSSChannel class >> onFeed: aURL [
	^ (self new) getFeed: aURL
]

{ #category : #accessing }
RSSChannel >> channelItems [
	^ channelItems
]

{ #category : #accessing }
RSSChannel >> channelItems: anObject [ 
	channelItems := anObject
]

{ #category : #accessing }
RSSChannel >> copyright [
	^ copyright
]

{ #category : #accessing }
RSSChannel >> copyright: aString [
	copyright := aString.
]

{ #category : #accessing }
RSSChannel >> description [
	^ description
]

{ #category : #accessing }
RSSChannel >> description: aString [
	description := aString
]

{ #category : #accessing }
RSSChannel >> docs [
	^ docs
]

{ #category : #accessing }
RSSChannel >> docs: aString [
	docs := aString
]

{ #category : #accessing }
RSSChannel >> generator [
	^ generator
]

{ #category : #accessing }
RSSChannel >> generator: aString [
	generator := aString
]

{ #category : #accessing }
RSSChannel >> getFeed: aURL [
	| resp xmlDocument |
	resp := ZnClient new get: aURL.
	self url: aURL.
	xmlDocument := XMLDOMParser parse: resp.
	self parseFeed: xmlDocument.
]

{ #category : #viewing }
RSSChannel >> gtViewStoriesListOn: aView [
	<gtView>
	^ aView columnedList
		title: 'Current Stories' translated;
		priority: 8;
		items: [ self channelItems ];
		column: 'Title' text: [ :aStory | aStory title ];
		column: 'Published Date' text: [ :aStory | aStory pubDate ]
]

{ #category : #accessing }
RSSChannel >> initialize [
	^ self channelItems: OrderedCollection new;
		description: '';
		docs: '';
		generator: '';
		lastBuildDate: '';
		link: '';
		managingEditor: '';
		title: '';
		type: '';
		copyright: '';
		pubDate: '';
		language: '';
		webmaster: '';
		yourself.
]

{ #category : #accessing }
RSSChannel >> language [
	^ language
]

{ #category : #accessing }
RSSChannel >> language: anObject [ 
	language := anObject
]

{ #category : #accessing }
RSSChannel >> lastBuildDate [
]

{ #category : #accessing }
RSSChannel >> lastBuildDate: aString [
	lastBuildDate := aString
]

{ #category : #accessing }
RSSChannel >> link [
	^ link
]

{ #category : #accessing }
RSSChannel >> link: aURL [
	link := aURL
]

{ #category : #accessing }
RSSChannel >> managingEditor [
	^ managingEditor
]

{ #category : #accessing }
RSSChannel >> managingEditor: aString [
	managingEditor := aString
]

{ #category : #accessing }
RSSChannel >> parseFeed: anXMLDocument [
	| topNode channel |
	topNode := anXMLDocument elementAt: 'rss'.
	self version: (topNode attributeAt: 'version').
	channel := topNode elementAt: 'channel'.
	self title: ((self class) elementNamed: 'title' inNode: channel).
	self link: ((self class) elementNamed: 'link' inNode: channel).
	self description: ((self class) elementNamed: 'description' inNode: channel).
	self language: ((self class) elementNamed: 'language' inNode: channel).
	self pubDate: ((self class) elementNamed: 'pubDate' inNode: channel).
	self lastBuildDate: ((self class) elementNamed: 'lastBuildDate' inNode: channel).
	self docs: ((self class) elementNamed: 'docs' inNode: channel).
	self generator: ((self class) elementNamed: 'generator' inNode: channel).
	self copyright: ((self class) elementNamed: 'copyright' inNode: channel).
	self managingEditor: ((self class) elementNamed: 'managingEditor' inNode: channel).
	self webmaster: ((self class) elementNamed: 'webMaster' inNode: channel).
	
		
	channel elementsAt: 'item' do: [ :thisItem |
		| singleItem |
		singleItem := RSSItem on: thisItem.
		channelItems add: singleItem].
	^ self
]

{ #category : #accessing }
RSSChannel >> pubDate [
	^ pubDate
]

{ #category : #accessing }
RSSChannel >> pubDate: aDate [
	pubDate := aDate
]

{ #category : #accessing }
RSSChannel >> title [
	^ title
]

{ #category : #accessing }
RSSChannel >> title: aString [
	title := aString
]

{ #category : #accessing }
RSSChannel >> type [
	^ type
]

{ #category : #accessing }
RSSChannel >> type: aTypeDescription [
	type := aTypeDescription
]

{ #category : #accessing }
RSSChannel >> url [
	^ url
]

{ #category : #accessing }
RSSChannel >> url: aURL [
	url := aURL
]

{ #category : #accessing }
RSSChannel >> version [
	^ version
]

{ #category : #accessing }
RSSChannel >> version: aVersionNumber [
	version := aVersionNumber
]

{ #category : #accessing }
RSSChannel >> webmaster [
	^ webmaster
]

{ #category : #accessing }
RSSChannel >> webmaster: aString [
	webmaster := aString
]
