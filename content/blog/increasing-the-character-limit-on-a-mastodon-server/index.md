---
title: "Increasing the character limit on a Mastodon server"
date: 2026-03-04T07:50:49+02:00
description: "This is mostly a note to myself, but hopefully useful to others too. Here's how to increase the post character limit on a Mastodon server. Bonus: how to increase the number of poll options as well."
summary: "This is mostly a note to myself, but hopefully useful to others too. Here's how to increase the post character limit on a Mastodon server. Bonus: how to increase the number of poll options as well."
tags: ["Server", "Mastodon", "Configuration", "Tips"]
categories: ["Mastodon"]
---
{{< lead >}}
This is mostly a note to myself, but hopefully useful to others too. Here's how to increase the post character limit on a Mastodon server. Bonus: how to increase the number of poll options as well.
{{< /lead >}}

First, a disclaimer: these changes may be reset during an update, and you'll have to redo them. That's exactly why I'm writing this down for myself. This works at least in the latest versions!

Unfortunately, neither of these settings are in the `.env.production` file — they need to be changed directly in the code. So if you're not sure what you're doing, don't make these changes. I take no responsibility if you break something!

## Increasing the character limit

This requires editing two files. You can use the `nano` editor for this. In nano, <kbd>CTRL</kbd> + <kbd>O</kbd> saves and <kbd>CTRL</kbd> + <kbd>X</kbd> closes the editor.

Switch to the mastodon user (`sudo su - mastodon`) and navigate to the `/home/mastodon/live` directory.

First, edit the `compose_form_container.js` file:

```bash
nano app/javascript/mastodon/features/compose/containers/compose_form_container.js
```

Find the line where `maxChars` is defined and change the value to your desired character count. The default is `500`.

```javascript
maxChars: state.getIn(['server', 'server', 'configuration', 'statuses', 'max_characters'], 500),
```

The second file to edit is `status_length_validator.rb`:

```bash
nano app/validators/status_length_validator.rb
```

Find the `MAX_CHARS` line and set it to the same value you used above. The default is `500`.

```ruby
MAX_CHARS = 500
```

After that, you need to recompile the assets with the following command:

```bash
RAILS_ENV=production bundle exec rails assets:precompile
```

Then restart the Mastodon processes:

```bash
sudo systemctl stop 'mastodon-*.service'

sudo systemctl start 'mastodon-*.service' --all
```

If everything went as expected, you should now see the new character limit when composing a post!

## Bonus: Increasing the number of poll options

If you also want more than 4 options in polls, you can change that in the `poll_options_validator.rb` file:

```bash
nano app/validators/poll_options_validator.rb
```

Find the `MAX_OPTIONS` line and change it to your desired number of options. The default is `4`.

```ruby
MAX_OPTIONS = 4
```

{{< alert "circle-info" >}}
This article was first published on my [blog](https://markokaartinen.net/2026/mastodon-palvelimen-viestin-merkkimaaran-nostaminen) in Finnish.
{{< /alert >}}

<small>Article image by <a href="https://unsplash.com/@freshvanroot?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Rolf van Root</a> on <a href="https://unsplash.com/photos/an-open-laptop-computer-sitting-on-top-of-a-wooden-floor-UTkRk-DbMm8?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></small>
      