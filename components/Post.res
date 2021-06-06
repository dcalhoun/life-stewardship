type props = {error: Js.Nullable.t<string>, data: Js.Nullable.t<WordPress.posts>}
type params = {slug: string}

let getServerSideProps: Next.GetServerSideProps.t<props, params, 'previewData> = ctx => {
  let {params} = ctx
  open Js.Promise
  WordPress.Api.fetchPosts(~slug=params.slug, ())->then_(((data, error)) => {
    let props = {error: error, data: data}
    resolve({"props": props})
  }, _)
}

let default = (props: props): React.element => {
  let {data, error} = props
  <Layout>
    {switch (data->Js.Nullable.toOption, error->Js.Nullable.toOption) {
    | (None, Some(message)) => <div> {message->React.string} </div>
    | (None, None) => <div> {"Loading"->React.string} </div>
    | (Some(posts), _) when Array.length(posts) > 0 => {
        let {title, content} = posts->Array.get(0)
        <>
          <SEO title=title.rendered />
          <h1 className={Heading.Styles.primary ++ " mb-8"}>
            {title.rendered |> Js.String.replaceByRe(%re("/&nbsp;/g"), " ") |> React.string}
          </h1>
          <div className="post" dangerouslySetInnerHTML={{"__html": content.rendered}} />
        </>
      }
    | (Some(_empty), _) => <div> {"Not found"->React.string} </div>
    }}
  </Layout>
}
