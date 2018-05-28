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

