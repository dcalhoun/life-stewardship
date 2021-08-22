@val
external previewToken: string = "process.env.PREVIEW_TOKEN"

type previewData

let default: Next.Api.t = (req, res) => {
  let redirectPath = switch req.query->Js.Dict.get("slug") {
  | Some(slug) => "/blog/" ++ slug
  | None => "/blog/"
  }
  open Next.Res
  switch (req.query->Js.Dict.get("secret"), req.query->Js.Dict.get("disable")) {
  | (Some(secret), _) if secret == previewToken =>
    res->setPreviewData(Js.Obj.empty())->redirect(redirectPath)
  | (_, Some(_)) => res->clearPreviewData->redirect(redirectPath)
  | (_, _) => res->status(401)->json(Js.Dict.fromArray([("message", "Invalid token")]))
  }
}
