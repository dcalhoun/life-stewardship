type props = {error: Js.Nullable.t<WordPress.error>, data: Js.Nullable.t<WordPress.posts>}
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
    | (_, Some({message})) => <div> {message->React.string} </div>
    | (None, None) => <div> {"Loading"->React.string} </div>
    | (Some(posts), _) when Array.length(posts) > 0 => {
        let {title, featuredImage, date, content} = posts->Array.get(0)
        let filteredTitle = Js.String.replaceByRe(%re("/&nbsp;/g"), " ", title.rendered)
        <>
          <SEO title=filteredTitle />
          <h1 className={Heading.Styles.primary ++ " mb-8 text-center"}>
            {filteredTitle->React.string}
          </h1>
          <Paragraph className="block mx-auto text-center text-gray-700 ">
            <Date dateString=date />
          </Paragraph>
          {switch featuredImage->String.length {
          | 0 => React.null
          | _ =>
            <div className="aspect-w-16 aspect-h-9 mb-5">
              <Next.Image alt="Placeholder" layout=#fill src={featuredImage} />
            </div>
          }}
          <div className="post" dangerouslySetInnerHTML={{"__html": content.rendered}} />
        </>
      }
    | (Some(_empty), _) => <div> {"Not found."->React.string} </div>
    }}
  </Layout>
}
