module.exports = {
    upToDate             : 'Package is already up to date',
    success              : 'Package build. Current version: {{version}}',
    noExistingBuild      : 'No existing build found',
    fetchingVars         : 'Scraping latest package details started',
    fetchingVarsSuccesful: 'Scraping latest package details successful',
    errors               : {
        noConfig       : 'Couldn\'t find `config.json`',
        varFailed      : 'Fetching variable `{{varName}}` failed.',
        skippingPackage: 'Skipping build. Please fix the var fetching'
    },

    resettingDist :{
        init    : 'Wiping current build',
        success : 'Wiped current build'
    },

    planting :{
        init    : 'Generating files',
        success : 'Generated all required files',
        error   : 'Generating files assploded with error: {{error}}'
    }
};
