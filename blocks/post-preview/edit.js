import { useEntityProp } from "@wordpress/core-data";

export default function PostPreviewEdit({ context: { postType, postId } }) {
  const [postTitle] = useEntityProp("postType", postType, "title", postId);
  const [link] = useEntityProp("postType", postType, "link", postId);

  return (
    <article>
      <a href={link}>
        <h2>{postTitle}</h2>
      </a>
    </article>
  );
}
