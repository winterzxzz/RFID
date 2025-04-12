const moment = require('moment');

const convertVietnameseNameToEnglish = (vietnameseName) => {
    return vietnameseName
        .normalize('NFD') // Normalize to separate diacritics from characters
        .replace(/[\u0300-\u036f]/g, '') // Remove diacritic marks
        .replace(/đ/g, 'd') // Replace lowercase đ
        .replace(/Đ/g, 'D'); // Replace uppercase Đ
};

const getCurrentDate = () => moment().format('YYYY-MM-DD');
const getCurrentTime = () => moment().format('HH:mm:ss');

module.exports = {
    convertVietnameseNameToEnglish,
    getCurrentDate,
    getCurrentTime
};