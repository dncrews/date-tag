# date-tag

The goal of this package is to create (and push) git tags that are date based. This is sometimes used to push applications that aren't "versioned" in the semver sense, but have date-based deployments.

**Note: these tags are annotated tags. See the "Creating Tags" section of the [Tagging docs.](https://git-scm.com/book/en/v2/Git-Basics-Tagging)**

## Tag Format

The git tag that is created will come in the format of:
`<prefix><YYYY>-<MM>-<DD>.<version>`

- Prefix
  - Denotes whether it was a full release or a release candidate
- YYYY
  - 4-digit calendar year
- MM
  - 2-digit calendar month
- DD
  - 2-digit calendar day
- Version
  - Denotes which deployment this is for today.
    - `.1` would be the first deployment with that prefix
    - `.10` would be the tenth.

### Examples

| Example | Command | Prefix | YYYY | MM | DD | Version |
| --: | -- | -- | -- | -- | -- | -- |
| rc-v2022-01-06.15 | `date-tag rc` | `rc-v` | `2022` | `01` | `06` | `15` |
| v2022-10-20.2 | `date-tag prod` | `v` | `2022` | `10` | `20` | `2` |


## Usage

### Without installation
The easiest way to use this package is simply to use `npx` to call it. You do not need to install it first.
```bash
$ npx date-tag <rc | prod | push>
```

### With installation

First install it in your project with either:

```bash
npm install -D date-tag
```
```bash
yarn install -D date-tag
```

You can then use the same npx command
```bash
npx date-tag <rc | prod | push>
```

Or you can add it to your package.json
```json
{
  "scripts": {
    "release": "yarn run date-tag"
  }
}
```
and then you can use
```bash
yarn release <rc | prod | push>
```

### Options
There is only one option with multiple possible values:
| Option | Purpose | Variations |
| ----: | ---- |---- |
| `rc` | Publishes a tag with the prefix `rc-v`<br />e.g. `rc-v2022-01-01.1` | `date-tag rc`<br />`date-tag beta`<br />`date-tag demo` |
| `prod` | Publishes a tag with the prefix `v`<br />e.g. `v2022-01-01.1` | `date-tag prod`<br />`date-tag full`<br />`date-tag release` |
| `push` | Shows you the tags for today and allows you to choose one to push to Github. (See Note below). | `date-tag push` |

### Note on `push`

The reason the command `push` exists when `git push --tags` also exists is that I was personally frustrated when I had OTHER tags that shouldn't be pushed. For example, if I tagged a release yesterday that was never deployed, I don't want to push that one. The equivalent git command to push only the one tag would be:

```bash
git push origin "refs/tags/v2022-01-01.1"
```