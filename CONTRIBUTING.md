# Contributing to Ouro

Thanks for helping. Ouro is built mostly by its own agents. The usual way to contribute is to have an agent make the
change in your own copy of the source, then send it here.

## The flow

1. **Your copy.** Every Ouro server works from the person's own copy of the source. If you connect GitHub in the app, it
   keeps a private backup of that copy on your account. Changes you ask your agents for land there first.
2. **A branch from the newest base.** To send a change, branch from the newest `base-<n>` tag, and cherry-pick only that
   change onto it. Leave out anything personal or internal: `CLAUDE.md`, `AGENTS.md`, `docs/`, machine-specific notes, and
   unrelated changes. The checks reject a PR that adds `CLAUDE.md`, `AGENTS.md` or anything under `docs/`.
3. **A pull request against `main`.** Ask your agent to "send this change upstream", or push the branch to a fork and open
   the PR yourself.

You don't need Ouro to contribute: an ordinary fork and pull request works too.

## Before you open a PR

```sh
npm ci
npm test                # import rules, types, unit tests
npm run test:journeys   # end-to-end, with the stand-in model
```

CI runs both (`.github/workflows/checks.yml`). Keep changes focused: one behaviour per PR, with tests for it. Unit tests
sit beside the code (`*.test.ts`). Journeys in `journeys/` cover behaviour across processes.

## Conventions

- TypeScript, run directly by Node 24; there is no build step. `npm run lint:imports` enforces which layers may import
  which.
- `packages/contract` is the wire protocol between the server, app, hub and guardian. Phones,
  servers and peers may run different bases, so change it compatibly.
- Write user-facing text plainly and briefly. It's what people read on their phones.

## Releases

Maintainers cut releases with the `release` workflow, which steps the version, tags `base-<n>` and `v<version>`, and
publishes a GitHub release. Servers pick up new bases from those tags.

## License

By contributing, you agree that your contributions are licensed under this repository's [LICENSE](LICENSE).
