@module("@wp-headless/client") @new
external createWpClient: string => 'wpClient = "default"

let apiUrl = "https://public-api.wordpress.com/rest/v1.1/"
let apiNamespace = "sites/calhounchronicles.wordpress.com"

let client = createWpClient(apiUrl)

type post = {
  content: string,
  date: string,
  excerpt: string,
  @as("ID") id: string,
  slug: string,
  title: string,
}

type props = {posts: array<post>}

let getServerSideProps: Next.GetServerSideProps.t<props, 'params, 'previewData> = _ctx => {
  client["namespace"](apiNamespace)["posts"]()["get"]()->Js.Promise.then_(posts => {
    let props = {posts: posts.posts}
    Js.Promise.resolve({"props": props})
  }, _)
}

module Post = {
  @react.component
  let make = (~excerpt, ~title) => {
    <article className="mb-8">
      <h2 className=Heading.Styles.secondary> {title->React.string} </h2>
      <div dangerouslySetInnerHTML={{"__html": excerpt}} />
    </article>
  }
}

let default = (props: props): React.element => {
  <Layout>
    <SEO title="Blog" description="The latest news from Life Stewardship LLC." />
    <h1 className={Heading.Styles.primary ++ " mb-8"}> {"Blog"->React.string} </h1>
    <div>
      {props.posts
      ->Belt.Array.map(({excerpt, id, title}) => <Post key=id excerpt title />)
      ->React.array}
    </div>
  </Layout>
}
