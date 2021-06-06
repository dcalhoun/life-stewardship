import BlogRes from "../../components/Blog.bs";

export { getStaticProps } from "../../components/Blog.bs";

export default function Blog(props) {
  return <BlogRes {...props} />;
}
