import { useEntityProp } from "@wordpress/core-data";

export default function PostPreviewEdit({ context: { postType, postId } }) {
  const [title] = useEntityProp("postType", postType, "title", postId);
  const [link] = useEntityProp("postType", postType, "link", postId);

  return (
    <article>
      <a href={link}>
        <h2>{title}</h2>
      </a>
    </article>
  );
}
