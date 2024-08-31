/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

class DownloadUtils {
    func loadData(url: String): (?Array<Byte>, Bool) {
        var arrayBuffer: ?Array<Byte> = Option<Array<Byte>>.None
        var error: Bool = true
        try {
            var tls: TlsClientConfig = TlsClientConfig()
            tls.verifyMode = CertificateVerifyMode.TrustAll
            let client: Client = ClientBuilder()
                                    .readTimeout(Duration.millisecond * 10000)
                                    .writeTimeout(Duration.millisecond * 10000)
                                    .poolSize(2000)
                                    .tlsConfig(tls)
                                    .build()
            let resp: HttpResponse = client.get(url)
            var inputStream: InputStream = resp.body
            let bodySize: Int64 = if (let Some(v) <- resp.bodySize) {
                if (v > 0) {
                    v
                } else {
                    2048
                }
            } else {
                2048
            }
            var arrDataTemp: Array<UInt8> = Array<UInt8>(bodySize, item: 0)
            let listbuf: ArrayList<UInt8> = ArrayList<UInt8>()
            var read: Int64 = 0
            do {
                read = inputStream.read(arrDataTemp)
                listbuf.appendAll(arrDataTemp[0..read])
            } while (read > 0)
            arrayBuffer = listbuf.toArray()
        } catch (_) {
            error = false
        }
        return (arrayBuffer, error)
    }
}
