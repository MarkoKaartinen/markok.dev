# MarkoK.dev

Welcome to my small piece of Internet. Here we have something about Internet, games, web development and all the other stuff..

**WORK IN PROGRESS**

## Creating content

Use the `create` script to quickly scaffold new blog posts and links.

```bash
./create <type> <title>
```

**Type** is either `blog` or `link`. The title is automatically converted to a URL-friendly slug.

**Examples:**

```bash
# Blog post
./create blog "Hello World Again"
# → hugo new blog/hello-world-again

# Link
./create link "awesome tunneling"
# → hugo new -k links links/awesome-tunneling.md
```