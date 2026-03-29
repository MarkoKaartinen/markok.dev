<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  exclude-result-prefixes="atom content">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <title>RSS Feed | <xsl:value-of select="/rss/channel/title"/></title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
          *, *::before, *::after { box-sizing: border-box; }

          :root {
            --bg:        rgb(248, 250, 252);
            --bg-card:   rgb(255, 255, 255);
            --text:      rgb(15, 23, 42);
            --text-muted:rgb(100, 116, 139);
            --border:    rgb(226, 232, 240);
            --primary:   rgb(37, 99, 235);
            --primary-h: rgb(29, 78, 216);
            --notice-bg: rgb(239, 246, 255);
            --notice-border: rgb(191, 219, 254);
            --notice-text: rgb(30, 64, 175);
            --code-bg:   rgb(241, 245, 249);
          }
          @media (prefers-color-scheme: dark) {
            :root {
              --bg:        rgb(15, 23, 42);
              --bg-card:   rgb(30, 41, 59);
              --text:      rgb(248, 250, 252);
              --text-muted:rgb(100, 116, 139);
              --border:    rgb(51, 65, 85);
              --primary:   rgb(96, 165, 250);
              --primary-h: rgb(147, 197, 253);
              --notice-bg: rgb(30, 58, 138);
              --notice-border: rgb(59, 130, 246);
              --notice-text: rgb(147, 197, 253);
              --code-bg:   rgb(51, 65, 85);
            }
          }

          body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: var(--bg);
            color: var(--text);
            margin: 0;
            padding: 2rem 1rem;
            line-height: 1.6;
          }
          .wrap { max-width: 720px; margin: 0 auto; }

          h1 {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            font-size: 1.75rem;
            margin: 0 0 0.25rem;
          }
          .channel-title { color: var(--text); margin: 0 0 0.25rem; font-size: 1.1rem; font-weight: 600; }
          .subtitle { color: var(--text-muted); margin: 0 0 1.5rem; font-size: 0.95rem; }

          .notice {
            background: var(--notice-bg);
            border: 1px solid var(--notice-border);
            border-radius: 0.75rem;
            padding: 1rem 1.25rem;
            margin-bottom: 2rem;
            font-size: 0.875rem;
            color: var(--notice-text);
          }
          .notice code {
            font-family: monospace;
            font-size: 0.85em;
            background: var(--code-bg);
            color: var(--text);
            padding: 0.15em 0.4em;
            border-radius: 0.25rem;
            word-break: break-all;
          }
          .notice a { color: var(--primary); }

          hr { border: none; border-top: 1px solid var(--border); margin: 1.5rem 0; }

          .items { display: flex; flex-direction: column; gap: 1.25rem; }

          .item {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 0.75rem;
            padding: 1.25rem 1.5rem;
            transition: border-color 0.15s;
          }
          .item:hover { border-color: var(--primary); }

          .item-title { font-size: 1.1rem; font-weight: 600; margin-bottom: 0.5rem; }
          .item-title a { color: var(--primary); text-decoration: none; }
          .item-title a:hover { color: var(--primary-h); text-decoration: underline; }

          .item-summary {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-bottom: 0.75rem;
          }

          details { margin-top: 0.5rem; }
          summary {
            font-size: 0.8rem;
            color: var(--primary);
            cursor: pointer;
            user-select: none;
          }
          summary:hover { color: var(--primary-h); }
          .item-content {
            margin-top: 0.75rem;
            font-size: 0.9rem;
            line-height: 1.7;
            border-top: 1px solid var(--border);
            padding-top: 0.75rem;
          }
          .item-content a { color: var(--primary); }

          .meta { font-size: 0.78rem; color: var(--text-muted); margin-top: 0.75rem; }
        </style>
      </head>
      <body>
        <div class="wrap">
          <h1>
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" width="32" height="32">
              <defs>
                <linearGradient x1="0.085" y1="0.085" x2="0.915" y2="0.915" id="RSSg">
                  <stop offset="0.0" stop-color="#E3702D"/>
                  <stop offset="0.5" stop-color="#FB9E3A"/>
                  <stop offset="1.0" stop-color="#D95B29"/>
                </linearGradient>
              </defs>
              <rect width="256" height="256" rx="55" ry="55" x="0" y="0" fill="#CC5D15"/>
              <rect width="246" height="246" rx="50" ry="50" x="5" y="5" fill="#F49C52"/>
              <rect width="236" height="236" rx="47" ry="47" x="10" y="10" fill="url(#RSSg)"/>
              <circle cx="68" cy="189" r="24" fill="#FFF"/>
              <path d="M160 213h-34a82 82 0 0 0-82-82v-34a116 116 0 0 1 116 116z" fill="#FFF"/>
              <path d="M184 213A140 140 0 0 0 44 73V38a175 175 0 0 1 175 175z" fill="#FFF"/>
            </svg>
            RSS Feed
          </h1>
          <p class="channel-title"><xsl:value-of select="/rss/channel/title"/></p>
          <p class="subtitle"><xsl:value-of select="/rss/channel/description"/></p>

          <div class="notice">
            <p style="margin:0 0 0.5rem">This is an RSS feed. Copy the address below into your feed reader to subscribe.</p>
            <code><xsl:value-of select="/rss/channel/atom:link/@href"/></code>
            <p style="margin:0.5rem 0 0">New to feeds? Learn more at <a href="https://aboutfeeds.com">aboutfeeds.com</a>.</p>
          </div>

          <hr/>

          <div class="items">
            <xsl:for-each select="/rss/channel/item">
              <div class="item">
                <div class="item-title">
                  <a>
                    <xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
                    <xsl:value-of select="title"/>
                  </a>
                </div>
                <xsl:if test="description">
                  <div class="item-summary">
                    <xsl:value-of select="description" disable-output-escaping="yes"/>
                  </div>
                </xsl:if>
                <div class="meta">
                  <xsl:value-of select="substring(pubDate, 1, 16)"/>
                </div>
              </div>
            </xsl:for-each>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
