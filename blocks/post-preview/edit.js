import { useEntityProp } from "@wordpress/core-data";

export default function PostPreviewEdit({ context: { postType, postId } }) {
  // @TODO: Why is useEntityProp undefined?
  const [postTitle] = (useEntityProp || window.wp.coreData.useEntityProp)(
    "postType",
    postType,
    "title",
    postId
  );

  return (
    <article>
      <a>
        <h2>{postTitle}</h2>
      </a>
    </article>
  );
}
