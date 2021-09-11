const fs                = require('fs');
const {join, resolve}   = require('path');
const rmfr              = require('rmfr');
const mkdirp            = require('mkdirp');
const rcopy             = require('recursive-copy');
const through           = require('through');
const {renderString}    = require('template-file');

const {
    DIR_SRC,
    DIR_TEMPLATES
}          = require('../constants');
const log  = require('../helpers/log');
const copy = require('./copy');




class Creator {
    constructor(argv){
        // exit early if no name
       if(!argv || (argv && !argv[2])){
           log.error(copy.missingName);
           process.exit();
       }


       this.choco   = argv[2];
       this.srcPath = join(DIR_SRC, argv[2]);


       return this.create();
    }





    /**-----------------------------------------------------------------------------
     * plantFromTemplates
     * -----------------------------------------------------------------------------
     * processes all common templates
     *
     * @private
     * @returns {Promise}
     * -----------------------------------------------------------------------------*/
    plantFromTemplates() {
        const vars = {slug: this.choco};


        return rcopy(DIR_TEMPLATES, this.srcPath, {
            rename: (filePath) => (
                filePath.replace('packageName', this.choco)
            ),
            transform: () => {
                return through(function write(data) {
                    this.emit('data', data.toString().replace('{{slug}}', vars.slug))
                });
            }
        })
    };
    /**-----------------------------------------------------------------------------
     * ENDOF: plantFromTemplates
     * -----------------------------------------------------------------------------*/




    /**-----------------------------------------------------------------------------
     * build
     * -----------------------------------------------------------------------------
     * trigger package scaffolding
     *
     * @private
     * @returns {void}
     * -----------------------------------------------------------------------------*/
    async create() {
        if(!fs.existsSync(this.srcPath)){
            await this.plantFromTemplates();

            log.success(
                copy.packageCreated,
                this.choco
            );

        }else{
            log.warn(
                copy.packageExists,
                this.choco
            );
        }

    };
    /**-----------------------------------------------------------------------------
     * ENDOF: build
     * -----------------------------------------------------------------------------*/
};



module.exports = new Creator(process.argv);
