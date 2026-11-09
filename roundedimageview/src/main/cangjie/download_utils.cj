package roundedimageview

// HTTP 下载结果载体：bytes/ok/done 由回调线程写入、等待线程读取，
// 全部读写均在 mutex 保护下进行，通过 condition 阻塞等待，消除忙等轮询与数据竞争；
// 超时后回调晚到也只会加锁写入一次，不会破坏状态一致性
class DownloadHttpResult {
    var bytes: Array<Byte> = Array<Byte>()
    // 与管线约定一致：true 表示加载成功
    var ok: Bool = false
    var done: Bool = false
    let mutex: Mutex = Mutex()
    let condition: Condition

    init() {
        this.condition = synchronized(this.mutex) { this.mutex.condition() }
    }

    // 回调线程写入结果并唤醒等待线程
    func complete(data: Array<Byte>, success: Bool) {
        this.mutex.lock()
        this.bytes = data
        this.ok = success
        this.done = true
        this.condition.notifyAll()
        this.mutex.unlock()
    }

    // 阻塞等待请求结束（带超时），在锁内读取结果：
    // 失败/超时返回 None，与"成功但空数据"两种语义区分
    func awaitResult(timeout: Duration): (?Array<Byte>, Bool) {
        this.mutex.lock()
        this.condition.waitUntil({ => this.done }, timeout: timeout)
        let ok = this.done && this.ok
        let data: ?Array<Byte> = if (ok) {
            Some(this.bytes)
        } else {
            Option<Array<Byte>>.None
        }
        this.mutex.unlock()
        return (data, ok)
    }
}

class DownloadUtils {
    func loadData(url: String): (?Array<Byte>, Bool) {
        let box = DownloadHttpResult()
        let client = createHttp()
        let opts = HttpRequestOptions(expectDataType: HttpDataType.ARRAY_BUFFER)
        client.request(url, { err, resp =>
            if (let Some(e) <- err) {
                Hilog.error(0, "RoundedImageView", "DownloadUtils request error, url: ${url}, code: ${e.code}, message: ${e.message}")
            }
            if (let Some(r) <- resp) {
                // 2xx 均视为成功（204/206 等非严格 200 的成功响应不误判为失败）
                let code: UInt32 = r.responseCode.getValue()
                if (code >= 200 && code <= 299) {
                    match (r.result) {
                        case ARRAY_DATA(arr) =>
                            box.complete(arr, true)
                        case _ =>
                            Hilog.error(0, "RoundedImageView", "DownloadUtils unexpected data type, url: ${url}")
                            box.complete(Array<Byte>(), false)
                    }
                } else {
                    Hilog.error(0, "RoundedImageView", "DownloadUtils unexpected status: ${r.responseCode.getValue()}, url: ${url}")
                    box.complete(Array<Byte>(), false)
                }
            } else if (err.isNone()) {
                Hilog.error(0, "RoundedImageView", "DownloadUtils empty response, url: ${url}")
                box.complete(Array<Byte>(), false)
            } else {
                // 错误原因已由 err 分支记录
                box.complete(Array<Byte>(), false)
            }
        }, options: opts)
        // 单请求最长等待 30s，对齐旧版轮询上限（10ms × 3000 次），避免弱网大图被提前判失败
        let result: (?Array<Byte>, Bool) = box.awaitResult(Duration.second * 30)
        client.destroy()
        return result
    }
}
