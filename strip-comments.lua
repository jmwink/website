-- Keeps the per-post transparency headers in the repo but out of the rendered
-- site. Pandoc parses `<!-- ... -->` as a raw HTML block and passes it straight
-- through to output, so without this the whole block is readable in page source
-- on joelwinkelman.com. The headers are meant to be the repo's record, and the
-- repo is where they should stay.
--
-- Scope: this drops EVERY HTML comment, not just the post headers -- including
-- the notes at the top of notebook/index.qmd. That is intended; they are all
-- notes to self.
--
-- Wired in via `filters:` in _quarto.yml. Runs locally inside `quarto render`;
-- there is no CI and nothing remote about it.
function RawBlock(el)
  if el.format:match("html") and el.text:match("^%s*<!%-%-") then
    return {}
  end
end

function RawInline(el)
  if el.format:match("html") and el.text:match("^%s*<!%-%-") then
    return {}
  end
end
