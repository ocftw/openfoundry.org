#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// 使用 file 命令檢測檔案類型
function detectFileTypeWithFile(filePath) {
    try {
        const output = execSync(`file -b "${filePath}"`, { encoding: 'utf8' });
        const fileType = output.trim().toLowerCase();

        // 根據 file 命令的輸出判斷檔案類型
        if (fileType.includes('html')) return 'html';
        if (fileType.includes('xml')) return 'xml';
        if (fileType.includes('svg')) return 'svg';
        if (fileType.includes('javascript') || fileType.includes('ecmascript')) return 'javascript';
        if (fileType.includes('json')) return 'json';
        if (fileType.includes('css')) return 'css';
        if (fileType.includes('png')) return 'png';
        if (fileType.includes('jpeg') || fileType.includes('jpg')) return 'jpg';
        if (fileType.includes('gif')) return 'gif';
        if (fileType.includes('pdf')) return 'pdf';
        if (fileType.includes('text')) {
            // 對於純文字檔案，檢查內容來進一步判斷
            const content = fs.readFileSync(filePath, 'utf8').substring(0, 100).toLowerCase();
            if (content.includes('<!doctype html') || content.includes('<html')) return 'html';
            if (content.includes('<?xml')) return 'xml';
            if (content.includes('<svg')) return 'svg';
            if (content.includes('function') || content.includes('var ') || content.includes('const ')) return 'javascript';
            if (content.startsWith('{') || content.startsWith('[')) return 'json';
            if (content.includes('{') && (content.includes('color:') || content.includes('font-'))) return 'css';
        }

        return 'unknown';
    } catch (error) {
        console.error(`檢測檔案類型錯誤 ${filePath}:`, error.message);
        return 'error';
    }
}

// 主掃描函數
function scanHtmlFiles() {
    const targetDir = '/Users/Irvin/Downloads/sinica/openfoundry';
    const results = {
        html: [],
        xml: [],
        svg: [],
        javascript: [],
        json: [],
        css: [],
        png: [],
        jpg: [],
        gif: [],
        pdf: [],
        unknown: [],
        error: []
    };

    console.log('開始掃描 .html 檔案...');

    try {
        // 使用 find 命令找出所有 .html 檔案
        const findCommand = `find "${targetDir}" -name "*.html" -type f`;
        const output = execSync(findCommand, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 50 });
        const htmlFiles = output.trim().split('\n').filter(file => file.length > 0);

        console.log(`找到 ${htmlFiles.length} 個 .html 檔案`);

        // 處理每個檔案
        htmlFiles.forEach((filePath, index) => {
            if (index % 100 === 0) {
                console.log(`處理進度: ${index}/${htmlFiles.length}`);
            }

            const fileType = detectFileTypeWithFile(filePath);
            results[fileType].push(filePath);
        });

        console.log('\n掃描完成！結果統計：');
        Object.keys(results).forEach(type => {
            if (results[type].length > 0) {
                console.log(`${type}: ${results[type].length} 個檔案`);
            }
        });

        return results;
    } catch (error) {
        console.error('掃描過程發生錯誤:', error.message);
        return null;
    }
}

// 重新命名和刪除檔案
function processFiles(results) {
    console.log('\n開始處理檔案...');

    let renamedCount = 0;
    let deletedCount = 0;

    // 重新命名檔案
    const renameMap = {
        xml: '.xml',
        svg: '.svg',
        javascript: '.js',
        json: '.json',
        css: '.css',
        png: '.png',
        jpg: '.jpg',
        gif: '.gif',
        pdf: '.pdf'
    };

    Object.keys(renameMap).forEach(type => {
        const extension = renameMap[type];
        results[type].forEach(filePath => {
            try {
                const newPath = filePath.replace(/\.html$/i, extension);
                fs.renameSync(filePath, newPath);
                console.log(`重新命名: ${path.basename(filePath)} -> ${path.basename(newPath)}`);
                renamedCount++;
            } catch (error) {
                console.error(`重新命名失敗 ${filePath}:`, error.message);
            }
        });
    });

    // 刪除無法辨識的檔案
    [...results.unknown, ...results.error].forEach(filePath => {
        try {
            fs.unlinkSync(filePath);
            console.log(`刪除: ${path.basename(filePath)}`);
            deletedCount++;
        } catch (error) {
            console.error(`刪除失敗 ${filePath}:`, error.message);
        }
    });

    console.log(`\n處理完成！`);
    console.log(`重新命名: ${renamedCount} 個檔案`);
    console.log(`刪除: ${deletedCount} 個檔案`);
    console.log(`保持不變 (HTML): ${results.html.length} 個檔案`);
}

// 主程式
function main() {
    console.log('HTML 檔案掃描和修正工具 (使用 file 命令)');
    console.log('==========================================');

    const results = scanHtmlFiles();
    if (results) {
        processFiles(results);
    }
}

// 執行主程式
if (require.main === module) {
    main();
}

module.exports = { detectFileTypeWithFile, scanHtmlFiles, processFiles };
