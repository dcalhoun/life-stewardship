import { useEntityProp, store as coreStore } from "@wordpress/core-data";
import { useSelect } from "@wordpress/data";

function getMediaSourceUrlBySizeSlug(media, slug) {
  return media?.media_details?.sizes?.[slug]?.source_url || media?.source_url;
}

export default function PostPreviewEdit({ context: { postType, postId } }) {
  const [, , { rendered: title }] = useEntityProp(
    "postType",
    postType,
    "title",
    postId
  );
  const [link] = useEntityProp("postType", postType, "link", postId);
  const [date] = useEntityProp("postType", postType, "date", postId);
  const [imageId] = useEntityProp(
    "postType",
    postType,
    "featured_media",
    postId
  );
  const [iconId] = useEntityProp("root", "site", "site_icon");

  const { image, icon } = useSelect(
    (select) => {
      const { getMedia } = select(coreStore);
      return {
        image: imageId && getMedia(imageId, { context: "view" }),
        icon: iconId && getMedia(iconId, { context: "view" }),
      };
    },
    [imageId, iconId]
  );

  const imageUrl = getMediaSourceUrlBySizeSlug(image, "thumbnail");
  const iconUrl = getMediaSourceUrlBySizeSlug(icon, "thumbnail");

  let imgUrl = "";
  if (imageId && !image) {
    imgUrl = iconUrl;
  } else if (imageId && image) {
    imgUrl = imageUrl;
  } else if (iconId && icon) {
    imgUrl = iconUrl;
  }

  return (
    <article role="listitem">
      <a
        href={link}
        onClick={(event) => event.preventDefault()}
        title={`${title} - Published on ${date}`}
      >
        <img
          aria-hidden="true"
          className="is-style-rounded"
          height="100"
          src={imgUrl}
          width="100"
        />
        )<h2 aria-hidden="true">{title}</h2>
        <time aria-hidden="true">{date}</time>
      </a>
    </article>
  );
}
