import { useEntityProp } from "@wordpress/core-data";

export default function PostPreviewEdit({ context: { postType, postId } }) {
  const [title] = useEntityProp("postType", postType, "title", postId);
  const [link] = useEntityProp("postType", postType, "link", postId);

  return (
    <article role="listitem">
      <a href={link} title={title}>
        <h2 aria-hidden="true">{title}</h2>
      </a>
    </article>
  );
}
