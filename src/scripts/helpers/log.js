const timestamp = require('time-stamp');
const chalk     = require('chalk');


const getArgs = ([msg, ...args]) => {
    let processedMsg = msg;
    let choco = '';


    args.forEach(arg => {
        if(arg){
            if(typeof arg === 'string'){
                choco = arg;

            }else if(arg !== null && typeof arg === 'object' && Object.keys(arg).length){
                processedMsg = Object.entries(arg)
                    .reduce((aggregated, [search, replace]) => (
                        aggregated.replace(`{{${search}}}`, replace)
                    ), msg);
            }
        }
    });


    return {
        msg : processedMsg,
        choco
    }
};


const log = ({type: logType, args}) => {
    const styles = {
        plain  : {fill: 'bgWhite',  text: 'black'},
        info   : {fill: 'bgBlue',   text: 'black'},
        warn   : {fill: 'bgYellow', text: 'gray'},
        success: {fill: 'bgGreen',  text: 'gray'},
        error  : {fill: 'bgRed',    text: 'black'}
    };
    const {msg, choco} = getArgs(args);
    const time         = timestamp('HH:mm:ss');
    const prefix       = chalk[
            styles[logType].fill
        ][
            styles[logType].text
        ](` ${time}${choco ? ` | ${choco}` : ''} `);


    console.log(`${prefix} ${msg}`);
};


const plain = (...args) => {
    log({
        type : 'plain',
        args
    })
};

const info = (...args) => {
    log({
        type : 'info',
        args
    })
};

const warn = (...args) => {
    log({
        type : 'warn',
        args
    })
};

const success = (...args) => {
    log({
        type : 'success',
        args
    })
};

const error = (...args) => {
    log({
        type : 'error',
        args
    })
};



module.exports         = plain;
module.exports.info    = info;
module.exports.success = success;
module.exports.warn    = warn;
module.exports.error   = error;
