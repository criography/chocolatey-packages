## Requirements
1. chocolatey
1. latest node and npm
1. yarn is nice to have

## Create new package
1. `yarn new {package_slug}`
1. Edit `config.json`
1. Edit whatever goes in `tools` dir

## Update build of a package
1. `yarn build {package_slug}`
1. `cpack && cpush` from the `./dist/{package_slug}`

## Testing locally
1. Ensure clean Windows installation in VirtualBox or similar
1. Ensure the `dist` folder is shared
1. cd to the package's directory inside `dist` 
1. from terminal run `cpack && cinst {packageName} -dfv -s .` to package up the source and install from it.


## Publishing
1. Ensure that your API key is stored locally and if not, get it from https://chocolatey.org/account
1. If all testing is passing, cd to the dist folder of your package and use `cpush` to publish

## Please Note:
1. Package slugs must be the same as containing folders! Use titles for human readable values
```

{
    // package identifier [a-z0-9-_.]
    slug  : 'xyplorer.install',

    // display human-friendly title
    title : 'XYplorer (install)',

};

```

