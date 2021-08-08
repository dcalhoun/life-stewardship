import PostRes from "../../components/Post.bs";

export { getStaticProps, getStaticPaths } from "../../components/Post.bs";

export default function Post(props) {
  return <PostRes {...props} />;
}
