const fetch       = require('node-fetch');
const {basename}  = require('path');
const getChecksum = require('../scripts/helpers/getChecksum');


const data = {
    downloadUrl : false,
    version     : false,
    checksum    : false,
    checksumType: 'sha256'
};


module.exports = fetch('')
    .then(response => response.text())

    // extract vars and return them all
    .then(async text => {
        data.downloadUrl = text.match(//i)[1];
        data.version     = text.match(//i)[1];
        data.checksum    = await getChecksum({
            slug   : basename(__dirname),
            version: data.version,
            url    : data.downloadUrl,
            ext    : false
        });

        return data;
    });
