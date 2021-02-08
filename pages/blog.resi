type post = {
  content: string,
  date: string,
  excerpt: string,
  @as("ID") id: string,
  slug: string,
  title: string,
}

type props = {posts: array<post>}

let getServerSideProps: Next.GetServerSideProps.t<props, 'params, 'previewData>

let default: props => React.element
