const fetch       = require('node-fetch');
const {basename}  = require('path');
const getChecksum = require('../../.choco/scripts/helpers/getChecksum');


const data = {
    downloadUrl  : 'https://www.figma.com/download/desktop/win',
    version      : '3.6.15',
    checksum     : false,
    checksumType : 'sha256'
};


module.exports = new Promise(async (resolve) => {
    data.checksum = await getChecksum({
        slug   : basename(__dirname),
        version: data.version,
        url    : data.downloadUrl
    });


    resolve(data);
});
