# thedoublejay tap

Homebrew tap for `gather-step` on macOS and Linux.

## Install

Install directly:

```bash
brew install thedoublejay/tap/gather-step
```

Or tap first:

```bash
brew tap thedoublejay/tap
brew install gather-step
```

## Upgrade

Once the tap is installed, Homebrew will refresh it during `brew update`.
Users can then upgrade with:

```bash
brew update
brew upgrade gather-step
```

Or explicitly:

```bash
brew upgrade thedoublejay/tap/gather-step
```

Important: `brew upgrade` only picks up new releases when the formula version in this tap is bumped. For the normal upgrade flow, publish semver releases for `gather-step` such as `v4.0.4`, `v4.0.5`, and update the formula accordingly.

## Included Formulae

### `gather-step`

A local-first code graph for multi-repo workspaces and AI coding assistants.

Current formula path: [`Formula/gather-step.rb`](Formula/gather-step.rb)

## Release Workflow

This tap includes the current Homebrew GitHub Actions workflow layout:

- `.github/workflows/tests.yml` runs `brew test-bot` on pull requests and pushes.
- `.github/workflows/publish.yml` publishes bottled artifacts when a pull request is labeled `pr-pull`.

Recommended release flow:

1. Cut a tagged release in `thedoublejay/gather-step`, ideally `vX.Y.Z`.
2. Update [`Formula/gather-step.rb`](Formula/gather-step.rb) to the new release URLs, source archive, and checksums.
3. Open a pull request in this tap.
4. Wait for `brew test-bot` to pass.
5. Add the `pr-pull` label to publish bottles and merge the formula update.

## Current Packaging Note

The tap installs prebuilt release archives on macOS and builds from the tagged source archive on Linux. This avoids pointing Linux Homebrew users at a missing prebuilt artifact while still exercising the Linux source-build path in CI.

## Local Validation

Useful commands while iterating on the tap:

```bash
HOMEBREW_NO_INSTALL_FROM_API=1 brew audit --strict --tap=thedoublejay/tap
HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source thedoublejay/tap/gather-step
brew test gather-step
```

## Documentation

- Homebrew Formula Cookbook: <https://docs.brew.sh/Formula-Cookbook>
- How to Create and Maintain a Tap: <https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap>
