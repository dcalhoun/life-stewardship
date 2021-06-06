type props = {error: Js.Nullable.t<WordPress.error>, data: Js.Nullable.t<WordPress.posts>}

let getServerSideProps: Next.GetServerSideProps.t<props, 'params, 'previewData> = _ctx => {
  open Js.Promise
  WordPress.Api.fetchPosts()->then_(((data, error)) => {
    let props = {error: error, data: data}
    resolve({"props": props})
  }, _)
}

module PostExcerpt = {
  @react.component
  let make = (~excerpt, ~slug, ~title) => {
    <article className="mb-8">
      <Next.Link href={"/blog/" ++ slug}>
        <a>
          <h2 className=Heading.Styles.secondary>
            {title |> Js.String.replaceByRe(%re("/&nbsp;/g"), " ") |> React.string}
          </h2>
        </a>
      </Next.Link>
      <div dangerouslySetInnerHTML={{"__html": excerpt}} />
    </article>
  }
}

let default = (props: props): React.element => {
  let {data, error} = props
  <Layout>
    <SEO title="Blog" description="The latest news from Life Stewardship LLC." />
    <h1 className={Heading.Styles.primary ++ " mb-8"}> {"Blog"->React.string} </h1>
    <div>
      {switch (data->Js.Nullable.toOption, error->Js.Nullable.toOption) {
      | (_, Some({message})) => <div> {message->React.string} </div>
      | (None, None) => "Loading..."->React.string
      | (Some(posts), None) when Array.length(posts) > 0 =>
        posts
        ->Belt.Array.map(({excerpt, id, slug, title}) =>
          <PostExcerpt key=id excerpt=excerpt.rendered slug title=title.rendered />
        )
        ->React.array
      | (Some(_empty), _) => "No posts"->React.string
      }}
    </div>
  </Layout>
}
