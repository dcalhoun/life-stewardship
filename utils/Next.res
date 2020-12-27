module Link = {
  @bs.module("next/link") @react.component
  external make: (
    ~href: string=?,
    ~_as: string=?,
    ~prefetch: option<bool>=?,
    ~replace: option<bool>=?,
    ~shallow: option<bool>=?,
    ~passHref: option<bool>=?,
    ~children: React.element,
  ) => React.element = "default"
}

module Head = {
  @bs.module("next/head") @react.component
  external make: (~children: React.element) => React.element = "default"
}

type eventName = [
  | #routeChangeStart
  | #routeChangeComplete
  | #routeChangeError
  | #beforeHistoryChange
  | #hashChangeStart
  | #hashChangeComplete
]

type events = {
  on: (eventName, string => unit) => unit,
  off: (eventName, string => unit) => unit,
}

type router = {
  asPath: string,
  back: unit => unit,
  beforePopState: ((string, string, {.}) => bool) => unit,
  events: events,
  pathname: string,
  prefetch: (string, string),
  push: (string, string, {"shallow": bool}),
  query: {.},
  reload: unit => unit,
  replace: (string, string, {"shallow": bool}),
}

@bs.module("next/router") external useRouter: unit => router = "useRouter"

module Image = {
  @bs.module("next/image") @react.component
  external make: (
    ~alt: string=?,
    ~className: string=?,
    ~height: int,
    ~layout: [#fixed | #intrinsic | #responsive | #fill]=?,
    ~loading: [#\"lazy" | #eager]=?,
    ~objectFit: string=?,
    ~objectPosition: string=?,
    ~priority: bool=?,
    ~quality: int=?,
    ~sizes: string=?,
    ~src: string,
    ~unoptimized: bool=?,
    ~width: int,
  ) => React.element = "default"
}
