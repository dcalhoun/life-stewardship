@val external wpClientId: string = "process.env.WP_CLIENT_ID"
@val external wpClientSecret: string = "process.env.WP_CLIENT_SECRET"
@val external wpAppUsername: string = "process.env.WP_APP_USERNAME"
@val external wpAppPassword: string = "process.env.WP_APP_PASSWORD"

@new external makeUrlSearchParams: string => Fetch.urlSearchParams = "URLSearchParams"

type token = {@as("access_token") accessToken: string}
type renderedContent = {rendered: string}
type post = {
  content: renderedContent,
  date: string,
  excerpt: renderedContent,
  @as("jetpack_featured_media_url") featuredImage: string,
  id: string,
  slug: string,
  status: string,
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
  external decodeToken: Js.Json.t => token = "%identity"
  external decodePost: Js.Json.t => post = "%identity"
  external decodeError: Js.Dict.t<Js.Json.t> => error = "%identity"

  let postsUrl = "https://public-api.wordpress.com/wp/v2/sites/lifestewardshipllc.wordpress.com/posts"
  let previewStatus = "status=publish,private,draft,pending,future"

  let fetchToken = () => {
    let url = "https://public-api.wordpress.com/oauth2/token"
    let params =
      "client_id=" ++
      wpClientId ++
      "&client_secret=" ++
      wpClientSecret ++
      "&grant_type=password" ++
      "&username=" ++
      wpAppUsername ++
      "&password=" ++
      wpAppPassword

    // TODO: Add error handling
    open Promise
    Fetch.fetchWithInit(
      url,
      Fetch.RequestInit.make(
        ~method_=Post,
        ~body=Fetch.BodyInit.makeWithUrlSearchParams(params->makeUrlSearchParams),
        (),
      ),
    )
    ->then(Fetch.Response.json)
    ->then(json => json->decodeToken->resolve)
  }

  let fetchPosts = (~slug=?, ~preview=false, ()) => {
    let url = switch (slug, preview) {
    | (Some(slug), true) => postsUrl ++ "?slug=" ++ slug ++ "&" ++ previewStatus
    | (Some(slug), false) => postsUrl ++ "?slug=" ++ slug
    | (None, true) => postsUrl ++ "?" ++ previewStatus
    | _ => postsUrl
    }

    // TODO: Avoid displaying cryptic error messages like "client_id missing"
    open Promise
    fetchToken()
    ->then(({accessToken}) => {
      Fetch.fetchWithInit(
        url,
        Fetch.RequestInit.make(
          ~headers=Fetch.HeadersInit.make({
            "Authorization": "Bearer " ++ accessToken,
            "Accept": "application/json",
          }),
          (),
        ),
      )
    })
    ->then(Fetch.Response.json)
    ->then(json => {
      let posts = switch Js.Json.classify(json) {
      | Js.Json.JSONArray(array) => Belt.Array.map(array, decodePost)
      | _ => []
      }
      let error = switch Js.Json.classify(json) {
      | Js.Json.JSONObject(object) => object->decodeError->Js.Nullable.return
      | _ => Js.Nullable.null
      }
      resolve((Js.Nullable.return(posts), error))
    })
    ->catch(_error => {
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
