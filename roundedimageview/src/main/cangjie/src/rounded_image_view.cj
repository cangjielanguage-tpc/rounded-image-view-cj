/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

import ohos.state_macro_manage.*

@Component
public class RoundedImageView {
    @State
    var model: RoundedImageNameModel = RoundedImageNameModel()
    var settings: RenderingContextSettings = RenderingContextSettings(antialias: true)
    var context: CanvasRenderingContext2D = CanvasRenderingContext2D(settings)
    var bottomLayerContext: CanvasRenderingContext2D = CanvasRenderingContext2D(settings)
    var img: ?PixelMap = None
    var srcWidth: Float64 = 0.0
    var srcHeight: Float64 = 0.0
    var minScale: Float64 = 1.0
    var scaleW: Float64 = 0.0
    var scaleH: Float64 = 0.0
    let mathPI: Float64 = 3.14

    func setImageCanvasTransform() {
        match (model.scaleType) {
            case None => ()
            case Some(ScaleType.FIT_START) | Some(ScaleType.FIT_END) | Some(ScaleType.FIT_CENTER) =>
                minScale = if (scaleW >= scaleH) {
                    scaleH
                } else {
                    scaleW
                }
                context.setTransform(minScale, 0.0, 0.0, minScale, 0.0, 0.0)
            case Some(ScaleType.CENTER) => ()
            case Some(ScaleType.CENTER_CROP) =>
                minScale = if (scaleW >= scaleH) {
                    scaleW
                } else {
                    scaleH
                }
                context.setTransform(minScale, 0.0, 0.0, minScale, 0.0, 0.0)
            case Some(ScaleType.FIT_XY) => context.setTransform(scaleW, 0.0, 0.0, scaleH, 0.0, 0.0)
            case Some(ScaleType.CENTER_INSIDE) =>
                if (scaleW < 1.0 || scaleH < 1.0) {
                    minScale = if (scaleW >= scaleH) {
                        scaleH
                    } else {
                        scaleW
                    }
                }
                context.setTransform(minScale, 0.0, 0.0, minScale, 0.0, 0.0)
        }
    }

    func setImage() {
        if (let Some(v) <- img) {
            match (model.scaleType) {
                case None => ()
                case Some(ScaleType.FIT_START) => context.drawImage(v, 0.0, 0.0, srcWidth, srcHeight)
                case Some(ScaleType.FIT_END) =>
                    context.drawImage(v,
                        (model.uiWidth - model.padding * 2.0 - srcWidth * minScale) / (minScale * 1.0),
                        (model.uiHeight - model.padding * 2.0 - srcHeight * minScale) / (minScale * 1.0),
                        srcWidth,
                        srcHeight)
                case Some(ScaleType.FIT_CENTER) =>
                    context.drawImage(v,
                        (model.uiWidth - model.padding * 2.0 - srcWidth * minScale) / (minScale * 2.0),
                        (model.uiHeight - model.padding * 2.0 - srcHeight * minScale) / (minScale * 2.0),
                        srcWidth,
                        srcHeight)
                case Some(ScaleType.CENTER) =>
                    context.drawImage(v,
                        (model.uiWidth - model.padding * 2.0 - srcWidth) / 2.0,
                        (model.uiHeight - model.padding * 2.0 - srcHeight) / 2.0,
                        srcWidth,
                        srcHeight)
                case Some(ScaleType.CENTER_CROP) =>
                    context.drawImage(v,
                        (model.uiWidth - model.padding * 2.0 - srcWidth * minScale) / (minScale * 2.0),
                        (model.uiHeight - model.padding * 2.0 - srcHeight * minScale) / (minScale * 2.0),
                        srcWidth,
                        srcHeight)
                case Some(ScaleType.FIT_XY) =>
                    if (model.tileMode == TileMode.REPEAT || model.tileMode == TileMode.MIRROR) {
                        context.restore()
                        setTileMode()
                    } else {
                        context.drawImage(v, 0.0, 0.0, srcWidth, srcHeight)
                    }
                case Some(ScaleType.CENTER_INSIDE) =>
                    context.drawImage(v,
                        (model.uiWidth - model.padding * 2.0 - srcWidth * minScale) / (minScale * 2.0),
                        (model.uiHeight - model.padding * 2.0 - srcHeight * minScale) / (minScale * 2.0),
                        srcWidth,
                        srcHeight)
            }
        }
    }

