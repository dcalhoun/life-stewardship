@module("@wp-headless/client") @new
external createWpClient: string => 'wpClient = "default"

let apiUrl = "https://public-api.wordpress.com/rest/v1.1/"
let apiNamespace = "sites/lifestewardshipllc.wordpress.com"

let client = createWpClient(apiUrl)

type renderedContent = {rendered: string}

type post = {
  content: renderedContent,
  date: string,
  excerpt: renderedContent,
  id: string,
  slug: string,
  title: renderedContent,
}

type posts = array<post>

type props = {posts: posts}

external decodePost: Js.Json.t => post = "%identity"

let getServerSideProps: Next.GetServerSideProps.t<props, 'params, 'previewData> = ctx => {
  let {req} = ctx
  let baseUrl =
    req.headers.xForwardProto->Belt.Option.getWithDefault("http") ++ "://" ++ req.headers.host
  open Js.Promise
  Fetch.fetch(baseUrl ++ "/api/posts")->then_(Fetch.Response.json, _)->then_(json => {
    switch Js.Json.classify(json) {
    | Js.Json.JSONArray(array) => resolve(Array.map(decodePost, array))
    | _ => resolve([])
    }
  }, _)->then_(posts => {
    let props = {posts: posts}
    resolve({"props": props})
  }, // Js.log2("> SUCCESS", posts)

  _)->catch(_error => {
    let props = {posts: []}
    resolve({"props": props})
  }, // Js.log2("> ERROR", error)

  _)
}

module Post = {
  @react.component
  let make = (~excerpt, ~slug, ~title) => {
    <article className="mb-8">
      <Next.Link href={"/blog/" ++ slug}>
        <a>
          <h2 className=Heading.Styles.secondary>
            {title.rendered |> Js.String.replaceByRe(%re("/&nbsp;/g"), " ") |> React.string}
          </h2>
        </a>
      </Next.Link>
      <div dangerouslySetInnerHTML={{"__html": excerpt.rendered}} />
    </article>
  }
}

let default = (props: props): React.element => {
  <Layout>
    <SEO title="Blog" description="The latest news from Life Stewardship LLC." />
    <h1 className={Heading.Styles.primary ++ " mb-8"}> {"Blog"->React.string} </h1>
    <div>
      {props.posts
      ->Belt.Array.map(({excerpt, id, slug, title}) => <Post key=id excerpt slug title />)
      ->React.array}
    </div>
  </Layout>
}
