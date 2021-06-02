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
type props = {error: Js.Nullable.t<string>, data: Js.Nullable.t<post>}
type params = {slug: string}

external decodePost: Js.Json.t => post = "%identity"

let getServerSideProps: Next.GetServerSideProps.t<props, params, 'previewData> = ctx => {
  let {params} = ctx
  open Js.Promise
  Fetch.fetch(apiUrl ++ "?slug=" ++ params.slug)->then_(Fetch.Response.json, _)->then_(json => {
    let post = switch Js.Json.classify(json) {
    | Js.Json.JSONArray(array) => Array.map(decodePost, array)[0]->Js.Nullable.return
    | _ => Js.Nullable.null
    }
    let props = {error: Js.Nullable.null, data: post}
    resolve({"props": props})
  }, _)->catch(_error => {
    let props = {data: Js.Nullable.null, error: Js.Nullable.return("An error occurred.")}
    resolve({"props": props})
  }, _)
}

let default = (props: props): React.element => {
  let {data, error} = props
  <Layout>
    {switch (data->Js.Nullable.toOption, error->Js.Nullable.toOption) {
    | (None, Some(message)) => <div> {message->React.string} </div>
    | (None, None) => <div> {"Loading"->React.string} </div>
    | (Some(post), _) => <>
        <SEO title=post.title.rendered />
        <h1 className={Heading.Styles.primary ++ " mb-8"}>
          {post.title.rendered |> Js.String.replaceByRe(%re("/&nbsp;/g"), " ") |> React.string}
        </h1>
        <div className="post" dangerouslySetInnerHTML={{"__html": post.content.rendered}} />
      </>
    }}
  </Layout>
}
