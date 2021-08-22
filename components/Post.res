type params = {slug: string}
type props = {
  error: Js.Nullable.t<WordPress.error>,
  data: Js.Nullable.t<WordPress.posts>,
  preview: bool,
}

let getStaticProps: Next.GetStaticProps.t<props, params, 'previewData> = ctx => {
  let {params, preview} = ctx
  open Js.Promise
  WordPress.Api.fetchPosts(
    ~slug=params.slug,
    ~preview=preview->Belt.Option.getWithDefault(false),
    (),
  )->then_(((data, error)) => {
    let props = {error: error, data: data, preview: preview->Belt.Option.getWithDefault(false)}
    resolve({"props": props, "revalidate": Some(60)})
  }, _)
}

let getStaticPaths: Next.GetStaticPaths.t<params> = () => {
  open Promise
  WordPress.Api.fetchPosts()->then(((data, _error)) => {
    let paths = switch data->Js.Nullable.toOption {
    | Some(posts) =>
      Belt.Array.map(posts, post => {
        let path: Next.GetStaticPaths.path<params> = {params: {slug: post.slug}}
        path
      })
    | None => []
    }
    let return: Next.GetStaticPaths.return<params> = {
      paths: paths,
      fallback: true,
    }
    resolve(return)
  })
}

let default = (props: props): React.element => {
  let {data, error, preview} = props
  <Layout preview={preview}>
    {switch (data->Js.Nullable.toOption, error->Js.Nullable.toOption) {
    | (_, Some({message})) => <Paragraph> {message->React.string} </Paragraph>
    | (None, None) => <Paragraph> {"Loading"->React.string} </Paragraph>
    | (Some(posts), _) if Belt.Array.length(posts) > 0 => {
        let {title, featuredImage, date, status, content} = posts[0]
        let filteredTitle = Js.String.replaceByRe(%re("/&nbsp;|Private:\s/g"), " ", title.rendered)
        <>
          <SEO title=filteredTitle />
          {switch status {
          | "publish"
          | "private" => React.null
          | _ =>
            <div className="text-center mb-5">
              <Badge ariaHidden={true}> {status->React.string} </Badge>
            </div>
          }}
          <h1 className={Heading.Styles.primary ++ " mb-5 text-center"}>
            {filteredTitle->React.string}
          </h1>
          <Paragraph className="block text-center text-gray-700">
            <Date dateString=date />
          </Paragraph>
          {switch featuredImage->String.length {
          | 0 => React.null
          | _ =>
            <div
              className="aspect-w-16 aspect-h-9 mb-5 lg:mb-8 rounded overflow-hidden bg-gray-500">
              <Spread props={{"aria-hidden": true}}>
                <Next.Image layout=#fill src={featuredImage} />
              </Spread>
            </div>
          }}
          <div className="post" dangerouslySetInnerHTML={{"__html": content.rendered}} />
        </>
      }
    | (Some(_empty), _) => <Paragraph> {"Not found."->React.string} </Paragraph>
    }}
    <ContactCTA />
  </Layout>
}
