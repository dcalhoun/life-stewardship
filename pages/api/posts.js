let apiUrl2 =
  "https://public-api.wordpress.com/wp/v2/sites/lifestewardshipllc.wordpress.com/posts";

export default async (_req, res) => {
  try {
    const response = await fetch(apiUrl2);
    const posts = await response.json();
    res.status(200).json(posts);
  } catch (error) {
    console.log("> ERROR", error);
    res.status(500).json({ error });
  }
};
