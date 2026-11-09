// scripts/pre_har_install.mjs
import { execFileSync } from 'child_process';
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.resolve(__dirname, '..');
// roundedimageview/oh-package.json5 以 ./har/xxx.har 引用预编译依赖
const HAR_DIR = path.join(PROJECT_ROOT, 'roundedimageview', 'har');
// svg4cj 发布产物文件名包含 SDK 版本（svg_{SDK_VERSION}-v2.0.0.har），升级工程 modelVersion 时需同步更新此处
const SDK_VERSION = '6.1.1';
// 下载超时控制：连接与传输均设上限，防止流水线因网络挂起无限等待
const CURL_CONNECT_TIMEOUT_SECONDS = 30;
const CURL_MAX_TIME_SECONDS = 600;

// Cangjie-TPC 在 gitcode.com 发布的 v2.0.0 产物清单，与下载内容 SHA256 绑定，
// 校验不一致即视为下载损坏或被篡改，不会进入构建
const ARTIFACTS = [
    {
        name: 'svg.har',
        url: `https://gitcode.com/Cangjie-TPC/svg4cj/releases/download/v2.0.0/svg_${SDK_VERSION}-v2.0.0.har`,
        sha256: '902dff099faa696b8ab7aa6be7d9356029caa86544ff2acf15d8ec0615b3840f'
    }
];

// 流式读取计算 SHA256，避免大文件一次性读入内存
function sha256(filePath) {
    return new Promise((resolve, reject) => {
        const hash = crypto.createHash('sha256');
        fs.createReadStream(filePath)
            .on('data', chunk => hash.update(chunk))
            .on('end', () => resolve(hash.digest('hex')))
            .on('error', reject);
    });
}

// 校验单个 HAR：存在、非空且 SHA256 与锁定值一致
async function isValid(filePath, expectedSha256) {
    if (!fs.existsSync(filePath) || !fs.statSync(filePath).isFile()) {
        return false;
    }
    if (fs.statSync(filePath).size === 0) {
        return false;
    }
    return (await sha256(filePath)) === expectedSha256;
}

// 以参数数组方式调用外部命令（不经 shell 解析），路径中的空格或特殊字符不影响执行
function runCommand(command, args) {
    try {
        execFileSync(command, args, { stdio: 'inherit' });
    } catch (error) {
        if (error.code === 'ENOENT') {
            console.error(`Command "${command}" not found. Please install it and re-run.`);
        }
        throw error;
    }
}

// 删除文件失败仅告警，不掩盖调用方的原始错误
function safeUnlink(filePath) {
    try {
        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
        }
    } catch (error) {
        console.error(`Failed to remove file ${filePath}: ${error.message}`);
    }
}

async function downloadArtifact(artifact) {
    const target = path.join(HAR_DIR, artifact.name);
    const temp = `${target}.download`;

    console.log(`Downloading ${artifact.name} ...`);
    runCommand('curl', ['-L', '--fail', '--retry', '3',
        '--connect-timeout', String(CURL_CONNECT_TIMEOUT_SECONDS),
        '--max-time', String(CURL_MAX_TIME_SECONDS),
        '-o', temp, artifact.url]);

    if (!fs.existsSync(temp) || fs.statSync(temp).size === 0) {
        throw new Error(`${artifact.name} download is empty`);
    }

    // SHA256 校验，不一致则终止，防止损坏或被篡改的 HAR 进入构建
    const actual = await sha256(temp);
    if (actual !== artifact.sha256) {
        throw new Error(`${artifact.name} SHA256 mismatch: expected ${artifact.sha256}, got ${actual}`);
    }

    // 校验通过后再落位，避免中断的下载残留半截文件
    safeUnlink(target);
    fs.renameSync(temp, target);
    console.log(`${artifact.name} verified.`);
}

async function main() {
    // HAR 全部存在且校验通过则跳过，否则逐个补齐缺失或损坏的文件
    const pending = [];
    for (const artifact of ARTIFACTS) {
        if (!(await isValid(path.join(HAR_DIR, artifact.name), artifact.sha256))) {
            pending.push(artifact);
        }
    }

    if (pending.length === 0) {
        console.log(`HAR dependencies already exist at ${HAR_DIR}, skipping download.`);
        return;
    }

    console.log(`Downloading required HAR files to ${HAR_DIR}...`);
    try {
        fs.mkdirSync(HAR_DIR, { recursive: true });
        for (const artifact of pending) {
            await downloadArtifact(artifact);
        }
        // 下载后整体复查：所有 HAR 均存在且 SHA256 一致
        for (const artifact of ARTIFACTS) {
            if (!(await isValid(path.join(HAR_DIR, artifact.name), artifact.sha256))) {
                throw new Error('HAR verification incomplete after download');
            }
        }
        console.log(`All HAR files downloaded and verified: ${HAR_DIR}`);
    } catch (error) {
        console.error(`Download or verification failed: ${error.message}`);
        for (const artifact of ARTIFACTS) {
            safeUnlink(path.join(HAR_DIR, `${artifact.name}.download`));
        }
        process.exit(1);
    }
}

await main();
