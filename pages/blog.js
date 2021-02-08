import BlogRes from "../components/Blog.bs";

export { getServerSideProps } from "../components/Blog.bs";

export default function Blog(props) {
  return <BlogRes {...props} />;
}
