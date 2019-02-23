const fs                = require('fs');
const {resolve, join}   = require('path');
const request           = require('request');
const progress          = require('request-progress');
//const ProgressBar       = require('ascii-progress');
const mkdirp            = require('mkdirp-promise');
const hasha             = require('hasha');

const {DIR_CACHE} = require('../constants');



let bar;




const getChecksum = async ({slug, version, url, ext}) => {
    const outputDir      = join(DIR_CACHE, slug, version);
    const filename       = url.split('/').splice(-1)[0];
    const outputFilePath = join(
        outputDir,
        `${filename}${ext ? `.${ext}` : ''}`
    );


    // @TODO exit early if version cache exists and just get the checksum. maybe even store checksum in a file?

    await mkdirp(outputDir);

    await new Promise((resolve, reject) => {
        progress(request(url))

            .on('progress', (state) => {
/*                if(!bar) {
                    bar = new ProgressBar( {
                        schema    : ' Downloading.green [:bar.yellow] :percent :etas',
                        fixedWidth: 1
                    } );
                }

                bar.update( state.size.transferred / state.size.total );*/
            })


            .on('error', (err) => {
                reject('poop, file not doenloaded ' + err)
            })


            .on('end', () => {
/*                bar.setSchema(' Downloaded.green  [:bar.green] :percent.green :etas.green');
                bar.update(1);*/
                resolve();
            })


            .pipe(fs.createWriteStream(
                outputFilePath
            ));
    });


    return hasha.fromFile(outputFilePath, {algorithm: 'sha256'})
        .then(hash => hash)

};



module.exports = getChecksum;
