// scripts/pre_stdx_install.mjs
import { execFileSync } from 'child_process';
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.resolve(__dirname, '../roundedimageview');

const ARM64_ZIP_URL = 'https://gitcode.com/Cangjie/cangjie-stdx-bin/releases/download/v1.0.1.1/cangjie-stdx-ohos-aarch64-1.0.1.1.zip';
const ARM64_ZIP_TEMP_PATH = path.join(PROJECT_ROOT, 'cangjie-stdx-ohos-aarch64-1.0.1.1.zip');
const ARM64_ZIP_SHA256 = '94b0db59e7591eb166d48114e512e0b64fef4b48dbb9a2aff0e8a1029e6d8db9';

const X64_ZIP_URL = 'https://gitcode.com/Cangjie/cangjie-stdx-bin/releases/download/v1.0.1.1/cangjie-stdx-ohos-x64-1.0.1.1.zip';
const X64_ZIP_TEMP_PATH = path.join(PROJECT_ROOT, 'cangjie-stdx-ohos-x64-1.0.1.1.zip');
const X64_ZIP_SHA256 = '570480aa282e8366ce8f18ef0dca0c228e40a202ff4ccdebbfcc10a96d43a571';

// 仅校验项目内的 stdx 库，不读取任何本地环境变量
const STDX_BIN_PATH = path.join(PROJECT_ROOT, 'stdx_bin');

// cangjie-stdx-ohos v1.0.1.1 各架构 static/stdx 的完整文件清单，与下载 zip 的 SHA256 绑定，
// 用于检测解压中断导致的目录残缺（缺文件时视为未就绪，重新触发下载）
const REQUIRED_STDX_FILES = [
    'libcangjie-dynamicLoader-opensslFFI.a',
    'libsecurec-static.a',
    'libstdx.a',
    'libstdx.aspectCJ.a',
    'libstdx.aspectCJ.bc',
    'libstdx.bc',
    'libstdx.compress.a',
    'libstdx.compress.bc',
    'libstdx.compress.zlib.a',
    'libstdx.compress.zlib.bc',
    'libstdx.compress.zlibFFI.a',
    'libstdx.crypto.a',
    'libstdx.crypto.bc',
    'libstdx.crypto.crypto.a',
    'libstdx.crypto.crypto.bc',
    'libstdx.crypto.digest.a',
    'libstdx.crypto.digest.bc',
    'libstdx.crypto.keys.a',
    'libstdx.crypto.keys.bc',
    'libstdx.crypto.keysFFI.a',
    'libstdx.crypto.x509.a',
    'libstdx.crypto.x509.bc',
    'libstdx.crypto.x509FFI.a',
    'libstdx.encoding.a',
    'libstdx.encoding.base64.a',
    'libstdx.encoding.base64.bc',
    'libstdx.encoding.bc',
    'libstdx.encoding.hex.a',
    'libstdx.encoding.hex.bc',
    'libstdx.encoding.json.a',
    'libstdx.encoding.json.bc',
    'libstdx.encoding.json.stream.a',
    'libstdx.encoding.json.stream.bc',
    'libstdx.encoding.json.streamFFI.a',
    'libstdx.encoding.jsonFFI.a',
    'libstdx.encoding.url.a',
    'libstdx.encoding.url.bc',
    'libstdx.fuzz.a',
    'libstdx.fuzz.bc',
    'libstdx.fuzz.fuzz.a',
    'libstdx.fuzz.fuzz.bc',
    'libstdx.fuzz.fuzzFFI.a',
    'libstdx.log.a',
    'libstdx.log.bc',
    'libstdx.logger.a',
    'libstdx.logger.bc',
    'libstdx.net.a',
    'libstdx.net.bc',
    'libstdx.net.http.a',
    'libstdx.net.http.bc',
    'libstdx.net.tls.a',
    'libstdx.net.tls.bc',
    'libstdx.net.tlsFFI.a',
    'libstdx.serialization.a',
    'libstdx.serialization.bc',
    'libstdx.serialization.serialization.a',
    'libstdx.serialization.serialization.bc',
    'libstdx.unittest.a',
    'libstdx.unittest.bc',
    'libstdx.unittest.data.a',
    'libstdx.unittest.data.bc',
    'stdx.aspectCJ.cjo',
    'stdx.cjo',
    'stdx.compress.cjo',
    'stdx.compress.zlib.cjo',
    'stdx.crypto.cjo',
    'stdx.crypto.crypto.cjo',
    'stdx.crypto.digest.cjo',
    'stdx.crypto.keys.cjo',
    'stdx.crypto.x509.cjo',
    'stdx.encoding.base64.cjo',
    'stdx.encoding.cjo',
    'stdx.encoding.hex.cjo',
    'stdx.encoding.json.cjo',
    'stdx.encoding.json.stream.cjo',
    'stdx.encoding.url.cjo',
    'stdx.fuzz.cjo',
    'stdx.fuzz.fuzz.cjo',
    'stdx.log.cjo',
    'stdx.logger.cjo',
    'stdx.net.cjo',
    'stdx.net.http.cjo',
    'stdx.net.tls.cjo',
    'stdx.serialization.cjo',
    'stdx.serialization.serialization.cjo',
    'stdx.unittest.cjo',
    'stdx.unittest.data.cjo'
];

// 校验单个架构的静态库是否完整：static/stdx 目录下清单内文件全部存在
function hasArchBinaries(basePath, archDir) {
    const staticStdxPath = path.join(basePath, archDir, 'static', 'stdx');
    if (!fs.existsSync(staticStdxPath) || !fs.statSync(staticStdxPath).isDirectory()) {
        return false;
    }
    return REQUIRED_STDX_FILES.every(file => fs.existsSync(path.join(staticStdxPath, file)));
}

function hasStdxBinaries(basePath) {
    return hasArchBinaries(basePath, 'linux_ohos_aarch64_llvm') &&
        hasArchBinaries(basePath, 'linux_ohos_x86_64_llvm');
}

function sha256(filePath) {
    return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
}

// 以参数数组方式调用外部命令（不经 shell 解析），路径中的空格或特殊字符不影响执行
function runCommand(command, args) {
    try {
        execFileSync(command, args, { stdio: 'inherit', cwd: PROJECT_ROOT });
    } catch (error) {
        if (error.code === 'ENOENT') {
            console.error(`Command "${command}" not found. Please install it and re-run.`);
        }
        throw error;
    }
}

function downloadAndExtract(label, zipUrl, tempPath, expectedSha256, extractPath) {
    console.log(`Downloading ${label} version...`);
    runCommand('curl', ['-L', '-o', tempPath, zipUrl]);

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
            // PowerShell 单引号字面量中的单引号需成对转义
            const psQuote = value => `'${String(value).replace(/'/g, "''")}'`;
            runCommand('powershell', ['-NoProfile', '-Command',
                `Expand-Archive -LiteralPath ${psQuote(tempPath)} -DestinationPath ${psQuote(extractPath)} -Force`]);
        } else {
            runCommand('unzip', ['-o', tempPath, '-d', extractPath]);
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
