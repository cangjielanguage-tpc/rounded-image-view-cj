/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

class PixelMapUtils {
    public static func createPixelMap(src: String, srcType: ?SrcType, callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit, context: ?AbilityContext): Unit {
        let contexts: AbilityContext = if (let Some(v) <- context) {
            v
        } else {
            GlobalContext.getContext().getObject("context")()
        }
        let resourceManager = ResourceManager.getResourceManager(getStageContext(contexts))
        match (srcType) {
            case Some(SrcType.MEDIA) =>
                let arrayUInt8: Array<UInt8> = resourceManager.getMediaByName(src, 0)
                callbackPixelMap(arrayUInt8, callback)
            case Some(SrcType.RAWFILE) =>
                let arrayUInt8: Array<UInt8> = resourceManager.getRawFileContent(src)
                callbackPixelMap(arrayUInt8, callback)
            case Some(SrcType.URI) => callbackPixelMap(src, callback)
            case Some(SrcType.URL) =>
                let downloadUtilsCallback: (arrayBuffer: ?Array<Byte>, error: Bool) -> Unit = {
                    arrayBuffer, error => if (error) {
                        callbackPixelMap(arrayBuffer(), callback)
                    }
                }
                DownloadUtils().loadData(src, downloadUtilsCallback)
            case _ => ()
        }
    }

    public static func createPixelMap(src: CJResource, srcType: ?SrcType, callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit, context: ?AbilityContext): Unit {
        let contexts: AbilityContext = if (let Some(v) <- context) {
            v
        } else {
            GlobalContext.getContext().getObject("context")()
        }
        let resourceManager = ResourceManager.getResourceManager(getStageContext(contexts))
        match (srcType) {
            case Some(SrcType.MEDIA) =>
                let arrayUInt8: Array<UInt8> = resourceManager.getMediaContent(UInt32(src.id), 0)
                callbackPixelMap(arrayUInt8, callback)
            case _ => ()
        }
    }

    public static func createPixelMap(src: Array<Byte>, srcType: ?SrcType, callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit, context: ?AbilityContext): Unit {
        let contexts: AbilityContext = if (let Some(v) <- context) {
            v
        } else {
            GlobalContext.getContext().getObject("context")()
        }
        let resourceManager = ResourceManager.getResourceManager(getStageContext(contexts))
        match (srcType) {
            case Some(SrcType.ARRAYBUFFER) => callbackPixelMap(src, callback)
            case _ => ()
        }
    }

    private static func callbackPixelMap(src: String, callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit): Unit {
        try {
            let imageSource: ImageSource = createImageSource(src)
            let imageInfo: ImageInfo = imageSource.getImageInfo()
            let width = imageInfo.size.width
            let height = imageInfo.size.height
            let pixelMap: PixelMap = imageSource.createPixelMap()
            imageSource.Release()
            callback(pixelMap, Int64(width), Int64(height), true)
        } catch (e: Exception) {
            AppLog.error("PixelMapUtils imageSource.getImageInfo error: ${e}")
            callback(Option<PixelMap>.None, 0, 0, false)
        }
    }

    private static func callbackPixelMap(src: Array<Byte>, callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit): Unit {
        try {
            let imageSource: ImageSource = createImageSource(src)
            let imageInfo: ImageInfo = imageSource.getImageInfo()
            let width = imageInfo.size.width
            let height = imageInfo.size.height
            let pixelMap: PixelMap = imageSource.createPixelMap()
            imageSource.Release()
            callback(pixelMap, Int64(width), Int64(height), true)
        } catch (e: Exception) {
            AppLog.error("PixelMapUtils imageSource.getImageInfo error: ${e}")
            callback(Option<PixelMap>.None, 0, 0, false)
        }
    }
}
