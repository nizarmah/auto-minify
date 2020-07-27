# auto-minify
Minifies JS and CSS files with Babel-Minify and CleanCSS


### Inputs

| Input | Description | Required | Default Value |
| -- | -- | -- | -- |
| directory | Directory that contains the files you want to minify. | false | . ( current directory ) |
| output | Directory that contains the minified files. | false | same as directory |
| maxdepth | Descend at most levels (a non-negative integer) levels of directories below the starting-points. | false | "" (empty) |
| js_engine | Specifies which of the supported packages minifies JS files. Supported packages: `babel`, `uglify-js` | false | babel |

> With the addition of `maxdepth`, the action traverses by default into all subdirectories in a specified directory.
>
> ##### [Follow this example if you want to minify the files in the first level of a certain directory.](#specifying-maxdepth)

### Example

##### Default implementation

```
steps:
  # Checks-out your repository under $GITHUB_WORKSPACE, so auto-minify job can access it
  - uses: actions/checkout@v2

  - name: Auto Minify
    uses: nizarmah/auto-minify@master

  # Auto commits minified files to the repository
  # Ignore it if you don't want to commit the files to the repository 
  - name: Auto committing minified files
    uses: stefanzweifel/git-auto-commit-action@v3.0.0
    with:
      commit_message: "Github Action: Auto Minified JS and CSS files"
      branch: ${{ github.ref }}
```

##### Specifying Maxdepth

```
steps:
  # Checks-out your repository under $GITHUB_WORKSPACE, so auto-minify job can access it
  - uses: actions/checkout@v2

  - name: Auto Minify
    uses: nizarmah/auto-minify@master
    with:
      maxdepth: 1

  # Auto commits minified files to the repository
  # Ignore it if you don't want to commit the files to the repository 
  - name: Auto committing minified files
    uses: stefanzweifel/git-auto-commit-action@v3.0.0
    with:
      commit_message: "Github Action: Auto Minified JS and CSS files"
      branch: ${{ github.ref }}
```

##### Specifying output directory

```
steps:
  # Checks-out your repository under $GITHUB_WORKSPACE, so auto-minify job can access it
  - uses: actions/checkout@v2

  - name: Auto Minify
    uses: nizarmah/auto-minify@master
    with:
      directory: 'js'

  # Auto commits minified files to the repository
  # Ignore it if you don't want to commit the files to the repository 
  - name: Auto committing minified files
    uses: stefanzweifel/git-auto-commit-action
    with:
      repository: 'js'
      commit_message: "Github Action: Auto Minified JS and CSS files"
      branch: ${{ github.ref }}
```

> Please note that the `output` will be in the same _directory_ as `directory` which here is `js`. Therefore, we will need to update `repository` in _auto committing_ to also match `directory`.

##### With different output directory

```
steps:
  # Checks-out your repository under $GITHUB_WORKSPACE, so auto-minify job can access it
  - uses: actions/checkout@v2

  - name: Auto Minify
    uses: nizarmah/auto-minify@master
    with:
      directory: 'js'
      output: 'mini_js'

  # Auto commits minified files to the repository
  # Ignore it if you don't want to commit the files to the repository 
  - name: Auto committing minified files
    uses: stefanzweifel/git-auto-commit-action
    with:
      repository: 'mini_js'
      commit_message: "Github Action: Auto Minified JS and CSS files"
      branch: ${{ github.ref }}
```

> Please note that the `repository` when _auto comitting_ has to match `output` in _auto minify_
