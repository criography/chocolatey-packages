const fetch       = require('node-fetch');
const {basename}  = require('path');
const getChecksum = require('../../.choco/scripts/helpers/getChecksum');


const data = {
    downloadUrl  : false,
    version      : false,
    checksum     : false,
    checksumType : 'sha256'
};


module.exports = fetch('https://www8.garmin.com/support/download_details.jsp?id=4435')
    .then(response => response.text())
    .then(async text => {
        data.version     = text.match(/meta name="software_version" content="([\d.]+?)"/i)[1];
        data.downloadUrl = text.match(/<a href="(.*?\.exe)"/i)[1];

        data.checksum = await getChecksum({
            slug   : basename(__dirname),
            version: data.version,
            url    : data.downloadUrl
        });

        return data;
    });
