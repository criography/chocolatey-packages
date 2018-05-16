const fetch       = require('node-fetch');
const {basename}  = require('path');
const getChecksum = require('../../.choco/scripts/helpers/getChecksum');

const data = {
    downloadUrl : 'http://www.harddisksentinel.com/hdsentinel_setup.zip',
    checksum    : false,
    version     : false,
    checksumType:'sha256'
};



module.exports = fetch('http://www.hdsentinel.com/revision.php')
    .then(response => response.text())

    // extract vars and return them all
    .then(async text => {
        data.version = text.match(/<h3>Hard Disk Sentinel ([\d.]+?) /i)[1];

        data.checksum = await getChecksum({
            slug   : basename( __dirname ),
            version: data.version,
            url    : data.downloadUrl
        });

        return data;
    });
