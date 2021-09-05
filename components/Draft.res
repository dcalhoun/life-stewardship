type params = {id: string}
type props = {
  error: Js.Nullable.t<WordPress.error>,
  data: Js.Nullable.t<WordPress.posts>,
  preview: bool,
}

let getServerSideProps: Next.GetServerSideProps.t<props, params, 'previewData> = ctx => {
  let {params, preview} = ctx
  open Js.Promise
  WordPress.Api.fetchPosts(
    ~id=params.id,
    ~preview=preview->Belt.Option.getWithDefault(false),
    (),
  )->then_(((data, error)) => {
    let props = {error: error, data: data, preview: preview->Belt.Option.getWithDefault(false)}
    resolve({"props": props})
  }, _)
}

let default = (props: props): React.element => {
  let {data, error, preview} = props
  <PostDetail error preview posts=data />
}
