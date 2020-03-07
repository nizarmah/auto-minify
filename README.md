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
    uses: nizarmah/auto-minify@v1.2

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
    uses: nizarmah/auto-minify@v1.2
    with:
      directory: 'js'

  # Auto commits minified files to the repository
  # Ignore it if you don't want to commit the files to the repository 
  - name: Auto committing minified files
    uses: stefanzweifel/git-auto-commit-action@v3.0.0
    with:
      commit_message: "Github Action: Auto Minified JS and CSS files"
      branch: ${{ github.ref }}
```

##### With different output directory

```
steps:
  # Checks-out your repository under $GITHUB_WORKSPACE, so auto-minify job can access it
  - uses: actions/checkout@v2

  - name: Auto Minify
    uses: nizarmah/auto-minify@v1.2
    with:
      directory: 'js'
      output: 'mini_js'

  # Auto commits minified files to the repository
  # Ignore it if you don't want to commit the files to the repository 
  - name: Auto committing minified files
    uses: stefanzweifel/git-auto-commit-action@v3.0.0
    with:
      commit_message: "Github Action: Auto Minified JS and CSS files"
      branch: ${{ github.ref }}
```

> Please note that you will have to `commit` the changed files using a different `action`
