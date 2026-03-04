---
title: "Deploying Hugo site to a Linux server"
date: 2026-03-04T08:20:53+02:00
description: "Hugo is fast and great static site generator. This blog is built with Hugo. In this article, I'll show how I deploy my Hugo site to a Linux server using GitHub Actions."
summary: "Hugo is fast and great static site generator. This blog is built with Hugo. In this article, I'll show how I deploy my Hugo site to a Linux server using GitHub Actions."
tags: ["Hugo", "Linux", "Server", "GitHub"]
categories: ["Hugo"]
---
{{< lead >}}
Hugo is fast and great static site generator. This blog is built with Hugo. In this article, I'll show how I deploy my Hugo site to a Linux server using GitHub Actions.
{{< /lead >}}

I use this method on this site and also on my finnish [BBQ blog](https://bbqblogi.fi).

## What is behind the scene?

Here we have a Hugo site in a GitHub repository. That is a base of the whole operation. I have Ubuntu web server with Nginx installed. The server is running on a Hetzner VPS.

I use GitHub Actions to automate the deployment process. When I push changes to the repository, GitHub Actions triggers a workflow that builds the Hugo site and deploys it to the server. The deployment script uses SSH to connect to the server and copy the built site files to the web server directory.

## Set up SSH keys

The deployment uses SSH to securely transfer files to your server. First, generate an SSH key pair. You can do it on your local machine or on the server.

```bash
ssh-keygen -t rsa -b 4096 -C "github-actions@domain.dev" -f ~/.ssh/gh_domaindev_action
```

Add the **public key** to your server's `~/.ssh/authorized_keys` file, and keep the **private key** for the next step.

## Configuring GitHub Secrets

In your GitHub repository, go to **Settings → Secrets and variables → Actions** and add the following repository secrets:

| Secret        | Description                                         |
|---------------|-----------------------------------------------------|
| `DEPLOY_KEY`  | Your SSH private key                                |
| `DEPLOY_HOST` | Your server's IP address or hostname                |
| `DEPLOY_USER` | The SSH username on your server                     |
| `DEPLOY_PATH` | The path on the server where files will be deployed |

## The GitHub Actions Workflow

Create the file `.github/workflows/deploy.yml` in your repository with the content below. You can customize the workflow as needed and for example change the Hugo version.

```yaml
name: Deploy Hugo site to Ubuntu server

on:
  push:
    branches:
      - main

jobs:
  deploy:
    name: Deploy to Ubuntu Server
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: "latest"

      - name: Build site
        run: hugo --minify

      - name: Setup SSH
        run: |
          mkdir -p ~/.ssh
          echo "${{ secrets.DEPLOY_KEY }}" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa
          ssh-keyscan -H ${{ secrets.DEPLOY_HOST }} >> ~/.ssh/known_hosts

      - name: Deploy to server
        run: |
          rsync -avz --delete \
          -e "ssh -i ~/.ssh/id_rsa" \
          public/ ${{ secrets.DEPLOY_USER }}@${{ secrets.DEPLOY_HOST }}:${{ secrets.DEPLOY_PATH }}
```

## So how does it work?

The workflow runs automatically every time you push to the `main` branch. Here is what happens step by step:

1. **Checkout** – The repository is cloned, including any Git submodules (e.g. themes).
2. **Setup Hugo** – The latest version of Hugo is installed.
3. **Build** – Hugo builds the site into the `public/` directory with minification enabled.
4. **Setup SSH** – The SSH private key is configured so the runner can connect to your server.
5. **Deploy** – `rsync` transfers the built files to your server, removing any old files that no longer exist.

## Conclusion

With this method, you can easily deploy your Hugo site to a Linux server using GitHub Actions. If your GitHub repository is public, you can use Actions for free.

It is also possible to host Hugo sites on GitHub Pages, which is also a free option to host your site. You can read more about it in the [Hugo documentation](https://gohugo.io/host-and-deploy/host-on-github-pages/).

Also GitHub is not the only option, but it is widely popular and has a ton of free features. 

<small>Article image by <a href="https://unsplash.com/@maik_wi?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Maik Winnecke</a> on <a href="https://unsplash.com/photos/a-laptop-computer-sitting-on-top-of-a-wooden-desk-JQyMJFh59xY?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></small>