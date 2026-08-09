# Personal website

Quarto static site, hosted on GitHub Pages, served from the `docs/` directory on
`master`.

## Layout

| Path | What it is |
|------|-----------|
| `_quarto.yml` | Site config — title, navbar, theme, `site-url` |
| `index.qmd` | Home / about page |
| `research.qmd` | Book, articles, work in progress |
| `teaching.qmd` | Courses, advising |
| `cv.qmd` | Links `files/cv.pdf` |
| `styles.css` | Small overrides on the `cosmo` theme |
| `files/` | PDFs (CV, syllabi) — linked, not generated |
| `images/` | Profile photo and any figures |
| `docs/` | **Rendered output. Committed, not ignored.** Never hand-edit. |

## Editing

Edit the `.qmd` files. They're plain markdown with a YAML header — the same
format as Rmd, minus the R-specific bits.

## Preview locally

```sh
quarto preview
```

Opens a browser with live reload. Ctrl-C to stop.

## Publish

```sh
quarto render          # writes docs/
git add -A
git commit -m "Update site"
git push
```

GitHub Pages picks up the push and redeploys in a minute or two.

## Why `docs/` is committed

The alternative is a GitHub Action that renders on push. That means CI config,
a build that can fail invisibly, and Quarto version drift between your machine
and the runner. Committing `docs/` means what you previewed locally is exactly
what ships, with no build infrastructure. The cost is noisier diffs, which
don't matter here.

## Gotchas

- **`docs/.nojekyll`** must exist, or GitHub's Jekyll step strips directories
  beginning with `_` and the site can lose its CSS and JS. Plain `quarto render`
  does **not** create it — only `quarto publish gh-pages` does. So a root
  `.nojekyll` is committed and listed under `project: resources:` in
  `_quarto.yml`, which copies it into `docs/` on every render. Don't delete
  either copy or drop it from `resources`.
- **`CNAME`** works the same way: root file, listed in `resources`, copied to
  `docs/CNAME` on render. It holds `joelwinkelman.com`. If it goes missing,
  GitHub silently reverts the site to `jmwink.github.io`.
- **`files/cv.pdf`** is referenced by `cv.qmd` and `index.qmd`. If it's absent,
  those links 404 silently.
- **`images/profile.jpg`** is referenced by `index.qmd`. If absent, the build
  warns and the about block renders without a photo.
- This repo is **public** (GitHub Pages requires it on the free plan). Don't put
  anything here you wouldn't publish — unlike `book-revision` and
  `sabbatical-papers`, which are private.

## How Claude is used on this site

I build and maintain this site with Claude Code. The repo is public, so here is
what that actually means, in more detail than anyone probably wants.

**What it does.** All of the structure: the Quarto scaffolding, `_quarto.yml`,
the CSS, this README, the publish gate in `check-markers.sh`, the DNS and
certificate setup, the image processing, and the script that generates the
redacted public CV. It drafts page structure. The "About" and "Teaching" pages
began as its drafts and were rewritten to my instruction. I threw out the
first version of the bio entirely. Claude made the "Research" page using DOI
lookups and links, rather than my cutting-and-pasting from my CV. Elsewhere,
Claude does light copy-edits: spelling and grammar check. Using in-line tags
while drafting my public notebook entries, I also use Claude for fact-checking,
link verification, and information retrieval. In my experience, these uses save
more embarrassment than they create.

**Where the record is.** Each source file carries a comment block at the top
recording what was changed and why, including the corrections I accepted and
the ones I overrode. Those comments are in this repository and are the
change-by-change account.

**What it doesn't do.** After seeing its draft attempts at zhuzhing up my
"About" and "Teaching" pages, I have instructed it to NOT generate prose,
draft ideas, or give writing suggestions. The Work in Progress page and the
notebook posts are my own dictated words; the source files instruct against
expanding or improving them. Every editorial decision here is mine.

**On publishing the prompts.** I have argued in print that workers should
fight for transparency in AI usage, demanding to see their managers' chat
histories and the training prompts behind them, rather than hand-wringing
about the technology's existence. This README is an attempt to voluntarily
demonstrate what I mean by that argument. Everything above this was first
drafted by Claude, prompted to describe its understanding of its role. I have
edited it for clarity and alignment.


Letter: "When the Edible Hits," in *Blunt thoughts on AI*, n+1 Issue 53 (Spring
2026). <https://www.nplusonemag.com/issue-53/letters/blunt-thoughts-on-ai/>

## Git architecture

Per the workspace convention, this repo's `.git` lives outside Dropbox at
`~/git-repos/website`, with a `.git` pointer file in the Dropbox tree. See
`Projects/git-github-setup.md`.
