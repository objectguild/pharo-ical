Class {
	#name : #BaselineOfICal,
	#superclass : #BaselineOf,
	#category : #BaselineOfICal
}

{ #category : #baselines }
BaselineOfICal >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'ObjectGuildGlue' with: [ spec loads: #( 'Core' ); repository: 'gitlab://objectguild/libraries/glue:main' ].

		spec
			package: #'ICal-Core' with: [ spec requires: #('ObjectGuildGlue') ];
			package: #'ICal-Tests' with: [ spec requires: #('ICal-Core') ];
			package: #'ICal-GTInspector' with: [ spec requires: #('ICal-Core') ] ].
]
