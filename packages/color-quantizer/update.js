const fetch       = require('node-fetch');
const {basename}  = require('path');
const getChecksum = require('../../src/scripts/helpers/getChecksum');



const data = {
    downloadUrl : false,
    version     : false,
    checksum    : false,
    checksumType: 'sha256'
};


module.exports = fetch('http://x128.ho.ua/color-quantizer.html')
    .then(response => response.text())

    // extract vars and return them all
    .then(async text => {
        const extraction = text.match(/Download" href="(http.*?\.zip)".*? ([\d.]*?) /i);
        data.downloadUrl = extraction[1];
        data.version     = extraction[2];

        data.checksum    = await getChecksum({
            slug   : basename(__dirname),
            version: data.version,
            url    : data.downloadUrl
        });

        return data;
    });
