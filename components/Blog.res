type props = {
  error: Js.Nullable.t<WordPress.error>,
  data: Js.Nullable.t<WordPress.posts>,
  preview: bool,
}

let getStaticProps: Next.GetStaticProps.t<props, 'params, 'previewData> = ({preview}) => {
  open Promise
  WordPress.Api.fetchPosts(~preview=preview->Belt.Option.getWithDefault(false), ())->then(((
    data,
    error,
  )) => {
    let props = {error: error, data: data, preview: preview->Belt.Option.getWithDefault(false)}
    resolve({"props": props, "revalidate": Some(60)})
  })
}

let default = (props: props): React.element => {
  let {data, error, preview} = props
  <PostList error posts=data preview />
}
