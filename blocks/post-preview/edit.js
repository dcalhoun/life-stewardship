import { useEntityProp } from "@wordpress/core-data";

export default function PostPreviewEdit({ context: { postType, postId } }) {
  const [postTitle] = useEntityProp("postType", postType, "title", postId);

  return (
    <article>
      <a>
        <h2>{postTitle}</h2>
      </a>
    </article>
  );
}
