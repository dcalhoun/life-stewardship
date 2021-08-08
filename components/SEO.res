@val @scope(("process", "env"))
external nodeEnv: string = "NODE_ENV"

let siteTitle = "Life Stewardship, Financial Planning & Coaching"
let siteDescription = "Life Stewardship LLC is a financial service firm located in Madison, Mississippi."
let siteOrigin =
  nodeEnv === "production" ? "https://lifestewardshipllc.com" : "http://localhost:3000"

@react.component
let make = (
  ~description: option<string>=?,
  ~image: option<string>=?,
  ~imageAlt: option<string>=?,
  ~imageHeight: option<string>=?,
  ~imageWidth: option<string>=?,
  ~title: option<string>=?,
) => {
  let router = Next.useRouter()
  let title = title->Belt.Option.mapWithDefault(siteTitle, title => title ++ (" | " ++ siteTitle))
  let description = description->Belt.Option.getWithDefault(siteDescription)

  <Next.Head>
    <title key="title"> {title->React.string} </title>
    <meta key="description" name="description" content=description />
    <meta key="og:description" property="og:description" content=description />
    <meta
      key="og:image:height"
      property="og:image:height"
      content={imageHeight->Belt.Option.getWithDefault("630")}
    />
    <meta
      key="og:image:width"
      property="og:image:width"
      content={imageWidth->Belt.Option.getWithDefault("1200")}
    />
    <meta
      key="og:image:alt"
      property="og:image:alt"
      content={imageAlt->Belt.Option.getWithDefault(siteTitle)}
    />
    <meta
      key="og:image"
      property="og:image"
      content={image->Belt.Option.getWithDefault(siteOrigin ++ "/social-share.png")}
    />
    <meta key="og:title" property="og:title" content=title />
    <meta key="og:type" property="og:type" content="website" />
    <meta key="og:url" property="og:url" content={siteOrigin ++ router.pathname} />
    <meta key="twitter:card" name="twitter:card" content="summary" />
    <meta key="twitter:description" name="twitter:description" content=description />
    <meta key="twitter:title" name="twitter:title" content=title />
  </Next.Head>
}
