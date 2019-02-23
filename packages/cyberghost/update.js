const fetch       = require('node-fetch');
const {basename}  = require('path');
const getChecksum = require('../../src/scripts/helpers/getChecksum');



const data = {
    downloadUrl : 'https://www.cyberghostvpn.com/download/cgsetup_en.exe',
    version     : false,
    checksum    : false,
    checksumType: 'sha256'
};


module.exports = fetch('http://www.computerbild.de/download/CyberGhost-VPN-2311961.html')
    .then(response => response.text())

    // extract vars and return them all
    .then(async text => {
        data.version = text.match(/itemprop="softwareVersion".*?([\d.]{3,})</i)[1];
        data.checksum = await getChecksum({
            slug   : basename(__dirname),
            version: data.version,
            url    : data.downloadUrl
        });

        return data;
    });
