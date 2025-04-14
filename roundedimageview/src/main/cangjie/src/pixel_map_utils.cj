/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package roundedimageview

class PixelMapUtils {
    static func createPixelMap(src: ?String, srcResource: ?CJResource, srcArray: ?Array<Byte>, srcType: ?SrcType, isSvg: Bool, callback: (?PixelMap, Int64, Int64, Bool) -> Unit, context: ?AbilityContext): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var strUri: ?String = Option<String>.None
            var dataArray: ?Array<Byte> = Option<Array<Byte>>.None
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var width: Int64 = 0
            var height: Int64 = 0
            var error: Bool = false
            try (imageLoadLimiter = ImageLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let resourceManager = getResourceManager(context)
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                match (srcType) {
                    case Some(SrcType.MEDIA) =>
                        if (let Some(v) <- src) {
                            dataArray = resourceManager.getMediaByName(v, 0)
                        } else if (let Some(v) <- srcResource) {
                            dataArray = resourceManager.getMediaContent(Int32(v.id), 0)
                        }
                    case Some(SrcType.RAWFILE) =>
                        if (let Some(v) <- src) {
                            dataArray = resourceManager.getRawFileContent(v)
                        }
                    case Some(SrcType.URI) =>
                        if (let Some(v) <- src) {
                            strUri = v
                        }
                    case Some(SrcType.URL) =>
                        if (let Some(v) <- src) {
                            let data: (?Array<Byte>, Bool) = DownloadUtils().loadData(v)
                            if (data[1]) {
                                dataArray = data[0]
                            }
                        }
                    case Some(SrcType.ARRAYBUFFER) =>
                        if (let Some(v) <- srcArray) {
                            dataArray = v
                        }
                    case _ => ()
                }
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                if (isSvg) {
                    // TODO SVG图片
                    if (let Some(v) <- dataArray) {

                    }
                } else {
                    let imageSource: ImageSource = if (let Some(v) <- strUri) {
                        createImageSource(v)
                    } else if (let Some(v) <- dataArray) {
                        createImageSource(v)
                    } else {
                        throw Exception("ImageSource faild !!!")
                    }
                    let imageInfo: ImageInfo = imageSource.getImageInfo()
                    width = Int64(imageInfo.size.width)
                    height = Int64(imageInfo.size.height)
                    if (Thread.currentThread.hasPendingCancellation) {
                        imageSource.Release()
                        return
                    }
                    pixelMap = imageSource.createPixelMap()
                    imageSource.Release()
                    error = true
                }
            } catch (e: Exception) {
                error = false
                AppLog.error("PixelMapUtils imageSource.getImageInfo error: ${e}")
            } finally {
                try {
                    if (Thread.currentThread.hasPendingCancellation) {
                        pixelMap?.Release()
                        return
                    }
                    callback(pixelMap, width, height, error)
                } catch (_) {
                    AppLog.error("PixelMapUtils imageSource.getImageInfo error")
                }
            }
        }
        return fut
    }

    private static func getResourceManager(context: ?AbilityContext): ResourceManager {
        let contexts: AbilityContext = if (let Some(v) <- context) {
            v
        } else {
            GlobalContext.getContext().getAbilityContext()()
        }
        let resourceManager: ResourceManager = ResourceManager.getResourceManager(getStageContext(contexts))
        return resourceManager
    }
}

class ImageLoadLimiter <: Resource {
    static let semaphore: Semaphore = Semaphore(50)
    let closed = AtomicBool(false)

    init() {
        semaphore.acquire()
    }

    public override func isClosed(): Bool {
        return closed.load()
    }

    public override func close(): Unit {
        if (isClosed()) {
            return
        }
        semaphore.release()
        closed.store(true)
    }
}
