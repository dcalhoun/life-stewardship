type renderedContent = {rendered: string}
type post = {
  content: renderedContent,
  date: string,
  excerpt: renderedContent,
  @as("jetpack_featured_media_url") featuredImage: string,
  id: string,
  slug: string,
  title: renderedContent,
}
type posts = array<post>

type errorData = {status: int}
type error = {
  code: string,
  message: string,
  data: option<errorData>,
}

type response = {error: Js.Nullable.t<error>, data: Js.Nullable.t<posts>}

module Api = {
  external decodePost: Js.Json.t => post = "%identity"
  external decodeError: Js.Dict.t<Js.Json.t> => error = "%identity"

  let postsUrl = "https://public-api.wordpress.com/wp/v2/sites/lifestewardshipllc.wordpress.com/posts"

  type fetchPosts<'return, 'error> = (~slug: option<string>) => ('return, 'error)

  let fetchPosts = (~slug=?, ()) => {
    let url = switch slug {
    | Some(slug) => postsUrl ++ "?slug=" ++ slug
    | _ => postsUrl
    }
    open Promise
    Fetch.fetch(url)->then(Fetch.Response.json)->then(json => {
      let posts = switch Js.Json.classify(json) {
      | Js.Json.JSONArray(array) => Belt.Array.map(array, decodePost)
      | _ => []
      }
      let error = switch Js.Json.classify(json) {
      | Js.Json.JSONObject(object) => object->decodeError->Js.Nullable.return
      | _ => Js.Nullable.null
      }
      resolve((Js.Nullable.return(posts), error))
    })->catch(_error => {
      resolve((
        Js.Nullable.null,
        Js.Nullable.return({
          code: "network_request_failure",
          message: "An error occurred.",
          data: None,
        }),
      ))
    })
  }
}
