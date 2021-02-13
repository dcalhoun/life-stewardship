import PostRes from "../../components/Post.bs";

export { getServerSideProps } from "../../components/Post.bs";

export default function Post(props) {
  return <PostRes {...props} />;
}
