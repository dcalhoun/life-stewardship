module GetServerSideProps = {
  module Req = {
    type t
  }

  module Res = {
    type t

    @send external setHeader: (t, string, string) => unit = "setHeader"
    @send external write: (t, string) => unit = "write"
    @send external end: t => unit = "end"
  }

  // See: https://github.com/zeit/next.js/blob/canary/packages/next/types/index.d.ts
  type context<'props, 'params, 'previewData> = {
    params: 'params,
    query: Js.Dict.t<string>,
    preview: option<bool>, // preview is true if the page is in the preview mode and undefined otherwise.
    previewData: Js.Nullable.t<'previewData>,
    req: Req.t,
    res: Res.t,
  }

  type t<'props, 'params, 'previewData> = context<'props, 'params, 'previewData> => Js.Promise.t<{
    "props": 'props,
  }>
}

module GetStaticProps = {
  // See: https://github.com/zeit/next.js/blob/canary/packages/next/types/index.d.ts
  type context<'props, 'params, 'previewData> = {
    params: 'params,
    preview: option<bool>, // preview is true if the page is in the preview mode and undefined otherwise.
    previewData: Js.Nullable.t<'previewData>,
  }

  // The definition of a getStaticProps function
  type t<'props, 'params, 'previewData> = context<'props, 'params, 'previewData> => Js.Promise.t<{
    "props": 'props,
    "revalidate": option<int>,
  }>
}

module GetStaticPaths = {
  // 'params: dynamic route params used in dynamic routing paths
  // Example: pages/[id].js would result in a 'params = { id: string }
  type path<'params> = {params: 'params}

  type return<'params> = {
    paths: array<path<'params>>,
    fallback: bool,
  }

  // The definition of a getStaticPaths function
  type t<'params> = unit => Js.Promise.t<return<'params>>
}

module Link = {
  @module("next/link") @react.component
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
  @module("next/head") @react.component
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

@module("next/router") external useRouter: unit => router = "useRouter"

// TODO: Height and width should be required if layout is not fill
module Image = {
  @module("next/image") @react.component
  external make: (
    ~alt: string=?,
    ~className: string=?,
    ~height: int=?,
    ~layout: [#fixed | #intrinsic | #responsive | #fill]=?,
    ~loading: [#"lazy" | #eager]=?,
    ~objectFit: string=?,
    ~objectPosition: string=?,
    ~priority: bool=?,
    ~quality: int=?,
    ~sizes: string=?,
    ~src: string,
    ~unoptimized: bool=?,
    ~width: int=?,
  ) => React.element = "default"
}
