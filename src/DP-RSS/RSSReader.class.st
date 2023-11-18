Class {
	#name : #RSSReader,
	#superclass : #Object,
	#instVars : [
		'feedList'
	],
	#category : #'DP-RSS-rss'
}

{ #category : #updating }
RSSReader >> addFeed: aURL [
	| aFeed |
	((self searchFeeds: aURL) isEmpty) ifFalse: [^ self ].
	aFeed := RSSChannel new getFeed: aURL.
	feedList add: aFeed.
]

{ #category : #accessing }
RSSReader >> feedList [
	^ feedList
]

{ #category : #accessing }
RSSReader >> feedList: anOrderedCollection [
	feedList := anOrderedCollection
]

{ #category : #accessing }
RSSReader >> gtViewChannelNamesOn: aView [
	<gtView>
	^ aView list
		title: 'Feeds' translated;
		priority: 8;
		items: [ self feedList ];
		itemText: [ :aFeed | aFeed title asRopedText]
]

{ #category : #initializing }
RSSReader >> initialize [
	^ self feedList: OrderedCollection new;
	yourself
]

{ #category : #accessing }
RSSReader >> searchFeeds: aURL [
	^ feedList select: [ :aFeed |
		(aFeed url) = aURL].
]
