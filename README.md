# H.

A minimal Markdown notes app. Black and white. No friction.

## Stack

- **Rails 8** — SQLite, Propshaft, Importmap, Turbo
- **Devise** — authentication
- **Redcarpet** — Markdown rendering
- **Tailwind CSS** — styling

## Features

- Write notes in Markdown, rendered on show
- List with sort (updated / created) and full-text search
- Per-user isolation — notes scoped to `current_user`

## Run locally

```bash
bundle install
rails db:migrate
bin/dev
```

## Test

```bash
rails test
```
