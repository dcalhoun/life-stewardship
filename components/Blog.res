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
  let make = (~date, ~slug, ~title) => {
    let filteredTitle = Js.String.replaceByRe(%re("/&nbsp;/g"), " ", title)
    <article role="listitem">
      <Next.Link href={"/blog/" ++ slug}>
        <a
          className="group flex items-center mb-4 lg:mb-8"
          title={filteredTitle ++ " - Posted on " ++ date->Date.format}>
          <div
            ariaHidden={true}
            className="w-16 h-16 lg:w-24 lg:h-24 mr-2 lg:mr-5 rounded-xl overflow-hidden"
            style={ReactDOM.Style.make(~maxHeight="150px", ())->ReactDOM.Style.unsafeAddProp(
              "-webkit-mask-image",
              "-webkit-radial-gradient(white, black)",
            )}>
            <Next.Image
              alt="Placeholder"
              className="transform duration-300 transition-transform group-hover:scale-105 group-focus:scale-105"
              height=150
              layout=#responsive
              src="/android-chrome-512x512.png"
              width=150
            />
          </div>
          <div className="flex-1 py-2 lg:py-5">
            <h2 className=Heading.Styles.secondary ariaHidden={true}>
              {Js.String.replaceByRe(%re("/&nbsp;/g"), " ", title)->React.string}
            </h2>
            <Date dateString=date ariaHidden={true} />
          </div>
        </a>
      </Next.Link>
    </article>
  }
}

let default = (props: props): React.element => {
  let {data, error} = props
  <Layout>
    <SEO title="Blog" description="The latest news from Life Stewardship LLC." />
    <h1 className={Heading.Styles.primary ++ " mb-8"}> {"Blog"->React.string} </h1>
    <div role="list">
      {switch (data->Js.Nullable.toOption, error->Js.Nullable.toOption) {
      | (_, Some({message})) => <div> {message->React.string} </div>
      | (None, None) => "Loading..."->React.string
      | (Some(posts), None) when Array.length(posts) > 0 =>
        posts
        ->Belt.Array.map(({date, id, slug, title}) =>
          <PostExcerpt key=id date slug title=title.rendered />
        )
        ->React.array
      | (Some(_empty), _) => "No posts"->React.string
      }}
    </div>
  </Layout>
}
