Class {
	#name : #ICGenerator,
	#superclass : #Object,
	#category : #'ICal-Core-Parser'
}

{ #category : #dispatching }
ICGenerator >> addUnknownProperty: aProperty [
	self subclassResponsibility 
]

{ #category : #utilities }
ICGenerator >> asSelector: aString [
	| parts |
	parts := aString substrings: #($-).
	^ String
		streamContents: [ :stream | 
			parts do: [ :each | stream nextPutAll: each asLowercase ].
			stream nextPut: $: ]
]

{ #category : #dispatching }
ICGenerator >> begin: aString [
	self subclassResponsibility
]

{ #category : #productions }
ICGenerator >> contentline: aName parameters: aCollection value: aString [

	| selector |

	selector := self asSelector: aName.
	(self noParameterSelectors includes: selector)
		ifTrue: [
			self
				perform: selector asSymbol
				withArguments: (Array with: aString) ]
		ifFalse: [
			selector := (selector , 'parameters:') asSymbol.
			(self class canUnderstand: selector) 
				ifTrue: [ 
					self
						perform: selector 
						withArguments: (Array with: aString with: aCollection) ]
				ifFalse: [ 
					| property |
					property := ICUnknownProperty new
					 	name: aName ;
						value: aString ;
						parameters: aCollection ;
						yourself.
					self addUnknownProperty: property ] ]
]

{ #category : #utilities }
ICGenerator >> createValue: aString parameters: aDictionary default: aType [
	| iCalType |
	iCalType := aDictionary at: 'VALUE' ifAbsent: [ aType ].
	^self createValue: aString parameters: aDictionary type: iCalType
]

{ #category : #utilities }
ICGenerator >> createValue: aString parameters: aDictionary type: iCalType [
	^(ICConversion propertyClassFor: iCalType)
		fromICalString: aString parameters: aDictionary
]

{ #category : #dispatching }
ICGenerator >> end: aString [
	self subclassResponsibility 
]

{ #category : #dispatching }
ICGenerator >> noParameterSelectors [
	^#(
		'begin:'
		'end:'
	)
]

{ #category : #accessing }
ICGenerator >> product [
	self subclassResponsibility 
]

{ #category : #utilities }
ICGenerator >> splitAtCommas: aString [
	^aString splitAtCommas
]
