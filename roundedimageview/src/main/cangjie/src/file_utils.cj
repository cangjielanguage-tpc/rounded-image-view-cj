/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

class FileUtils {
    private static var sInstance: ?FileUtils = Option<FileUtils>.None

    private init() {
    }

    static func getInstance(): FileUtils {
        if (let Some(instance) <- FileUtils.sInstance) {
        } else {
            FileUtils.sInstance = FileUtils()
        }
        return FileUtils.sInstance()
    }

    /**
     * 新建文件
     */
    func createFile(path: String): Int32 {
        let fd = FileFs.open(path, mode: 0o100)
        return fd.fd
    }

    /**
     * 删除文件
     */
    func deleteFile(path: String): Unit {
        FileFs.unlink(path)
    }

    /**
     * 判断path文件是否存在
     */
    func exist(path: String): Bool {
        try {
            let stat = FileFs.stat(path)
            return stat.isFile()
        } catch (e: Exception) {
            AppLog.error("FileUtils exist error： ${e}")
            return false
        }
    }

    /**
     * 创建文件夹
     */
    func createFolder(path: String): Unit {
        // 创建文件夹
        if (!this.existFolder(path)) {
            FileFs.mkdir(path)
        }
    }

    /**
     * 判断文件夹是否存在
     */
    func existFolder(path: String): Bool {
        try {
            let stat = FileFs.stat(path)
            return stat.isDirectory()
        } catch (e: Exception) {
            AppLog.error("FileUtils existFolder error: ${e}")
            return false
        }
    }

    /**
     * 读取路径path的文件
     */
    func readFilePic(path: String): Array<Byte> {
        try {
            let fd = FileFs.open(path, mode: 0o2)
            let length = FileFs.stat(path).size
            let buf = Array<Byte>(length, item: 0)
            FileFs.read(fd.fd, buf)
            return buf
        } catch (e: Exception) {
            AppLog.error("FileUtils readFilePic error: ${e}")
            return Array<Byte>(0, item: 0)
        }
    }

    /**
     * 向path写入数据
     */
    func writePic(path: String, picData: Array<Byte>) {
        this.createFile(path)
        try {
            let fd = FileFs.open(path, mode: 0o102)
            FileFs.write(fd.fd, picData)
            FileFs.close(fd)
        } catch (e: Exception) {
            AppLog.error("FileUtils writePic error: ${e}")
        }
    }
}
