# auto-minify

![test workflow](https://github.com/nizarmah/auto-minify/actions/workflows/test.yml/badge.svg?branch=master&event=push)

Minifies JS and CSS files.

## Quickstart

```yaml
on: [push]

jobs:
  minify:
    runs-on: ubuntu-latest
    steps:
      - name: check out the repository
        uses: actions/checkout@v4

      - name: auto minify the files
        uses: nizarmah/auto-minify@v3

      - name: auto commit the minified files
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "bot: Add auto minified files"
```

## Features

* **Flexibility**: Minify JS and CSS files with the engine of your choice.
* **Customization**: Specify directories, handle file overwrites, and control traversal depth.
* **Reliability**: Continuous integration tests validate functionality and predictability.

## Customization

### Inputs

| Input | Description | Required | Default Value |
| :-- | :-- | --: | --: |
| directory | Directory that contains the files you want to minify. | false | . |
| output | Directory that contains the minified files. | false | . |
| overwrite | Overwrites the existing files with the minified version. Defaults to false. | false | false |
| maxdepth | Descend at most levels (a non-negative integer) levels of directories below the starting-points. | false | |
| js_engine | Specifies which of the supported packages minifies JS files. Supported packages: `babel`, `uglify-js` | false | babel |
| css_engine | Specifies which of the supported packages minifies CSS files. Supported packages: `lightning`, `clean-css` | false | lightning |

> [!IMPORTANT]
> All paths are relative to the root of the repository.
>
> `output` defaults to the same directory as `directory`, unless specified.
>
> `maxdepth` traverses into all subdirectories by default.

### Examples

<details>
<summary>Overwriting existing files</summary><br />

```yaml
on: [push]

jobs:
  minify:
    runs-on: ubuntu-latest
    steps:
      - name: check out the repository
        uses: actions/checkout@v4

      - name: replace js and css files with minified ones
        uses: nizarmah/auto-minify@v3
        with:
          overwrite: true

      - name: auto commit the minified files
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "bot: Add auto minified files"
```
<br />
</details>

<details>
<summary>Restricting traversal depth</summary><br />

```yaml
on: [push]

jobs:
  minify:
    runs-on: ubuntu-latest
    steps:
      - name: check out the repository
        uses: actions/checkout@v4

      - name: auto minify files at most 1 level deep
        uses: nizarmah/auto-minify@v3
        with:
          maxdepth: 1

      - name: auto commit the minified files
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "bot: Add auto minified files"
```
<br />
</details>

<details>
<summary>Targeting specific directories</summary><br />

```yaml
on: [push]

jobs:
  minify:
    runs-on: ubuntu-latest
    steps:
      - name: check out the repository
        uses: actions/checkout@v4

      - name: auto minify files in the js directory
        uses: nizarmah/auto-minify@v3
        with:
          directory: 'js'

      - name: auto commit the minified files
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "bot: Add auto minified files"
```
<br />
</details>

<details>
<summary>Saving to a different directory</summary><br />

```yaml
on: [push]

jobs:
  minify:
    runs-on: ubuntu-latest
    steps:
      - name: check out the repository
        uses: actions/checkout@v4

      - name: auto minify files to a different directory
        uses: nizarmah/auto-minify@v3
        with:
          directory: 'assets'
          output: 'mini_assets'

      - name: auto commit the minified files
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "bot: Add auto minified files"
```
<br />
</details>

<details>
<summary>Using different engines</summary><br />

```yaml
on: [push]

jobs:
  minify:
    runs-on: ubuntu-latest
    steps:
      - name: check out the repository
        uses: actions/checkout@v4

      - name: auto minify files with different engines
        uses: nizarmah/auto-minify@v3
        with:
          js_engine: 'uglify-js'
          css_engine: 'clean-css'

      - name: auto commit the minified files
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "bot: Add auto minified files"
```
<br />
</details>

> [!TIP]
> If you can't find what you're looking for, check our [automated tests](./.github/workflows/test.yml).

## Contributing

Your contributions are welcome!
There's no guide yet, but don't hold back.

If it's a bug, please provide a minimal example to reproduce it.

If it's a feature, please provide a use case for it.

If it's a pull request, please provide a description and a test case for it.

Cheers!

## Versioning

We use [SemVer](https://semver.org/) for versioning. For the versions available, see the [tags on this repository](./tags).

We also provide major version tags to make it easier to always use the latest release of a major version. For example, you can use `nizarmah/auto-minify@v3` to always use the latest release of the current major version.

## License

This project is licensed under the GPL-3.0 License. See the [LICENSE](LICENSE) file for details.
