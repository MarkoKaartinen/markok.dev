---
title: "Human.json for Humans WordPress Plugin"
date: 2026-04-10T09:20:00+03:00
description: "Human.json for Humans is an open-source WordPress plugin that implements the human.json standard — serving your human.json file and letting you manage vouched sites."
summary: "I built an open-source WordPress plugin that implements the human.json standard. It serves your human.json file, adds a discovery tag to every page, and lets you manage vouched sites with a Gutenberg block or shortcode."
tags: ["WordPress", "Plugin", "Human.json", "Open Source"]
categories: ["WordPress"]
---

I have written about the [human.json standard](https://codeberg.org/robida/human.json) and AI in [this blog](/blog/2026/how-i-use-ai/) and added it to this Hugo site. Now I built a WordPress plugin that allows you to add human.json to WordPress — **Human.json for Humans**.

The plugin is open source and available on Codeberg:
[https://codeberg.org/markokaa/human-json-for-humans](https://codeberg.org/markokaa/human-json-for-humans)

## What it does

Once installed, the plugin automatically serves `human.json` file at `yourdomain.com/human.json` and adds a `<link rel="human-json">` tag to every page's `<head>` so others can find your file automatically.

From **Settings → Human.json** you can manage your site URL and vouched sites. You can also import vouched sites from any other human.json file — duplicates are skipped automatically.

To display your vouched sites on any page or post, you can use the included Gutenberg block or use shortcode to show it on any page or post.

## A note on AI

Different AI models were used as a development aid — for asking questions, debugging, handling repetitive tasks, and sparring on ideas. Some code was written or suggested by AI, but everything has been reviewed, tested, and possibly rewritten by human.

AI also helped with English wording and translations, as English is not my native language.

AI is treated as a tool, not a replacement for developer judgment. **This is not a vibe-coded project**.

## Get the plugin

The plugin is in its early stages (version 0.1.0) and not yet in the official WordPress plugin directory. For now, you can download it from Codeberg and install it manually. It is under reveiw for the official WordPress plugin directory.

You can download zip from Codeberg releases:

[https://codeberg.org/markokaa/human-json-for-humans](https://codeberg.org/markokaa/human-json-for-humans)

If you try it out, I would love to hear what you think. And also you are free to submit issues or even make a pull request.