    func setRect() {
        match (model.scaleType) {
            case None => ()
            case Some(ScaleType.FIT_START) =>
                roundRect(context,
                    model.borderWidth / 2.0,
                    model.borderWidth / 2.0,
                    srcWidth * minScale - model.borderWidth,
                    srcHeight * minScale - model.borderWidth,
                    model.cornerRadius)
            case Some(ScaleType.FIT_END) =>
                roundRect(context,
                    model.uiWidth - model.padding * 2.0 - srcWidth * minScale + model.borderWidth / 2.0,
                    model.uiHeight - model.padding * 2.0 - srcHeight * minScale + model.borderWidth / 2.0,
                    srcWidth * minScale - model.borderWidth,
                    srcHeight * minScale - model.borderWidth,
                    model.cornerRadius)
            case Some(ScaleType.FIT_CENTER) =>
                roundRect(context,
                    (model.uiWidth - model.padding * 2.0 - srcWidth * minScale) / 2.0 + model.borderWidth / 2.0,
                    (model.uiHeight - model.padding * 2.0 - srcHeight * minScale) / 2.0 + model.borderWidth / 2.0,
                    srcWidth * minScale - model.borderWidth,
                    srcHeight * minScale - model.borderWidth,
                    model.cornerRadius)
            case Some(ScaleType.CENTER) =>
                let x: Float64 = if (model.uiWidth - model.padding * 2.0 - srcWidth >= 0.0) {
                    model.uiWidth - model.padding * 2.0 - srcWidth
                } else {
                    0.0
                }
                let y: Float64 = if (model.uiHeight - model.padding * 2.0 - srcHeight >= 0.0) {
                    model.uiHeight - model.padding * 2.0 - srcHeight
                } else {
                    0.0
                }
                let w: Float64 = if (model.uiWidth - model.padding * 2.0 - srcWidth >= 0.0) {
                    srcWidth - model.padding * 2.0
                } else {
                    model.uiWidth - model.padding * 2.0
                }
                let h: Float64 = if (model.uiHeight - model.padding * 2.0 - srcHeight >= 0.0) {
                    srcHeight - model.padding * 2.0
                } else {
                    model.uiHeight - model.padding * 2.0
                }
                roundRect(context,
                    x / 2.0 + model.borderWidth / 2.0,
                    y / 2.0 + model.borderWidth / 2.0,
                    w - model.borderWidth,
                    h - model.borderWidth,
                    model.cornerRadius)
            case Some(ScaleType.CENTER_CROP) =>
                roundRect(context,
                    model.borderWidth / 2.0,
                    model.borderWidth / 2.0,
                    model.uiWidth - model.padding * 2.0 - model.borderWidth,
                    model.uiHeight - model.padding * 2.0 - model.borderWidth,
                    model.cornerRadius)
            case Some(ScaleType.FIT_XY) =>
                roundRect(context,
                    model.borderWidth / 2.0,
                    model.borderWidth / 2.0,
                    srcWidth * scaleW - model.borderWidth,
                    srcHeight * scaleH - model.borderWidth,
                    model.cornerRadius)
            case Some(ScaleType.CENTER_INSIDE) =>
                roundRect(context,
                    (model.uiWidth - model.padding * 2.0 - srcWidth * minScale) / 2.0 + model.borderWidth / 2.0,
                    (model.uiHeight - model.padding * 2.0 - srcHeight * minScale) / 2.0 + model.borderWidth / 2.0,
                    srcWidth * minScale - model.borderWidth,
                    srcHeight * minScale - model.borderWidth,
                    model.cornerRadius)
        }
    }

    func roundRect(context: CanvasRenderingContext2D, x: Float64, y: Float64, w: Float64, h: Float64, r: Float64) {
        var r1 = r
        if (w < 2.0 * r1) {
            r1 = w / 2.0
        }
        if (h < 2.0 * r1) {
            r1 = h / 2.0
        }
        context.beginPath()
        context.moveTo(x + r1, y)
        context.arcTo(x + w, y, x + w, y + h, r1)
        context.arcTo(x + w, y + h, x, y + h, r1)
        context.arcTo(x, y + h, x, y, r1)
        context.arcTo(x, y, x + w, y, r1)
        context.closePath()
    }

