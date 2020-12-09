@bs.val external document: Dom.document = "document"

@bs.val external window: Dom.window = "window"

@bs.send external createElement: (Dom.document, string) => Dom.element = "createElement"

@bs.send
external getElementsByTagName: (Dom.document, string) => array<Dom.element> = "getElementsByTagName"

@bs.send external setAttribute: (Dom.element, string, string) => unit = "setAttribute"

type event

@bs.send
external addEventListener: (Dom.element, string, event => unit) => unit = "addEventListener"

@bs.send external appendChild: (Dom.element, Dom.element) => unit = "appendChild"
