module PostExcerpt = {
  @react.component
  let make = (~date, ~featuredImage, ~slug, ~status, ~title) => {
    let filteredTitle = Js.String.replaceByRe(%re("/&nbsp;|Private:\s/g"), " ", title)
    <article role="listitem">
      <Next.Link href={"/blog/" ++ slug}>
        <a
          className="group flex items-center mb-4 lg:mb-8"
          title={filteredTitle ++ " - Posted on " ++ date->Date.format}>
          <div
            ariaHidden={true}
            className="flex-initial flex-shrink-0 aspect-w-1 w-16 h-16 lg:w-24 lg:h-24 mr-2 lg:mr-5 rounded-xl overflow-hidden bg-gray-500"
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
          <div className="flex-initial min-w-0 py-2 lg:py-5">
            <h2 className={Heading.Styles.secondary ++ " truncate"} ariaHidden={true}>
              {filteredTitle->React.string}
            </h2>
            <div className="flex items-center">
              <p className="text-gray-600 text-base lg:text-xl font-serif">
                <Date dateString=date ariaHidden={true} />
              </p>
              {switch status {
              | "publish"
              | "private" => React.null
              | _ => <Badge ariaHidden={true} className="ml-2"> {status->React.string} </Badge>
              }}
            </div>
          </div>
        </a>
      </Next.Link>
    </article>
  }
}

@react.component
let make = (
  ~posts: Js.Nullable.t<WordPress.posts>,
  ~error: Js.Nullable.t<WordPress.error>,
  ~preview,
) =>
  <Layout preview={preview}>
    <SEO title="Blog" description="The latest news from Life Stewardship LLC." />
    <div className="mx-auto" style={ReactDOM.Style.make(~maxWidth="600px", ())}>
      <h1 className={Heading.Styles.primary ++ " mb-8"}> {"Blog"->React.string} </h1>
      <div role="list">
        {switch (posts->Js.Nullable.toOption, error->Js.Nullable.toOption) {
        | (_, Some({message})) => <Paragraph> {message->React.string} </Paragraph>
        | (None, None) => <Paragraph> {"Loading..."->React.string} </Paragraph>
        | (Some(posts), None) if Array.length(posts) > 0 =>
          posts
          ->Belt.Array.map(({date, featuredImage, id, slug, status, title}) =>
            <PostExcerpt key=id date featuredImage slug status title=title.rendered />
          )
          ->React.array
        | (Some(_empty), _) => <Paragraph> {"No posts found."->React.string} </Paragraph>
        }}
      </div>
    </div>
    <ContactCTA />
  </Layout>
