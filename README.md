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
  beginning with `_` and the site loses its CSS and JS. `quarto render` creates
  it automatically for `type: website` — don't delete it.
- **`files/cv.pdf`** is referenced by `cv.qmd` and `index.qmd`. If it's absent,
  those links 404 silently.
- **`images/profile.jpg`** is referenced by `index.qmd`. If absent, the build
  warns and the about block renders without a photo.
- This repo is **public** (GitHub Pages requires it on the free plan). Don't put
  anything here you wouldn't publish — unlike `book-revision` and
  `sabbatical-papers`, which are private.

## Git architecture

Per the workspace convention, this repo's `.git` lives outside Dropbox at
`~/git-repos/website`, with a `.git` pointer file in the Dropbox tree. See
`Projects/git-github-setup.md`.
