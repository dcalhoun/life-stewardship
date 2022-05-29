import { useEntityProp } from "@wordpress/core-data";

export default function PostPreviewEdit({ context: { postType, postId } }) {
  const [, , { rendered: title }] = useEntityProp(
    "postType",
    postType,
    "title",
    postId
  );
  const [link] = useEntityProp("postType", postType, "link", postId);
  const [date] = useEntityProp("postType", postType, "date", postId);

  return (
    <article role="listitem">
      <a
        href={link}
        onClick={(event) => event.preventDefault()}
        title={`${title} - Published on ${date}`}
      >
        <h2 aria-hidden="true">{title}</h2>
        <time aria-hidden="true">{date}</time>
      </a>
    </article>
  );
}
