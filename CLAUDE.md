# hnote — CLAUDE.md

## Design

- Reference file: `/Users/hadrienblanc/Projets/hadrienblanc/test/html/index.html`
- Pure black/white — `border-black`, `font-bold tracking-tighter`, no colors, no rounded corners
- No `font-mono` globally — only in the markdown `<textarea>` (editing)
- No inverse hover (bg-black / text-white) on table rows

## Nav

- Logo: **H.** (not "hnote")
- New note: **`+`** button — `w-7 h-7` centered square (`inline-flex items-center justify-center`)
- Sign out: SVG icon (arrow-right-from-bracket), no text

## Index (notes list)

- Table with sortable columns: **Updated** / **Created**
- Search via GET param `q`, preserves active sort
- Timestamps: relative (`time_ago_in_words`) + exact date in `title` tooltip
