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

  let postsUrl = "https://public-api.wordpress.com/wp/v2/sites/lifestewardshipllc.wordpress.com/posts"

  let fetchPosts = (~slug=?, ()) => {
    let url = switch slug {
    | Some(slug) => postsUrl ++ "?slug=" ++ slug
    | _ => postsUrl
    }
    open Js.Promise
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
