@react.component
let make = (
  ~posts: Js.Nullable.t<WordPress.posts>,
  ~error: Js.Nullable.t<WordPress.error>,
  ~preview,
) =>
  <Layout preview={preview}>
    {switch (posts->Js.Nullable.toOption, error->Js.Nullable.toOption) {
    | (_, Some({message})) => <Paragraph> {message->React.string} </Paragraph>
    | (None, None) => <Paragraph> {"Loading"->React.string} </Paragraph>
    | (Some(posts), _) if Belt.Array.length(posts) > 0 => {
        let {title, featuredImage, date, status, content} = posts[0]
        let filteredTitle =
          title.rendered
          ->Js.String2.replaceByRe(%re("/&nbsp;/g"), " ")
          ->Js.String2.replaceByRe(%re("/Private:\s/g"), "")
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
