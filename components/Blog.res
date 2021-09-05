type params = {p: option<string>}
type layout = List | Detail
type props = {
  error: Js.Nullable.t<WordPress.error>,
  data: Js.Nullable.t<WordPress.posts>,
  layout: layout,
  preview: bool,
}

let getStaticProps: Next.GetStaticProps.t<props, params, 'previewData> = ({preview, params}) => {
  open Promise
  WordPress.Api.fetchPosts(~preview=preview->Belt.Option.getWithDefault(false), ())->then(((
    data,
    error,
  )) => {
    let props = {
      error: error,
      data: data,
      // TODO: Remove, layout with None is a no-op
      layout: switch None {
      | Some(_) => Detail
      | None => List
      },
      preview: preview->Belt.Option.getWithDefault(false),
    }
    resolve({"props": props, "revalidate": Some(60)})
  })
}

let default = (props: props): React.element => {
  let {data, error, layout, preview} = props
  switch layout {
  | List => <PostList error posts=data preview />
  | Detail => <PostDetail error preview posts=data />
  }
}
