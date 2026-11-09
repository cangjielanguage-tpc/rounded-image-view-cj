package roundedimageview

class PixelMapUtils {
    static func createPixelMap(src: ?String, srcResource: ?AppResource, srcArray: ?Array<Byte>, srcType: ?SrcType, callback: (?PixelMap, Int64, Int64, Bool) -> Unit, context: ?UIAbilityContext): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var strUri: ?String = Option<String>.None
            var dataArray: ?Array<Byte> = Option<Array<Byte>>.None
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var width: Int64 = 0
            var height: Int64 = 0
            // 与回调契约一致：true 表示加载成功
            var ok: Bool = false
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
                let imageSource: ImageSource = if (let Some(v) <- strUri) {
                    createImageSource(v)
                } else if (let Some(v) <- dataArray) {
                    createImageSource(v)
                } else {
                    throw Exception("ImageSource failed !!!")
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
                ok = true
            } catch (e: Exception) {
                ok = false
                Hilog.error(0, "RoundedImageView", "PixelMapUtils createPixelMap error: ${e}")
            } finally {
                try {
                    if (Thread.currentThread.hasPendingCancellation) {
                        pixelMap?.Release()
                        return
                    }
                    callback(pixelMap, width, height, ok)
                } catch (e: Exception) {
                    Hilog.error(0, "RoundedImageView", "PixelMapUtils callback error: ${e}")
                }
            }
        }
        return fut
    }

    // 加载SVG源数据字节（MEDIA/RAWFILE/URI/URL/ARRAYBUFFER），经callback返回；ok表示加载成功。
    // 仅负责取字节，SVG解析与离屏渲染需在UI线程进行（px2vp/离屏画布依赖UI上下文）
    static func loadSvgBytes(src: ?String, srcResource: ?AppResource, srcArray: ?Array<Byte>, srcType: ?SrcType, callback: (Array<Byte>, Bool) -> Unit, context: ?UIAbilityContext): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var dataArray: ?Array<Byte> = Option<Array<Byte>>.None
            try (imageLoadLimiter = ImageLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let resourceManager = getResourceManager(context)
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
                            dataArray = FileUtils.getInstance().readFilePic(v)
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
                if (let Some(v) <- dataArray) {
                    callback(v, v.size > 0)
                } else {
                    callback(Array<Byte>(0, repeat: 0), false)
                }
            } catch (e: Exception) {
                Hilog.error(0, "RoundedImageView", "PixelMapUtils loadSvgBytes error: ${e}")
                callback(Array<Byte>(0, repeat: 0), false)
            }
        }
        return fut
    }

    private static func getResourceManager(context: ?UIAbilityContext): ResourceManager {
        let contexts: UIAbilityContext = if (let Some(v) <- context) {
            v
        } else {
            GlobalContext.getContext().getUIAbilityContext()()
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
