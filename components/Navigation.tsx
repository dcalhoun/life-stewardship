import Link from "next/link";

export default function Navigation() {
  return (
    <>
      <a href="#content">Skip to content</a>
      <nav>
        <Link href="/">
          <a>About</a>
        </Link>{" "}
        <Link href="/nonprofit">
          <a>Nonprofit</a>
        </Link>{" "}
        <Link href="/individuals">
          <a>Individuals</a>
        </Link>{" "}
        <Link href="/contact">
          <a>Contact</a>
        </Link>
      </nav>
    </>
  );
}
