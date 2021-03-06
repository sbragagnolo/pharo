"
Visual tests for correct rendering of text using Athens
"
Class {
	#name : #AthensTextRenderManualTests,
	#superclass : #Object,
	#category : #'Athens-Examples-Demos'
}

{ #category : #utilities }
AthensTextRenderManualTests class >> surfaceClass [
	^ AthensCairoSurface
]

{ #category : #tests }
AthensTextRenderManualTests class >> test1 [
	<example>
	
	|  t  c  |
	t := '
AthensTextRenderTest test1

leftFlush
p := MultiNewParagraph new.

p compose: t
	style: TextStyle default
	from: 1
	in: (0@0 corner: 100@100).
p

MultiNewParagraph
TextStyle default alignment


globalBounds:  toLocal: 
' asText.

	t addAttribute: (TextColor new color: Color red) from: 3 to: 10.
	t addAttribute: (TextEmphasis italic) from: 5 to: 13.
	c := AthensTextComposer scan: t for: AthensTextScanner new.
	AthensSceneView new
		scene:  [:canvas |
			canvas pathTransform scaleBy: 0.8.
			c renderOn: canvas ];
	openInWindow
]

{ #category : #tests }
AthensTextRenderManualTests class >> test2 [
	<example>
	
	| t c surf |
	t := self testText. 
	t addAttribute: (AthensTextBackground new color: (Color green alpha: 0.3 )) from: 1 to: 267.
	c := AthensTextComposer scan: t for: AthensTextScanner new.
	surf := self surfaceClass extent: 500@300.
	surf drawDuring: [ :canvas | 
		canvas setPaint: (Color white).
		canvas drawShape: (0@0 corner: 500@300).
		canvas pathTransform scaleBy: 1.
		canvas pathTransform translateX: 0 Y: 0.
		canvas setPaint: Color yellow.
		canvas pathTransform rotateByDegrees: 0.
		c renderOn: canvas
	].

	surf asForm asMorph openInWindow
]

{ #category : #tests }
AthensTextRenderManualTests class >> test3 [
	<example>
	
	| t  c surf |
	t := 'qW' asText.
	t addAttribute: (TextFontReference toFont: (LogicalFont familyName: 'Arial' pointSize: 8)).
	c := AthensTextComposer scan: t for: AthensTextScanner new.
	surf := self surfaceClass extent: 500@500.
	surf drawDuring: [ :canvas | 
		canvas setPaint: (Color yellow alpha: 0.5).
		canvas drawShape: (0@0 corner: 300@300).
		canvas pathTransform translateBy: 200@200.
		canvas pathTransform scaleBy: 4.
		1 to: 10 do: [:i |
			canvas setPaint: (Color blue alpha: 0.5).
			canvas drawShape: (0@0 corner: 100@10).
			c renderOn: canvas.
			canvas pathTransform rotateByDegrees: 5. 
			canvas pathTransform translateBy: 0 @11.
		].
	].
	surf asForm asMorph openInWindow


]

{ #category : #tests }
AthensTextRenderManualTests class >> test4 [
	<example>
	
	| t  c surf |
	t := 'Unfortunately this class has not been documented yet.' asText.
	t addAttribute: (TextFontReference toFont: (LogicalFont familyName: 'Tahoma' pointSize: 10)).
	t addAttribute: (TextColor new color: Color red) from: 3 to: 10.
	c := AthensTextComposer scan: t for: AthensTextScanner new.
	surf := self surfaceClass extent: 500@500.
	surf drawDuring: [ :canvas | 
		canvas setPaint: (Color yellow alpha: 0.5).
		canvas drawShape: (0@0 corner: 300@300).
		canvas pathTransform scaleBy: 1.
		1 to: 20 do: [:i |
			c renderOn: canvas.
			canvas pathTransform translateBy: 0.1@10.
		]
	].
	surf asForm asMorph openInWindow


]

{ #category : #tests }
AthensTextRenderManualTests class >> test5 [
	<example>
	
	| t  c surf |
	t := 'U' asText.
	t addAttribute: (TextFontReference toFont: (LogicalFont familyName: 'Tahoma' pointSize: 10)).
	c := AthensTextComposer scan: t for: AthensTextScanner new.
	surf := self surfaceClass extent: 500@500.
	surf drawDuring: [ :canvas | 
		canvas setPaint: (Color yellow alpha: 0.5).
		canvas drawShape: (0@0 corner: 300@300).
		canvas pathTransform scaleBy: 1.
		1 to: 20 do: [:i |
			c renderOn: canvas.
			canvas pathTransform translateBy: 10@0.1.
		]
	].
	surf asForm asMorph openInWindow


]

{ #category : #tests }
AthensTextRenderManualTests class >> testBlitting [
	<example>
	
	| fnt form blt dstForm |
	fnt := LogicalFont familyName: 'Source Sans Pro' pointSize: 50.

	form := fnt realFont
		glyphOf: $W
				destDepth: 8
				colorValue: 1
				subpixelPosition: 0.

	dstForm := Form extent: 300@300 depth: 32.
	blt := BitBlt toForm: dstForm.
	
	blt 
		sourceForm: form;
		destOrigin: 0@0;
		sourceOrigin: 0@0;
		halftoneForm: nil;
		combinationRule: 41;
		width: form width;
		height: form height;		
		copyBitsColor: 0
		alpha: 255
		gammaTable:  FreeTypeSettings current gammaTable
		ungammaTable: FreeTypeSettings current gammaInverseTable.
	
	dstForm asMorph openInWindow
	

	
	

]

{ #category : #tests }
AthensTextRenderManualTests class >> testText [
	
	|  t  |
	t := 'The safety constraint is that the garbage collector 
MUST NOT collect any storage that then becomes needed to continue correct execution of the program. Should weak references 
be added, then garbage collection decisions become observable. 
Based on a suggestion from Cameron McCormack, we state the 
safety constraint as follows: So long as operational semantics of 
the remainder of the program execution includes the possibility that 
a reference to an object X may be dereferenced, then X MUST NOT 
be collected. Thus, the garbage collector is allowed to ignore any 
references that remain present in the semantic state, but which it 
can ascertain will never be dereferenced in any possible execution. 
This sets an upper bound on what state MAY be collected. Put 
another way, if the garbage collector ever reports that X has been 
collected, such as by nullifying a weak reference to X, if operational 
semantics of remaining execution requires the traversal of a strong 
(non-weak) reference to X, then the previous report demonstrates a 
safety violation. 
' asText.
	t addAttribute: (TextFontReference toFont: (LogicalFont familyName: 'Arial' pointSize: 8)).
	t addAttribute: (TextEmphasis italic) from: 5 to: 100.
	t addAttribute: (TextColor new color: (Color red)) from: 10 to: 60.
	t addAttribute: (TextEmphasis italic) from: 100 to: 200.
	t addAttribute: (TextColor new color: Color green) from: 230 to: 360.
	t addAttribute: (TextFontReference toFont: ( LogicalFont familyName: 'Tahoma'  pointSize: 14)) from: 88 to: 200.
	^ t
]

{ #category : #tests }
AthensTextRenderManualTests class >> testWindow [
	<example>
	| presenter window |
	presenter := SpTextPresenter new
		text: self testText;
		yourself.
	window := presenter openWithSpec.

	presenter withWindowDo: [ :w | w title: 'A fancy looking title text' ].

	^ window window
]

{ #category : #tests }
AthensTextRenderManualTests class >> testWindowRender [
	<example>
	
	| surf win |
	win := self testWindow.
	surf := self surfaceClass extent: win extent.
	win position: 0@0.

	surf drawDuring: [ :canvas | 
		canvas pathTransform scaleBy: 1.
		canvas fullDrawMorph: win.
	].

	surf asForm asMorph openInWindow


]
