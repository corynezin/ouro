# Third-party notices

Ouro doesn't vendor third-party code. Its dependencies install from npm (see `package-lock.json`), each under its own
license, which is in its package. Most are MIT, ISC, BSD or Apache-2.0. The ones below have terms worth noting.

- **libheif-js** (LGPL-3.0): the browser's HEIC fallback loads the unmodified bundle from the package, in a separate worker.
  The server serves its license at `/web/libheif-license.txt`. Source: https://github.com/catdad-experiments/libheif-js
- **lightningcss**, **web-push** (MPL-2.0): used unmodified.
- **jszip** (MIT or GPL-3.0-or-later), **node-forge** (BSD-3-Clause or GPL-2.0): used under MIT and BSD-3-Clause.
- **DiceBear** avatar styles (`@dicebear/*`, code MIT, © Florian Körner):
  - Bottts Neutral, based on [Bottts](https://bottts.com/) by Pablo Stanley: free for personal and commercial use.
  - [Personas](https://personas.draftbit.com/) by Draftbit (CC BY 4.0).
  - Notionists by [Zoish](https://heyzoish.gumroad.com/) (CC0 1.0).
  - Initials (code only).
- **Patched packages** (`apps/mobile/patches/`, applied by patch-package): `expo` and `expo-modules-jsi` (MIT, © 650
  Industries) and `pptx-browser` (MIT). The patches are distributed under the same licenses as the packages they modify.
