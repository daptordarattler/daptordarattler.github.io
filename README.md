# daptordarattler.is-a.dev

Personal CV / portfolio site for Dominic Fui Dodzi-Nusenu — senior software
engineer and technical lead with 15+ years of active development experience
(coding since 2005). Hosted at [**daptordarattler.is-a.dev**](https://daptordarattler.is-a.dev).

## Stack

- Static HTML + CSS, zero JS framework
- Google Fonts (Inter + JetBrains Mono)
- Served via GitHub Pages
- Custom subdomain via the [is-a.dev](https://www.is-a.dev) free registrar

## Local Preview

```bash
cd daptordarattler-cv
python3 -m http.server 8080
# open http://localhost:8080
```

## Deploy

1. Push this repo to GitHub as `daptordarattler/daptordarattler.github.io`
   (or any repo with Pages enabled).
2. Enable GitHub Pages: Settings -> Pages -> Source: `main` branch, `/` root.
3. The `CNAME` file ensures GitHub Pages serves the custom subdomain.

## is-a.dev Subdomain

To claim `daptordarattler.is-a.dev`:

1. Fork [is-a-dev/register](https://github.com/is-a-dev/register).
2. Copy `domains/daptordarattler.json` (in this repo) into `domains/` of the fork.
3. Open a pull request — maintainers review and merge.
4. DNS propagates within minutes after merge.

The JSON config in `domains/daptordarattler.json` points the subdomain to
`daptordarattler.github.io` and enables Cloudflare proxying for free TLS +
CDN.

## Structure

```
.
|-- index.html              # full single-page CV
|-- assets/
|   |-- style.css           # all styles
|   `-- favicon.svg         # gradient DFD mark
|-- domains/
|   `-- daptordarattler.json  # is-a.dev subdomain config
|-- CNAME                   # GitHub Pages custom domain
`-- .nojekyll               # skip Jekyll build
```
