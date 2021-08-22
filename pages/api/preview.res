@val
external previewToken: string = "process.env.PREVIEW_TOKEN"

type previewData

let default: Next.Api.t = (req, res) => {
  open Next.Res
  switch (req.query->Js.Dict.get("secret"), req.query->Js.Dict.get("slug")) {
  | (Some(secret), Some(slug)) if secret == previewToken =>
    res->setPreviewData(Js.Obj.empty())->redirect("/blog/" ++ slug)
  | (Some(secret), None) if secret == previewToken =>
    res->setPreviewData(Js.Obj.empty())->redirect("/blog")
  | (_, _) => res->status(401)->json(Js.Dict.fromArray([("message", "Invalid token")]))
  }
}
