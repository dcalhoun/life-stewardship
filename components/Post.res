type params = {slug: string}

let getServerSideProps: Next.GetServerSideProps.t<
  WordPress.response,
  params,
  'previewData,
> = ctx => {
  let {params} = ctx
  open Js.Promise
  WordPress.Api.fetchPosts(~slug=params.slug, ())->then_(((data, error)) => {
    let props: WordPress.response = {error: error, data: data}
    resolve({"props": props})
  }, _)
}

let default = (props: WordPress.response): React.element => {
  let {data, error} = props
  <Layout>
    {switch (data->Js.Nullable.toOption, error->Js.Nullable.toOption) {
    | (_, Some({message})) => <Paragraph> {message->React.string} </Paragraph>
    | (None, None) => <Paragraph> {"Loading"->React.string} </Paragraph>
    | (Some(posts), _) when Array.length(posts) > 0 => {
        let {title, featuredImage, date, content} = posts->Array.get(0)
        let filteredTitle = Js.String.replaceByRe(%re("/&nbsp;/g"), " ", title.rendered)
        <>
          <SEO title=filteredTitle />
          <h1 className={Heading.Styles.primary ++ " mb-5 text-center"}>
            {filteredTitle->React.string}
          </h1>
          <Paragraph className="block mx-auto text-center text-gray-700">
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
