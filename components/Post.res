@module("@wp-headless/client") @new
external createWpClient: string => 'wpClient = "default"

let apiUrl = "https://public-api.wordpress.com/wp/v2/"
let apiNamespace = "sites/calhounchronicles.wordpress.com"

let client = createWpClient(apiUrl)

type renderedContent = {rendered: string}

type props = {
  content: renderedContent,
  date: string,
  excerpt: string,
  @as("ID") id: string,
  slug: string,
  title: renderedContent,
}

type params = {slug: string}

let getServerSideProps: Next.GetServerSideProps.t<props, params, 'previewData> = ctx => {
  let {params} = ctx
  client["namespace"](apiNamespace)["posts"]()["slug"](params.slug)->Js.Promise.then_(post => {
    let props = post
    Js.Promise.resolve({"props": props})
  }, _)
}

let default = (props: props): React.element => {
  <Layout>
    <SEO title=props.title.rendered />
    <h1 className={Heading.Styles.primary ++ " mb-8"}> {props.title.rendered->React.string} </h1>
    <div className="post" dangerouslySetInnerHTML={{"__html": props.content.rendered}} />
  </Layout>
}
