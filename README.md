# auto-minify
Minifies JS and CSS files with UglifyJS and CleanCSS


### Inputs

| Input | Description | Required | Default Value |
| -- | -- | -- | -- |
| directory | Directory that contains the files you want to minify. | false | . ( current directory ) |
| output | Directory that contains the minified files. | false | same as directory |

### Example

##### Default implementation

```
steps:
  # Checks-out your repository under $GITHUB_WORKSPACE, so auto-minify job can access it
  - uses: actions/checkout@v2

  - name: Auto Minify
    uses: nizarmah/auto-minify@v1.3

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
    uses: nizarmah/auto-minify@v1.3
    with:
      directory: 'js'

  # Auto commits minified files to the repository
  # Ignore it if you don't want to commit the files to the repository 
  - name: Auto committing minified files
    uses: stefanzweifel/git-auto-commit-action@v3.0.0
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
    uses: nizarmah/auto-minify@v1.3
    with:
      directory: 'js'
      output: 'mini_js'

  # Auto commits minified files to the repository
  # Ignore it if you don't want to commit the files to the repository 
  - name: Auto committing minified files
    uses: stefanzweifel/git-auto-commit-action@v3.0.0
    with:
      repository: 'mini_js'
      commit_message: "Github Action: Auto Minified JS and CSS files"
      branch: ${{ github.ref }}
```

> Please note that the `repository` when _auto comitting_ has to match `output` in _auto minify_