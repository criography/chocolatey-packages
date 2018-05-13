// libs
const {readdirSync, statSync} = require('fs');
const {join}                  = require('path');

// app
const log     = require('../helpers/log');
const Builder = require('./Builder');


// this
const copy      = require('./copy');
const {DIR_SRC} = require('../constants');





class BuildManager {
    constructor(argv){
        // all existing packages
        this.availablePackages = this.getAllPackageSlugs();

         // packages to be processed
        this.packages = [];


        this.init(argv)
    }




    /**-----------------------------------------------------------------------------
     * init
     * -----------------------------------------------------------------------------
     * figures out which packages (if any) are to be rebuilt and triggers the process
     *
     * @private
     * @param   {array}     [argv]      CLI arguments
     * @returns {void}
     * -----------------------------------------------------------------------------*/
    init(argv) {
        const params = argv.slice(2)

        // build all packages if no slug passed
        if(!params.length){
            this.packages.push(...this.availablePackages);


        }else{
            //exit early if passed argument doesn't match any existing package
            if(!this.availablePackages.includes(params[0])){
                log.error(
                    copy.packageNotFound.replace(
                        '{{slug}}',
                        params[0]
                    )
                );

                process.exit();
            }


            this.packages.push(params[0])
        }



        this.scheduleBuild();

    };


    /**-----------------------------------------------------------------------------
     * ENDOF: init
     * -----------------------------------------------------------------------------*/





    /**-----------------------------------------------------------------------------
     * getAllPackageSlugs
     * -----------------------------------------------------------------------------
     * retrieves all available packages from the src folder.
     * It's an optimistic check for directories only,
     * config file presence will be check by individual build instances
     *
     * @private
     * @returns {array}     Array of package slugs
     * -----------------------------------------------------------------------------*/
    getAllPackageSlugs() {
        return readdirSync(DIR_SRC)
            .filter(
                item => statSync(join(DIR_SRC, item)).isDirectory()
            )
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: getAllPackageSlugs
     * -----------------------------------------------------------------------------*/






    /**-----------------------------------------------------------------------------
     * scheduleBuild
     * -----------------------------------------------------------------------------
     * create async build instances of each package's build and responds to their results
     *
     * @private
     * @returns {void}
     * -----------------------------------------------------------------------------*/
    scheduleBuild() {
        const builds = [];
        this.packages.forEach(choco => {
            builds.push(new Builder(choco))
        })
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: scheduleBuild
     * -----------------------------------------------------------------------------*/
}


new BuildManager(process.argv);
