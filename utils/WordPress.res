type renderedContent = {rendered: string}
type post = {
  content: renderedContent,
  date: string,
  excerpt: renderedContent,
  id: string,
  slug: string,
  title: renderedContent,
}
type posts = array<post>

module Api = {
  external decodePost: Js.Json.t => post = "%identity"

  let apiUrl = "https://public-api.wordpress.com/wp/v2/sites/lifestewardshipllc.wordpress.com/posts"

  // type fetchPosts<'data, 'error> = (~slug: option<string>, unit) => ('data, 'error)
  // type fetchPosts = (~slug: option<string>, unit) => (option<posts>, option<string>)

  let fetchPosts = (~slug=?, ()): Js.Promise.t<(Js.Nullable.t<posts>, Js.Nullable.t<string>)> => {
    open Js.Promise
    let url = switch slug {
    | Some(slug) => apiUrl ++ "?slug=" ++ slug
    | _ => apiUrl
    }
    Fetch.fetch(url)->then_(Fetch.Response.json, _)->then_(json => {
      let posts = switch Js.Json.classify(json) {
      | Js.Json.JSONArray(array) => Array.map(decodePost, array)
      | _ => []
      }
      resolve((Js.Nullable.return(posts), Js.Nullable.null))
    }, _)->catch(_error => {
      resolve((Js.Nullable.null, Js.Nullable.return("An error occurred.")))
    }, _)
  }
}
