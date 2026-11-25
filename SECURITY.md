# Security

Ouro runs agents that can execute code on your computers, so security reports matter a lot to us.

## Reporting a vulnerability

Please **don't open a public issue**. Report it privately through GitHub's
[private vulnerability reporting](../../security/advisories/new) for this repository. Include what you found, how to
reproduce it, and which base or version you tested (Settings → Updates in the app shows it).

We'll acknowledge the report within a few days, keep you informed while we fix it, and credit you in the release notes
unless you'd rather not be named.

## Supported versions

Fixes go into the next base. Servers take new bases from this repository, so the newest base is the supported one.

## Scope

In scope: the server, guardian, hub, iPhone app, web app and the protocol between them. Examples are pairing, the
signatures between computers, authentication of phones and peers, secrets handling, and update and base integrity.

Agents run with the permissions of the user account the server runs as, and they act on what you ask them. An agent doing
something harmful because it was asked to is not a vulnerability in Ouro. A way for someone else to make your agents act,
or to read your data, is.
