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
  <PostDetail error preview posts=data />
}
