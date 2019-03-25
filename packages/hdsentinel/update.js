const fetch       = require('node-fetch');
const {basename}  = require('path');
const getChecksum = require('../../src/scripts/helpers/getChecksum');
const https       = require("https");
const data        = {
    downloadUrl  : 'https://www.harddisksentinel.com/hdsentinel_setup.zip',
    checksum     : false,
    version      : false,
    checksumType : 'sha256'
};



module.exports = (
    new Promise(resolve => {
        https.get('https://www.hdsentinel.com/revision.php', res => {
            res.setEncoding("utf8");
            let body = "";
            res.on("data", data => {
                body += data;
            });
            res.on("end", () => {
                resolve(body);
            });
        })
    })
    // extract vars and return them all
    .then(async text => {
        data.version = text.match(/<h3>Hard Disk Sentinel ([\d.]+?) /i)[1];
        data.checksum = await getChecksum({
            slug    : basename(__dirname),
            version : data.version,
            url     : data.downloadUrl
        });

        return data;
    })
    .catch((err) => {
        console.error(err);
        process.exit();
    })

);
