// scripts/pre_stdx_install.mjs
import { execSync } from 'child_process';
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.resolve(__dirname, '../roundedimageview');

const ARM64_ZIP_URL = 'https://gitcode.com/Cangjie/cangjie_stdx/releases/download/v1.1.3.1/cangjie-stdx-ohos-aarch64-1.1.3.1.zip';
const ARM64_ZIP_TEMP_PATH = path.join(PROJECT_ROOT, 'cangjie-stdx-ohos-aarch64-1.1.3.1.zip');
const ARM64_ZIP_SHA256 = '21f452444d7f7106c2a7e376aa335a1e6d4308453ac1d7ad699f2fbf93ff5528';

const X64_ZIP_URL = 'https://gitcode.com/Cangjie/cangjie_stdx/releases/download/v1.1.3.1/cangjie-stdx-ohos-x64-1.1.3.1.zip';
const X64_ZIP_TEMP_PATH = path.join(PROJECT_ROOT, 'cangjie-stdx-ohos-x64-1.1.3.1.zip');
const X64_ZIP_SHA256 = '822be67189eaef7d856f2d3bde8fdb68b82bfc44b6a3a67a01a93b40e6fe90ff';

// 仅校验项目内的 stdx 库，不读取任何本地环境变量
const STDX_BIN_PATH = path.join(PROJECT_ROOT, 'stdx_bin');

// 校验单个架构的静态库是否完整：static/stdx 目录存在且非空
function hasArchBinaries(basePath, archDir) {
    const staticStdxPath = path.join(basePath, archDir, 'static', 'stdx');
    return fs.existsSync(staticStdxPath) &&
        fs.statSync(staticStdxPath).isDirectory() &&
        fs.readdirSync(staticStdxPath).length > 0;
}

function hasStdxBinaries(basePath) {
    return hasArchBinaries(basePath, 'linux_ohos_aarch64_cjnative') &&
        hasArchBinaries(basePath, 'linux_ohos_x86_64_cjnative');
}

function sha256(filePath) {
    return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
}

function downloadAndExtract(label, zipUrl, tempPath, expectedSha256, extractPath) {
    console.log(`Downloading ${label} version...`);
    execSync(`curl -L -o ${tempPath} ${zipUrl}`, {
        stdio: 'inherit',
        cwd: PROJECT_ROOT
    });

    if (fs.existsSync(tempPath)) {
        if (fs.statSync(tempPath).size === 0) {
            console.error(`${label} ZIP file is empty, download failed`);
            fs.unlinkSync(tempPath);
            process.exit(1);
        }
    } else {
        console.error(`${label} ZIP file not found`);
        process.exit(1);
    }

    // SHA256 校验，不一致则终止，防止被篡改的二进制进入构建环境
    const actualSha256 = sha256(tempPath);
    if (actualSha256 !== expectedSha256) {
        console.error(`${label} ZIP SHA256 mismatch: expected ${expectedSha256}, got ${actualSha256}`);
        fs.unlinkSync(tempPath);
        process.exit(1);
    }
    console.log(`${label} ZIP SHA256 verified.`);

    try {
        console.log(`Extracting ${label} version...`);
        if (process.platform === 'win32') {
            execSync(`powershell -Command "Expand-Archive -Path '${tempPath}' -DestinationPath '${extractPath}' -Force"`, {
                stdio: 'inherit',
                cwd: PROJECT_ROOT
            });
        } else {
            execSync(`unzip -o ${tempPath} -d ${extractPath}`, {
                stdio: 'inherit',
                cwd: PROJECT_ROOT
            });
        }
    } finally {
        if (fs.existsSync(tempPath)) {
            fs.unlinkSync(tempPath);
        }
    }
}

// 模块 stdx_bin 下两套架构的静态库完整则跳过，否则下载
if (hasStdxBinaries(STDX_BIN_PATH)) {
    console.log(`stdx binaries already exist at ${STDX_BIN_PATH}, skipping download.`);
} else {
    console.log(`Downloading required files to ${STDX_BIN_PATH}...`);
    try {
        fs.mkdirSync(STDX_BIN_PATH, { recursive: true });

        downloadAndExtract('ARM64', ARM64_ZIP_URL, ARM64_ZIP_TEMP_PATH, ARM64_ZIP_SHA256, STDX_BIN_PATH);
        downloadAndExtract('X64', X64_ZIP_URL, X64_ZIP_TEMP_PATH, X64_ZIP_SHA256, STDX_BIN_PATH);

        console.log(`All files downloaded and extracted successfully to ${STDX_BIN_PATH}`);
    } catch (error) {
        console.error(`Download or extraction failed: ${error.message}`);
        if (fs.existsSync(ARM64_ZIP_TEMP_PATH)) {
            fs.unlinkSync(ARM64_ZIP_TEMP_PATH);
        }
        if (fs.existsSync(X64_ZIP_TEMP_PATH)) {
            fs.unlinkSync(X64_ZIP_TEMP_PATH);
        }
        process.exit(1);
    }
}
