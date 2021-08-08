@val external document: Dom.document = "document"

@val external window: Dom.window = "window"

@send external createElement: (Dom.document, string) => Dom.element = "createElement"

@send
external getElementsByTagName: (Dom.document, string) => array<Dom.element> = "getElementsByTagName"

@send external setAttribute: (Dom.element, string, string) => unit = "setAttribute"

type event

@send
external addEventListener: (Dom.element, string, event => unit) => unit = "addEventListener"

@send external appendChild: (Dom.element, Dom.element) => unit = "appendChild"
