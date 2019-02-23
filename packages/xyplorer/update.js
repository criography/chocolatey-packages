const fetch = require('node-fetch');


const URL = 'https://www.xyplorer.com/';

const data = {
    downloadUrl  : false,
    version      : false,
    checksum     : false,
    checksumType : 'sha256'
};


module.exports = fetch(`${URL}download.php`)
    .then(response => response.text())
    .then(text => {
        data.downloadUrl = URL + text.match(/href="(.*?\.zip)"/)[1],
        data.version     = text.match(/>Version<.*?([\d.]{4,}) /)[1]

        return (URL + text.match(/Hash Values:[\s\S]*?href="(.*?\.txt)"/)[1]);
    })
    .then(checksumUrl => fetch(checksumUrl))
    .then(response => response.text())
    .then(text => {
        data.checksum = text.match(/sha-256\s+?(\w*?)$/mi)[1]

        return data;
    });