    func setOval() {
        match (model.scaleType) {
            case None => ()
            case Some(ScaleType.FIT_START) =>
                context.ellipse(srcWidth * minScale / 2.0,
                    srcHeight * minScale / 2.0,
                    (srcWidth * minScale - model.borderWidth) / 2.0,
                    (srcHeight * minScale - model.borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0)
            case Some(ScaleType.FIT_END) =>
                context.ellipse(model.uiWidth - srcWidth * minScale + srcWidth * minScale / 2.0,
                    srcHeight * minScale / 2.0,
                    (srcWidth * minScale - model.borderWidth) / 2.0,
                    (srcHeight * minScale - model.borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0)
            case Some(ScaleType.FIT_CENTER) =>
                context.ellipse(model.uiWidth / 2.0,
                    srcHeight * minScale / 2.0,
                    (srcWidth * minScale - model.borderWidth) / 2.0,
                    (srcHeight * minScale - model.borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0)
            case Some(ScaleType.CENTER) =>
                let x: Float64 = if (model.uiWidth - srcWidth >= 0.0) {
                    model.uiWidth - srcWidth
                } else {
                    0.0
                }
                let y: Float64 = if (model.uiHeight - srcHeight >= 0.0) {
                    model.uiHeight - srcHeight
                } else {
                    0.0
                }
                let w: Float64 = if (model.uiWidth - srcWidth >= 0.0) {
                    srcWidth
                } else {
                    model.uiWidth
                }
                let h: Float64 = if (model.uiHeight - srcHeight >= 0.0) {
                    srcHeight
                } else {
                    model.uiHeight
                }
                context.ellipse((x + w) / 2.0,
                    (y + h) / 2.0,
                    (w - model.borderWidth) / 2.0,
                    (h - model.borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0)
            case Some(ScaleType.CENTER_CROP) =>
                context.ellipse(model.uiWidth / 2.0,
                    model.uiHeight / 2.0,
                    (model.uiWidth - model.borderWidth) / 2.0,
                    (model.uiHeight - model.borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0)
            case Some(ScaleType.FIT_XY) =>
                context.ellipse(model.uiWidth / 2.0,
                    model.uiHeight / 2.0,
                    (srcWidth * scaleW - model.borderWidth) / 2.0,
                    (srcHeight * scaleH - model.borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0)
            case Some(ScaleType.CENTER_INSIDE) =>
                context.ellipse(model.uiWidth / 2.0,
                    model.uiHeight / 2.0,
                    (srcWidth * minScale - model.borderWidth) / 2.0,
                    (srcHeight * minScale - model.borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0)
        }
    }

    func setTileMode() {
        context.save()
        let countW: Float64 = ceil(model.uiWidth / srcWidth)
        let countH: Float64 = ceil(model.uiHeight / srcHeight)
        context.translate(-(countW * srcWidth - model.uiWidth) / 2.0, -(countH * srcHeight - model.uiHeight) / 2.0)
        for (indexW in 0..Int64(countW)) {
            for (indexH in 0..Int64(countH)) {
                context.save()
                if (model.tileMode == TileMode.MIRROR) {
                    if (indexW % 2 != 0 && indexH % 2 == 0) {
                        context.translate(srcWidth + Float64(indexW) * srcWidth * 2.0, 0.0)
                        context.scale(-1.0, 1.0)
                    } else if (indexW % 2 == 0 && indexH % 2 != 0) {
                        context.translate(0.0, srcHeight + Float64(indexH) * srcHeight * 2.0)
                        context.scale(1.0, -1.0)
                    } else if (indexW % 2 != 0 && indexH % 2 != 0) {
                        context.translate(srcWidth + Float64(indexW) * srcWidth * 2.0,
                            srcHeight + Float64(indexH) * srcHeight * 2.0)
                        context.scale(-1.0, -1.0)
                    }
                }
                if (let Some(v) <- img) {
                    context.drawImage(v, Float64(indexW) * srcWidth, Float64(indexH) * srcHeight, srcWidth, srcHeight)
                    context.restore()
                }
            }
        }
        context.restore()
    }

    private func getSvgData(callback: (Array<Byte>) -> Unit, context: ?AbilityContext) {
        let contexts: AbilityContext = if (let Some(v) <- context) {
            v
        } else {
            (GlobalContext.getContext().getObject("context") as AbilityContext)()
        }
        let resourceManager = ResourceManager.getResourceManager(getStageContext(contexts))
        match (model.srcType) {
            case Some(SrcType.MEDIA) => if (model.srcResource.isSome()) {
                let mediaSrc: ResourceManagerResource = model.srcResource()
                let callbackSvg: (Bool, Array<Byte>) -> Unit = {
                    error, value => callback(value)
                }
                spawn {
                    let array: Array<UInt8> = resourceManager.getMediaContent(mediaSrc, 0)
                    callbackSvg(true, array)
                }
            }
            case Some(SrcType.RAWFILE) => if (let Some(v) <- model.src) {
                let rawfileSrc: String = v
                let callbackSvg: (Bool, Array<Byte>) -> Unit = {
                    error, value => callback(value)
                }
                spawn {
                    let array: Array<UInt8> = resourceManager.getRawFileContent(rawfileSrc)
                    callbackSvg(true, array)
                }
            }
            case _ => ()
        }
    }

    private func drawBitmap() {
        if (model.getIsSvg()) {
            // TODO
            let callbackSvg: (Array<Byte>) -> Unit = {
                svgData => ()
            }
            return
        }

        let callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit = {
            pixelMap, width, height, error => if (!error) {
                img = pixelMap
                srcWidth = Float64(width)
                srcHeight = Float64(height)
                scaleW = (model.uiWidth - model.padding * 2.0) / srcWidth
                scaleH = (model.uiHeight - model.padding * 2.0) / srcHeight
                if (let Some(v) <- model.borderColor) {
                    context.strokeStyle(v)
                } else if (let Some(v) <- model.borderColorUInt32) {
                    context.strokeStyle(v)
                } else if (let Some(v) <- model.borderColorCanvasGradient) {
                    context.strokeStyle(v)
                } else {
                }
                context.lineWidth(model.borderWidth)
                context.save()
                setImageCanvasTransform()
                setImage()
                context.restore()
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                setRect()
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                setRect()
                context.stroke()
            }
        }
        if (let Some(v) <- model.src) {
            PixelMapUtils.createPixelMap(v, model.srcType, callback, model.getContext())
        } else if (let Some(v) <- model.srcArray) {
            PixelMapUtils.createPixelMap(v, model.srcType, callback, model.getContext())
        } else if (let Some(v) <- model.srcResource) {
            PixelMapUtils.createPixelMap(v, model.srcType, callback, model.getContext())
        } else {
        }
    }

    private func drawOvals() {
        if (model.getIsSvg()) {
            // TODO
            let callbackSvg: (Array<Byte>) -> Unit = {
                svgData => ()
            }
            return
        }
        let callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit = {
            pixelMap, width, height, error => if (!error) {
                img = pixelMap
                srcWidth = Float64(width)
                srcHeight = Float64(height)
                scaleW = (model.uiWidth - model.padding * 2.0) / srcWidth
                scaleH = (model.uiHeight - model.padding * 2.0) / srcHeight
                if (let Some(v) <- model.borderColor) {
                    context.strokeStyle(v)
                } else if (let Some(v) <- model.borderColorUInt32) {
                    context.strokeStyle(v)
                } else if (let Some(v) <- model.borderColorCanvasGradient) {
                    context.strokeStyle(v)
                } else {
                }
                context.lineWidth(model.borderWidth)
                context.save()
                setImageCanvasTransform()
                setImage()
                context.restore()
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                setOval()
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                setOval()
                context.stroke()
            }
        }
        spawn {
            if (let Some(v) <- model.src) {
                PixelMapUtils.createPixelMap(v, model.srcType, callback, model.getContext())
            } else if (let Some(v) <- model.srcArray) {
                PixelMapUtils.createPixelMap(v, model.srcType, callback, model.getContext())
            } else if (let Some(v) <- model.srcResource) {
                PixelMapUtils.createPixelMap(v, model.srcType, callback, model.getContext())
            } else {
            }
        }
    }

    private func drawColors() {
        scaleW = model.uiWidth / model.colorWidth
        scaleH = model.uiHeight / model.colorHeight
        minScale = if (scaleW >= scaleH) {
            scaleH
        } else {
            scaleW
        }
        if (let Some(v) <- model.backgroundColor) {
            context.fillStyle(v)
        } else if (let Some(v) <- model.backgroundColorUInt32) {
            context.fillStyle(v)
        } else if (let Some(v) <- model.backgroundColorCanvasGradient) {
            context.fillStyle(v)
        } else {
        }
        if (let Some(v) <- model.borderColor) {
            bottomLayerContext.fillStyle(v)
        } else if (let Some(v) <- model.borderColorUInt32) {
            bottomLayerContext.fillStyle(v)
        } else if (let Some(v) <- model.borderColorCanvasGradient) {
            bottomLayerContext.fillStyle(v)
        } else {
        }
        context.lineWidth(model.borderWidth)
        match (model.scaleType) {
            case None => ()
            case Some(ScaleType.FIT_START) =>
                context.fillRect(0.0, 0.0, model.colorWidth * minScale, model.colorHeight * minScale)
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                roundRect(context,
                    model.borderWidth / 2.0,
                    model.borderWidth / 2.0,
                    model.colorWidth * minScale - model.borderWidth,
                    model.colorHeight * minScale - model.borderWidth,
                    model.cornerRadius)
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                roundRect(context,
                    model.borderWidth / 2.0,
                    model.borderWidth / 2.0,
                    model.colorWidth * minScale - model.borderWidth,
                    model.colorHeight * minScale - model.borderWidth,
                    model.cornerRadius)
                context.stroke()
            case Some(ScaleType.FIT_END) =>
                context.fillRect(model.uiWidth - model.colorWidth * minScale,
                    model.uiHeight - model.colorHeight * minScale,
                    model.colorWidth * minScale,
                    model.colorHeight * minScale)
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                roundRect(context,
                    model.uiWidth - model.colorWidth * minScale + model.borderWidth / 2.0,
                    model.uiHeight - model.colorHeight * minScale + model.borderWidth / 2.0,
                    model.colorWidth * minScale - model.borderWidth,
                    model.colorHeight * minScale - model.borderWidth,
                    model.cornerRadius)
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                roundRect(context,
                    model.uiWidth - model.colorWidth * minScale + model.borderWidth / 2.0,
                    model.uiHeight - model.colorHeight * minScale + model.borderWidth / 2.0,
                    model.colorWidth * minScale - model.borderWidth,
                    model.colorHeight * minScale - model.borderWidth,
                    model.cornerRadius)
                context.stroke()
            case Some(ScaleType.FIT_CENTER) =>
                context.fillRect((model.uiWidth - model.colorWidth * minScale) / 2.0,
                    (model.uiHeight - model.colorHeight * minScale) / 2.0,
                    model.colorWidth * minScale,
                    model.colorHeight * minScale)
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                roundRect(context,
                    (model.uiWidth - model.colorWidth * minScale) / 2.0 + model.borderWidth / 2.0,
                    (model.uiHeight - model.colorHeight * minScale) / 2.0 + model.borderWidth / 2.0,
                    model.colorWidth * minScale - model.borderWidth,
                    model.colorHeight * minScale - model.borderWidth,
                    model.cornerRadius)
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                roundRect(context,
                    (model.uiWidth - model.colorWidth * minScale) / 2.0 + model.borderWidth / 2.0,
                    (model.uiHeight - model.colorHeight * minScale) / 2.0 + model.borderWidth / 2.0,
                    model.colorWidth * minScale - model.borderWidth,
                    model.colorHeight * minScale - model.borderWidth,
                    model.cornerRadius)
                context.stroke()
            case _ =>
                context.fillRect(0.0, 0.0, model.uiWidth, model.uiHeight)
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                roundRect(context,
                    model.borderWidth / 2.0,
                    model.borderWidth / 2.0,
                    model.uiWidth - model.borderWidth,
                    model.uiHeight - model.borderWidth,
                    model.cornerRadius)
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                roundRect(context,
                    model.borderWidth / 2.0,
                    model.borderWidth / 2.0,
                    model.uiWidth - model.borderWidth,
                    model.uiHeight - model.borderWidth,
                    model.cornerRadius)
                context.stroke()
        }
        context.stroke()
    }

    private func drawBackground() {
        if (let Some(v) <- model.backgroundColor) {
            bottomLayerContext.fillStyle(v)
        } else if (let Some(v) <- model.backgroundColorUInt32) {
            bottomLayerContext.fillStyle(v)
        } else if (let Some(v) <- model.backgroundColorCanvasGradient) {
            bottomLayerContext.fillStyle(v)
        } else {
        }
        if (let Some(v) <- model.borderColor) {
            bottomLayerContext.strokeStyle(v)
        } else if (let Some(v) <- model.borderColorUInt32) {
            bottomLayerContext.strokeStyle(v)
        } else if (let Some(v) <- model.borderColorCanvasGradient) {
            bottomLayerContext.strokeStyle(v)
        } else {
        }
        bottomLayerContext.lineWidth(model.borderWidth)
        bottomLayerContext.fillRect(0.0, 0.0, model.uiWidth, model.uiHeight)
        bottomLayerContext.globalCompositeOperation(CompositeOperation.DestinationIn)
        roundRect(bottomLayerContext,
            model.borderWidth / 2.0,
            model.borderWidth / 2.0,
            model.uiWidth - model.borderWidth,
            model.uiHeight - model.borderWidth,
            model.cornerRadius)
        bottomLayerContext.fill()
        bottomLayerContext.globalCompositeOperation(CompositeOperation.SourceOver)
        roundRect(bottomLayerContext,
            model.borderWidth / 2.0,
            model.borderWidth / 2.0,
            model.uiWidth - model.borderWidth,
            model.uiHeight - model.borderWidth,
            model.cornerRadius)
        bottomLayerContext.stroke()
    }

    func build() {
        Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
            if (model.typeValue == 'Bitmap') {
                Canvas(context)
                    .width(model.uiWidth)
                    .height(model.uiHeight)
                    .onReady({
                        => drawBitmap()
                    })
            } else if (model.typeValue == 'Ovals') {
                Canvas(context)
                    .width(model.uiWidth)
                    .height(model.uiHeight)
                    .onReady({
                        => drawOvals()
                    })
            } else if (model.typeValue == 'Color') {
                Canvas(context)
                    .width(model.uiWidth)
                    .height(model.uiHeight)
                    .onReady({
                        => drawColors()
                    })
            } else if (model.typeValue == 'Background') {
                Stack() {
                    Canvas(bottomLayerContext)
                        .onReady({
                            => drawBackground()
                        })
                    Stack() {
                        Canvas(context)
                            .onReady({
                                => drawBitmap()
                            })
                    }
                    .padding(model.padding)
                }
                .width(model.uiWidth)
                .height(model.uiHeight)
            } else if (model.typeValue == 'SVG') {
                Canvas(context)
                    .width(model.uiWidth)
                    .height(model.uiHeight)
                    .onReady(
                        {
                            =>
                            let that = this
                            sleep(100 * Duration.millisecond)
                            that.drawBitmap()
                        }
                    )
            }
        }
    }
}

public class RoundedImageNameModel {
    var src: ?String = None
    var srcArray: ?Array<Byte> = None
    var srcResource: ?ResourceManagerResource = None
    var srcType: ?SrcType = None
    var isSvg: Bool = false
    var typeValue: String = ""
    var uiWidth: Float64 = 0.0
    var uiHeight: Float64 = 0.0
    var backgroundColor: ?Color = None
    var backgroundColorUInt32: ?UInt32 = None
    var backgroundColorCanvasGradient: ?CanvasGradient = None
    var tileMode: ?TileMode = None
    var scaleType: ?ScaleType = None
    var cornerRadius: Float64 = 0.0
    var borderWidth: Float64 = 0.0
    var borderColor: ?Color = None
    var borderColorUInt32: ?UInt32 = None
    var borderColorCanvasGradient: ?CanvasGradient = None
    var padding: Float64 = 0.0
    var colorWidth: Float64 = 0.0
    var colorHeight: Float64 = 0.0
    var context: ?AbilityContext = None

    public init() {
    }

    public func setContext(context: AbilityContext): RoundedImageNameModel {
        this.context = context
        return this
    }

    public func getContext(): ?AbilityContext {
        return this.context
    }

    public func setImageSrc(src: String): RoundedImageNameModel {
        this.src = src
        return this
    }

    public func setImageSrc(srcArray: Array<Byte>): RoundedImageNameModel {
        this.srcArray = srcArray
        return this
    }

    public func setImageSrc(srcResource: ResourceManagerResource): RoundedImageNameModel {
        this.srcResource = srcResource
        return this
    }

    public func getImageSrc(): ?String {
        return this.src
    }

    public func getImageSrcArray(): ?Array<Byte> {
        return this.srcArray
    }

    public func getImageSrcResource(): ?ResourceManagerResource {
        return this.srcResource
    }

    public func setSrcType(srcType: ?SrcType): RoundedImageNameModel {
        this.srcType = srcType
        return this
    }

    public func getSrcType(): ?SrcType {
        return this.srcType
    }

    public func setIsSvg(isSvg: Bool): RoundedImageNameModel {
        this.isSvg = isSvg
        return this
    }

    public func getIsSvg(): Bool {
        return this.isSvg
    }

    public func setTypeValue(typeValue: String): RoundedImageNameModel {
        this.typeValue = typeValue
        return this
    }

    public func getTypeValue(): String {
        return this.typeValue
    }

    public func setUiWidth(uiWidth: Float64): RoundedImageNameModel {
        this.uiWidth = uiWidth
        return this
    }

    public func getUiWidth(): Float64 {
        return this.uiWidth
    }

    public func setUiHeight(uiHeight: Float64): RoundedImageNameModel {
        this.uiHeight = uiHeight
        return this
    }

    public func getUiHeight(): Float64 {
        return this.uiHeight
    }

    public func setScaleType(scaleType: ?ScaleType): RoundedImageNameModel {
        this.scaleType = scaleType
        return this
    }

    public func getScaleType(): ?ScaleType {
        return this.scaleType
    }

    public func setTileModeXY(tileMode: ?TileMode): RoundedImageNameModel {
        this.tileMode = tileMode
        return this
    }

    public func getTileModeXY(): ?TileMode {
        return this.tileMode
    }

    public func setBackgroundColor(backgroundColor: Color): RoundedImageNameModel {
        this.backgroundColor = backgroundColor
        return this
    }

    public func setBackgroundColor(backgroundColorUInt32: UInt32): RoundedImageNameModel {
        this.backgroundColorUInt32 = backgroundColorUInt32
        return this
    }

    public func setBackgroundColor(backgroundColorCanvasGradient: CanvasGradient): RoundedImageNameModel {
        this.backgroundColorCanvasGradient = backgroundColorCanvasGradient
        return this
    }

    public func getBackgroundColor(): ?Color {
        return this.backgroundColor
    }

    public func getBackgroundColorCanvasRendering(): ?UInt32 {
        return this.backgroundColorUInt32
    }

    public func getBackgroundColorCanvasGradient(): ?CanvasGradient {
        return this.backgroundColorCanvasGradient
    }

    public func setCornerRadius(cornerRadius: Float64): RoundedImageNameModel {
        this.cornerRadius = cornerRadius
        return this
    }

    public func getCornerRadius(): Float64 {
        return this.cornerRadius
    }

    public func setBorderWidth(borderWidth: Float64): RoundedImageNameModel {
        this.borderWidth = borderWidth
        return this
    }

    public func getBorderWidth(): Float64 {
        return this.borderWidth
    }

    public func setBorderColor(borderColor: Color): RoundedImageNameModel {
        this.borderColor = borderColor
        return this
    }

    public func setBorderColor(borderColorUInt32: UInt32): RoundedImageNameModel {
        this.borderColorUInt32 = borderColorUInt32
        return this
    }

    public func setBorderColor(borderColorCanvasGradient: CanvasGradient): RoundedImageNameModel {
        this.borderColorCanvasGradient = borderColorCanvasGradient
        return this
    }

    public func getBorderColor(): ?Color {
        return this.borderColor
    }

    public func getBorderColorCanvasRendering(): ?UInt32 {
        return this.borderColorUInt32
    }

    public func getBorderColorCanvasGradient(): ?CanvasGradient {
        return this.borderColorCanvasGradient
    }

    public func setPadding(padding: Float64): RoundedImageNameModel {
        this.padding = padding
        return this
    }

    public func getPadding(): Float64 {
        return this.padding
    }

    public func setColorWidth(colorWidth: Float64): RoundedImageNameModel {
        this.colorWidth = colorWidth
        return this
    }

    public func getColorWidth(): Float64 {
        return this.colorWidth
    }

    public func setColorHeight(colorHeight: Float64): RoundedImageNameModel {
        this.colorHeight = colorHeight
        return this
    }

    public func getColorHeight(): Float64 {
        return this.colorHeight
    }
}
