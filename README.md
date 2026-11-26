# Ouro

Ouro runs AI coding agents on your own computers and lets you talk to them from your phone. Agents work in their own
git worktrees, message each other and you, ask you questions when they're stuck, and can change Ouro itself: you ask
for a feature from the iPhone app, an agent builds it, and the change ships to your server and your app.

It has three parts:

- **The server** (`server/`, run by `guardian/`): one per computer. It starts agents on Claude Code or Codex, keeps their
  chats, goals and memory, and links your computers to each other over Tailscale. It also serves a web app at `/web/`.
- **The iPhone app** (`apps/mobile/`, Expo and React Native): your agents, chats, asks and servers.
- **The hub** (`hub/`, optional): makes cloud computers (Sprites) for people and relays push notifications.

`packages/contract` holds the protocol the parts share. `journeys/` holds end-to-end tests that run real processes.

## Requirements

- macOS or Linux, with Node.js 24 or newer and git.
- To run real agents: [Claude Code](https://claude.com/claude-code) or the Codex CLI, signed in. Development and tests
  use a built-in stand-in model and need neither.
- To link several computers: [Tailscale](https://tailscale.com), signed in to the same tailnet on each.
- To build the iPhone app: Xcode, and an Apple developer account for a device build.

## Running the server for development

There's no build step: Node runs the TypeScript directly. Everything a server owns is in its data directory.

```sh
npm ci
OURO_DATA=$PWD/runs/dev OURO_DEFAULT_MODEL=stand-in node server/src/bin/ourod.ts
OURO_SOCKET=$PWD/runs/dev/local.sock server/bin/ouro pair   # a one-time code for a phone or the web app
```

Leave out `OURO_DEFAULT_MODEL=stand-in` to have agents use Claude.

## Tests

```sh
npm test                # import rules, types and unit tests: fast, run before every change
npm run test:journeys   # end-to-end journeys with real processes and the stand-in model
npm run test:live       # journeys/live/: real model calls, paid, run by hand only
```

Only one journey process runs at a time on a machine. The harness takes a lock (`$TMPDIR/ouro-rebirth-journey.lock`)
and the others wait for it.

## Installing on a Mac

`scripts/install-run-mac.sh` installs the server as your launch agents: it runs while you're logged in, and starts again
when you log in. It needs Homebrew, and the Tailscale app signed in to the same tailnet as your other computers.

```sh
brew install gh && gh auth login
gh repo clone <you>/<your copy> ~/ouro/source
~/ouro/source/scripts/install-run-mac.sh
```

It puts `ouro` on the PATH. To join your other computers, run `ouro computers invite` on one of them and paste the command
it prints on the Mac. Or pass it to the installer, which joins once the server is live:
`OURO_NEXT_JOIN="ouro computers join <address> <code>" ~/ouro/source/scripts/install-run-mac.sh`. Running the installer
again updates the server to your copy's current commit. Logs are in `~/ouro/logs/`. To stop it, run
`launchctl bootout gui/$(id -u)/com.ouro.ouro-guardian` and `…/com.ouro.ouro-host`.

## Installing on Ubuntu (an EC2 instance)

`scripts/install-run-ubuntu.sh <commit>` installs the server on a plain Ubuntu machine as two systemd services, with
Caddy in front for HTTPS. Run it as the user Ouro runs as (on EC2, `ubuntu`), who needs sudo without a password; ports 80
and 443 must be open to the internet. Phones and other computers reach it at `OURO_NEXT_PUBLIC_URL`, `https://<a name
pointing at it>`; by default `https://<its public IP, dashed>.sslip.io`. That default follows the IP, so on EC2 give the
instance an Elastic IP or set a name you own: a re-run that would change the URL stops and says so.

```sh
git clone <your copy> ~/ouro/source
~/ouro/source/scripts/install-run-ubuntu.sh "$(git -C ~/ouro/source rev-parse HEAD)"
```

The guardian listens only on 127.0.0.1 there; `journalctl -u ouro-guardian` and `-u ouro-host` show the logs.

The three installers share `scripts/install-run.sh`, which installs the server under any of the three service managers,
and `scripts/lib/install-common.sh`; `scripts/install-run-sprite.sh` sets up a cloud computer on [Sprites](https://sprites.dev). The header of each script lists its settings.

## Building the iPhone app

The app is a standard Expo project. `apps/mobile/app.json` carries the bundle ID and Apple team of the published app;
change both to your own before building for a device.

```sh
cd apps/mobile
npx expo run:ios        # a simulator build
```

`scripts/ios-archive.sh`, `ios-sign.sh` and `ios-upload.sh` make an App Store build and send it to TestFlight. A
server can also publish over-the-air updates of the app's JavaScript to the phones paired with it.

## How changes flow

This repository is Ouro's main line. Its releases are **bases**: tags `base-<n>`, cut by the release workflow, each with a
version (`v<major.minor.patch>`). Servers take new bases from here. Each person runs their own copy of the source, where
their agents change Ouro for them, and sends changes back here as pull requests. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License and notices

See [LICENSE](LICENSE). Third-party notices are in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). For example, the
browser's HEIC fallback loads the unmodified [libheif-js](https://github.com/catdad-experiments/libheif-js) bundle (LGPL-3.0)
in a separate worker, and serves its license at `/web/libheif-license.txt`.

Security issues: see [SECURITY.md](SECURITY.md).
