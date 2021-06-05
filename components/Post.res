type props = {error: Js.Nullable.t<string>, data: Js.Nullable.t<WordPress.post>}
type params = {slug: string}

let getServerSideProps: Next.GetServerSideProps.t<props, params, 'previewData> = ctx => {
  let {params} = ctx
  open Js.Promise
  // What happens if the array is length of zero? What happens when visiting
  // non-existant post?
  WordPress.Api.fetchPosts(~slug=params.slug, ())->then_(((data, error)) => {
    let post = switch data->Js.Nullable.toOption {
    | Some(data) => Js.Nullable.return(data[0])
    | None => Js.Nullable.null
    }
    let props = {error: error, data: post}
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
