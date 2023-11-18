Class {
	#name : #RSSItem,
	#superclass : #Object,
	#instVars : [
		'title',
		'description',
		'pubDate',
		'link',
		'creator',
		'comments',
		'guid'
	],
	#category : #'DP-RSS-rss'
}

{ #category : #parsing }
RSSItem class >> elementNamed: aString inNode: aNode [
	| value |
	value := ((aNode elementAt: aString) ifNil: [^ '']).
	((value nodes) size = 1)
		ifTrue: [ ^ value nodes at: 1 ]
		ifFalse: [^ Error new signal: 'RSS Element expecting single node' ].
]

{ #category : #'instance creation' }
RSSItem class >> on: anElement [

	^ self new loadFromElement: anElement
]

{ #category : #accessing }
RSSItem >> comments [
	^ comments
]

{ #category : #accessing }
RSSItem >> comments: aString [
	comments := aString
]

{ #category : #accessing }
RSSItem >> creator [
	^ creator
]

{ #category : #accessing }
RSSItem >> creator: aString [
	creator := aString
]

{ #category : #accessing }
RSSItem >> description [
	^ description
]

{ #category : #accessing }
RSSItem >> description: aString [
	description := aString
]

{ #category : #fetching }
RSSItem >> fetchLinkText [
	| resp |
	resp := ZnClient new get: (self link).
	^ (resp asString).
]

{ #category : #accessing }
RSSItem >> gtViewStoryOn: aView [
	<gtView>
	^ aView textEditor
		title: 'Read';
		priority: 110;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ (self fetchLinkText) asRopedText ];
		actionUpdateButton
]

{ #category : #accessing }
RSSItem >> guid [
	^ guid
]

{ #category : #accessing }
RSSItem >> guid: aString [
	guid := aString
]

{ #category : #accessing }
RSSItem >> initialize [
	^ self title: '';
		description: '';
		pubDate: '';
		link: '';
		creator: '';
		comments: '';
		guid: '';
		yourself
]

{ #category : #accessing }
RSSItem >> link [
	^ link
]

{ #category : #accessing }
RSSItem >> link: aString [
	link := aString
]

{ #category : #parsing }
RSSItem >> loadFromElement: aNode [

	self title: ((self class) elementNamed: 'title' inNode: aNode).
	self link: ((self class) elementNamed: 'link' inNode: aNode).
	self description: ((self class) elementNamed: 'description' inNode: aNode).
	self pubDate: ((self class) elementNamed: 'pubDate' inNode: aNode).
	self guid: ((self class) elementNamed: 'guid' inNode: aNode).
]

{ #category : #accessing }
RSSItem >> pubDate [
	^ pubDate
]

{ #category : #accessing }
RSSItem >> pubDate: aString [
	pubDate := aString
]

{ #category : #accessing }
RSSItem >> title [
	^ title
]

{ #category : #accessing }
RSSItem >> title: aString [
	title := aString
]
