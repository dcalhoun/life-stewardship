let apiUrl = "https://public-api.wordpress.com/wp/v2/sites/lifestewardshipllc.wordpress.com/posts"

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
type props = {error: Js.Nullable.t<string>, data: posts}

external decodePost: Js.Json.t => post = "%identity"

let getServerSideProps: Next.GetServerSideProps.t<props, 'params, 'previewData> = _ctx => {
  open Js.Promise
  Fetch.fetch(apiUrl)->then_(Fetch.Response.json, _)->then_(json => {
    let posts = switch Js.Json.classify(json) {
    | Js.Json.JSONArray(array) => Array.map(decodePost, array)
    | _ => []
    }
    let props = {data: posts, error: Js.Nullable.null}
    resolve({"props": props})
  }, _)->catch(_error => {
    let props = {data: [], error: Js.Nullable.return("An error occurred.")}
    resolve({"props": props})
  }, _)
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
      {props.data
      ->Belt.Array.map(({excerpt, id, slug, title}) => <Post key=id excerpt slug title />)
      ->React.array}
    </div>
  </Layout>
}
