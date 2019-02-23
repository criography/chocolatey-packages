const fs                = require('fs');
const {join, resolve}   = require('path');
const rmfr              = require('rmfr');
const mkdirp            = require('mkdirp-promise');
const rcopy             = require('recursive-copy');
const through           = require('through');
const {renderString}    = require('template-file');

const {
    DIR_SRC,
    DIR_DIST,
    DIR_TEMPLATES
}          = require('../../constants');
const log  = require('../../helpers/log');
const copy = require('./copy');




class Builder {
    constructor(choco){
        this.config = {
            slug : choco
        };
        this.vars = {

        };

        this.paths = {
            src : resolve(join(DIR_SRC,  this.config.slug)),
            dist: resolve(join(DIR_DIST, this.config.slug))
        };


        return this.build();
    }



    /**-----------------------------------------------------------------------------
     * getConfig
     * -----------------------------------------------------------------------------
     * fetches package config and caches it
     *
     * @private
     * @returns {null|object}           Config data
     * -----------------------------------------------------------------------------*/
     async getConfig() {
        const configPath = resolve(this.paths.src, './config.json');

        if(!fs.existsSync(configPath)){
            log.error(
                copy.errors.noConfig,
                this.config.slug
            );
            return null;
        }


        let config = (await JSON.parse(
            await fs.readFileSync(configPath, 'utf8')
        ));


        if(Array.isArray(config.description)){
            config.description = config.description.join("\n\n")
        }


        return config;
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: getConfig
     * -----------------------------------------------------------------------------*/






    /**-----------------------------------------------------------------------------
     * getLastBuildVersion
     * -----------------------------------------------------------------------------
     * checks `dist` folder for the latest version of the package.
     * Returns false if not found
     *
     * @private
     * @returns {string|boolean}
     * -----------------------------------------------------------------------------*/
    async getLastBuildVersion()  {
        const configPath = resolve(this.paths.dist, `./${this.config.slug}.nuspec`);


        if(!fs.existsSync(configPath)){
            log.info(
                copy.noExistingBuild,
                this.config.slug
            );
            return false;
        }


        return (await fs.readFileSync(configPath, 'utf8'))
            .match(/<version>(.*?)<\/version>/i)[1];
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: getLastBuildVersion
     * -----------------------------------------------------------------------------*/



    /**-----------------------------------------------------------------------------
     * getLatestVars
     * -----------------------------------------------------------------------------
     * Executes package's `update.js`
     *
     * @private
     * @returns {*}
     * -----------------------------------------------------------------------------*/
    async getLatestVars() {
        log.info(
            copy.fetchingVars,
            this.config.slug
        );


        let hasFailed = false;
        const vars = await require(
            resolve(this.paths.src, './update.js')
        );


        Object.entries(vars).forEach(([varName, varValue]) => {
            if(!varValue){
                hasFailed = true;
                log.error(
                    copy.errors.varFailed,
                    {varName},
                    this.config.slug
                );
            }
        });



        if(hasFailed){
            log.error(
                copy.errors.skippingPackage,
                this.config.slug
            );

        }else{
            log.success(
                copy.fetchingVarsSuccesful,
                this.config.slug
            );

        }


        return !hasFailed && vars;
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: getLatestVars
     * -----------------------------------------------------------------------------*/




    /**-----------------------------------------------------------------------------
     * resetDist
     * -----------------------------------------------------------------------------
     * removes package's build
     *
     * @private
     * @returns {void}
     * -----------------------------------------------------------------------------*/
    resetDist() {
        log.info(
            copy.resettingDist.init,
            this.config.slug
        );


        return rmfr( this.paths.dist )
            .then(() => {
                log.success(
                    copy.resettingDist.success,
                    this.config.slug
                );
            })
            /* @TODO: error handling  */
            .catch(err => console.log(err));
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: resetDist
     * -----------------------------------------------------------------------------*/




    /**-----------------------------------------------------------------------------
     * plantFromSrc
     * -----------------------------------------------------------------------------
     * processes all files from the src folder
     *
     * @private
     * @param   {object}    vars        Package meta data to be injected to files
     * @returns {Promise}
     * -----------------------------------------------------------------------------*/
    plantFromSrc(vars) {
        if(vars.dependencies.length){
            vars.dependencies = vars.dependencies
                .map(dep => `\n${' '.repeat(12)}<dependency id="${dep}" />`);

            vars.dependencies += `\n${' '.repeat(8)}`;
        }

        return rcopy(this.paths.src, this.paths.dist, {
            filter: [
                '**/*',
                '!icon.*',
                '!config.json',
                '!update.js',
            ],
            transform: () => {
                return through(function write(data) {
                    this.emit('data', renderString(data.toString(), vars))
                });
            }
        })
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: plantFromSrc
     * -----------------------------------------------------------------------------*/




    /**-----------------------------------------------------------------------------
     * plantFromTemplates
     * -----------------------------------------------------------------------------
     * processes all common templates
     *
     * @private
     * @param   {object}    vars        Package meta data to be injected to files
     * @returns {Promise}
     * -----------------------------------------------------------------------------*/
    plantFromTemplates(vars) {
        return rcopy(DIR_TEMPLATES, this.paths.dist, {
            rename: (filePath) => (
                filePath.replace('packageName', this.config.slug)
            ),
            transform: () => {
                return through(function write(data) {
                    this.emit('data', renderString(data.toString(), vars))
                });
            }
        })
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: plantFromTemplates
     * -----------------------------------------------------------------------------*/




    /**-----------------------------------------------------------------------------
     * plantFiles
     * -----------------------------------------------------------------------------
     * hydrates and copies all src files to dist
     *
     * @private
     * @returns {Promise}
     * -----------------------------------------------------------------------------*/
    plantFiles() {
        log.info(
            copy.planting.init,
            this.config.slug
        );

        const vars = {
            ...this.config,
            ...this.vars
        };


        return Promise.all([
                this.plantFromSrc(vars),
          //      this.plantFromTemplates(vars)
            ])
            .then(() => {
                log.success(
                    copy.planting.success,
                    this.config.slug
                );
            })
            .catch((error) => {
                log.error(
                    copy.planting.error,
                    {error},
                    this.config.slug
                );
            });
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: plantFiles
     * -----------------------------------------------------------------------------*/




    /**-----------------------------------------------------------------------------
     * build
     * -----------------------------------------------------------------------------
     * trigger build pipeline
     *
     * @private
     * @returns {void}
     * -----------------------------------------------------------------------------*/
    async build() {
        return new Promise(async (resolve, reject) => {
            const lastBuildVersion = await this.getLastBuildVersion();
            const latestVars       = await this.getLatestVars();


            // exit early if not all vars were fetched
            if(!latestVars){
                resolve(this.config.slug)
            }


            this.config = {...(await this.getConfig())};
            this.vars   = {...latestVars};


            // build
            if(!lastBuildVersion || lastBuildVersion !== this.vars.version){
                // delete existing build if present and recreates the dir structure
                await this.resetDist();
                await this.plantFiles()

                // generate new build

                log.success(
                    copy.success,
                    {version: this.vars.version},
                    this.config.slug
                );
                resolve({
                    status:'success'
                });


            // skip as up to date.
            }else{
                log.success(copy.upToDate, this.config.slug);

                resolve({
                    status:'uptodate'
                });

            }
        })



    };
    /**-----------------------------------------------------------------------------
     * ENDOF: build
     * -----------------------------------------------------------------------------*/
};


module.exports = Builder;
