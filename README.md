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
    uses: actions/auto-minify@v1
```

##### Specifying output directory

```
steps:
  # Checks-out your repository under $GITHUB_WORKSPACE, so auto-minify job can access it
  - uses: actions/checkout@v2

  - name: Auto Minify
    uses: actions/auto-minify@v1
    with:
      directory: 'js'
```

##### With different output directory

```
steps:
  # Checks-out your repository under $GITHUB_WORKSPACE, so auto-minify job can access it
  - uses: actions/checkout@v2

  - name: Auto Minify
    uses: actions/auto-minify@v1
    with:
      directory: 'js'
      output: 'mini_js'
```

> Please note that you will have to `commit` the changed files using a different `action`
