let getStaticProps: Next.GetStaticProps.t<WordPress.response, 'params, 'previewData> = ({
  preview,
}) => {
  open Promise
  WordPress.Api.fetchPosts(~preview=preview->Belt.Option.getWithDefault(false), ())->then(((
    data,
    error,
  )) => {
    let props: WordPress.response = {error: error, data: data}
    resolve({"props": props, "revalidate": Some(60)})
  })
}

module PostExcerpt = {
  @react.component
  let make = (~date, ~featuredImage, ~slug, ~title) => {
    let filteredTitle = Js.String.replaceByRe(%re("/&nbsp;/g"), " ", title)
    <article role="listitem">
      <Next.Link href={"/blog/" ++ slug}>
        <a
          className="group flex items-center mb-4 lg:mb-8"
          title={filteredTitle ++ " - Posted on " ++ date->Date.format}>
          <div
            ariaHidden={true}
            className="flex-shrink-0 aspect-w-1 w-16 h-16 lg:w-24 lg:h-24 mr-2 lg:mr-5 rounded-xl overflow-hidden bg-gray-500"
            style={ReactDOM.Style.make(~maxHeight="150px", ())->ReactDOM.Style.unsafeAddProp(
              "WebkitMaskImage",
              "-webkit-radial-gradient(white, black)",
            )}>
            <Next.Image
              alt="Placeholder"
              className="transform duration-300 transition-transform group-hover:scale-105 group-focus:scale-105"
              layout=#fill
              src={featuredImage == "" ? "/android-chrome-512x512.png" : featuredImage}
            />
          </div>
          <div className="flex-1 max-w-full py-2 lg:py-5">
            <h2 className={Heading.Styles.secondary ++ " truncate"} ariaHidden={true}>
              {Js.String.replaceByRe(%re("/&nbsp;/g"), " ", title)->React.string}
            </h2>
            <p className="text-gray-600 text-base lg:text-xl font-serif">
              <Date dateString=date ariaHidden={true} />
            </p>
          </div>
        </a>
      </Next.Link>
    </article>
  }
}

let default = (props: WordPress.response): React.element => {
  let {data, error} = props
  <Layout>
    <SEO title="Blog" description="The latest news from Life Stewardship LLC." />
    <div className="mx-auto" style={ReactDOM.Style.make(~maxWidth="600px", ())}>
      <h1 className={Heading.Styles.primary ++ " mb-8"}> {"Blog"->React.string} </h1>
      <div role="list">
        {switch (data->Js.Nullable.toOption, error->Js.Nullable.toOption) {
        | (_, Some({message})) => <Paragraph> {message->React.string} </Paragraph>
        | (None, None) => <Paragraph> {"Loading..."->React.string} </Paragraph>
        | (Some(posts), None) if Array.length(posts) > 0 =>
          posts
          ->Belt.Array.map(({date, featuredImage, id, slug, title}) =>
            <PostExcerpt key=id date featuredImage slug title=title.rendered />
          )
          ->React.array
        | (Some(_empty), _) => <Paragraph> {"No posts found."->React.string} </Paragraph>
        }}
      </div>
    </div>
  </Layout>
}
