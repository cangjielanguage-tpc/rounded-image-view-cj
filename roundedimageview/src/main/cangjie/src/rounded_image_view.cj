/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package roundedimageview

import ohos.state_macro_manage.*

/**
 * RoundedImageView预览自定义控件
 */
@Component
public class RoundedImageView {
    @State
    var model: RoundedImageNameModel = RoundedImageNameModel()

    var settings: RenderingContextSettings = RenderingContextSettings(antialias: true)

    @State
    var context: CanvasRenderingContext2D = CanvasRenderingContext2D(settings)

    @State
    var bottomLayerContext: CanvasRenderingContext2D = CanvasRenderingContext2D(settings)

    @State
    var img: ?PixelMap = Option<PixelMap>.None

    @State
    var srcWidth: Float64 = 0.0

    @State
    var srcHeight: Float64 = 0.0

    @State
    var minScale: Float64 = 1.0

    @State
    var scaleW: Float64 = 0.0

    @State
    var scaleH: Float64 = 0.0

    let mathPI: Float64 = Float64.PI

    /**
     * 线程
     */
    @State
    var fut: ?Future<Unit> = Option<Future<Unit>>.None

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
            let padding = if(model.padding > 0.0){
                model.padding
            } else {
                0.0
            }
            match (model.scaleType) {
                case None => ()
                case Some(ScaleType.FIT_START) => context.drawImage(v, 0.0, 0.0, srcWidth, srcHeight)
                case Some(ScaleType.FIT_END) =>
                    context.drawImage(
                        v,
                        (model.uiWidth - padding * 2.0 - srcWidth * minScale) / (minScale * 1.0),
                        (model.uiHeight - padding * 2.0 - srcHeight * minScale) / (minScale * 1.0),
                        srcWidth,
                        srcHeight
                    )
                case Some(ScaleType.FIT_CENTER) =>
                    context.drawImage(
                        v,
                        (model.uiWidth - padding * 2.0 - srcWidth * minScale) / (minScale * 2.0),
                        (model.uiHeight - padding * 2.0 - srcHeight * minScale) / (minScale * 2.0),
                        srcWidth,
                        srcHeight
                    )
                case Some(ScaleType.CENTER) =>
                    context.drawImage(
                        v,
                        (model.uiWidth - padding * 2.0 - srcWidth) / 2.0,
                        (model.uiHeight - padding * 2.0 - srcHeight) / 2.0,
                        srcWidth,
                        srcHeight
                    )
                case Some(ScaleType.CENTER_CROP) =>
                    context.drawImage(
                        v,
                        (model.uiWidth - padding * 2.0 - srcWidth * minScale) / (minScale * 2.0),
                        (model.uiHeight - padding * 2.0 - srcHeight * minScale) / (minScale * 2.0),
                        srcWidth,
                        srcHeight
                    )
                case Some(ScaleType.FIT_XY) =>
                    if (model.tileMode == TileMode.REPEAT || model.tileMode == TileMode.MIRROR) {
                        context.restore()
                        setTileMode()
                    } else {
                        context.drawImage(v, 0.0, 0.0, srcWidth, srcHeight)
                    }
                case Some(ScaleType.CENTER_INSIDE) =>
                    context.drawImage(
                        v,
                        (model.uiWidth - padding * 2.0 - srcWidth * minScale) / (minScale * 2.0),
                        (model.uiHeight - padding * 2.0 - srcHeight * minScale) / (minScale * 2.0),
                        srcWidth,
                        srcHeight
                    )
            }
        }
    }

    func setRect() {
        let borderWidth = if(model.borderWidth > 0.0){
            model.borderWidth
        } else {
            0.0
        }
        let cornerRadius = if(model.cornerRadius > 0.0){
            model.cornerRadius
        } else {
            0.0
        }
        let padding = if(model.padding > 0.0){
            model.padding
        } else {
            0.0
        }
        match (model.scaleType) {
            case None => ()
            case Some(ScaleType.FIT_START) =>
                roundRect(
                    context,
                    borderWidth / 2.0,
                    borderWidth / 2.0,
                    srcWidth * minScale - borderWidth,
                    srcHeight * minScale - borderWidth,
                    cornerRadius
                )
            case Some(ScaleType.FIT_END) =>
                roundRect(
                    context,
                    model.uiWidth - padding * 2.0 - srcWidth * minScale + borderWidth / 2.0,
                    model.uiHeight - padding * 2.0 - srcHeight * minScale + borderWidth / 2.0,
                    srcWidth * minScale - borderWidth,
                    srcHeight * minScale - borderWidth,
                    cornerRadius
                )
            case Some(ScaleType.FIT_CENTER) =>
                roundRect(
                    context,
                    (model.uiWidth - padding * 2.0 - srcWidth * minScale) / 2.0 + borderWidth / 2.0,
                    (model.uiHeight - padding * 2.0 - srcHeight * minScale) / 2.0 + borderWidth / 2.0,
                    srcWidth * minScale - borderWidth,
                    srcHeight * minScale - borderWidth,
                    cornerRadius
                )
            case Some(ScaleType.CENTER) =>
                let x: Float64 = if (model.uiWidth - padding * 2.0 - srcWidth >= 0.0) {
                    model.uiWidth - padding * 2.0 - srcWidth
                } else {
                    0.0
                }
                let y: Float64 = if (model.uiHeight - padding * 2.0 - srcHeight >= 0.0) {
                    model.uiHeight - padding * 2.0 - srcHeight
                } else {
                    0.0
                }
                let w: Float64 = if (model.uiWidth - padding * 2.0 - srcWidth >= 0.0) {
                    srcWidth - padding * 2.0
                } else {
                    model.uiWidth - padding * 2.0
                }
                let h: Float64 = if (model.uiHeight - padding * 2.0 - srcHeight >= 0.0) {
                    srcHeight - padding * 2.0
                } else {
                    model.uiHeight - padding * 2.0
                }
                roundRect(
                    context,
                    x / 2.0 + borderWidth / 2.0,
                    y / 2.0 + borderWidth / 2.0,
                    w - borderWidth,
                    h - borderWidth,
                    cornerRadius
                )
            case Some(ScaleType.CENTER_CROP) =>
                roundRect(
                    context,
                    borderWidth / 2.0,
                    borderWidth / 2.0,
                    model.uiWidth - padding * 2.0 - borderWidth,
                    model.uiHeight - padding * 2.0 - borderWidth,
                    cornerRadius
                )
            case Some(ScaleType.FIT_XY) =>
                roundRect(
                    context,
                    borderWidth / 2.0,
                    borderWidth / 2.0,
                    srcWidth * scaleW - borderWidth,
                    srcHeight * scaleH - borderWidth,
                    cornerRadius
                )
            case Some(ScaleType.CENTER_INSIDE) =>
                roundRect(
                    context,
                    (model.uiWidth - padding * 2.0 - srcWidth * minScale) / 2.0 + borderWidth / 2.0,
                    (model.uiHeight - padding * 2.0 - srcHeight * minScale) / 2.0 + borderWidth / 2.0,
                    srcWidth * minScale - borderWidth,
                    srcHeight * minScale - borderWidth,
                    cornerRadius
                )
        }
    }

    func roundRect(context: CanvasRenderingContext2D, x: Float64, y: Float64, w: Float64, h: Float64, r: Float64) {
        var cornerLeftTopRadius = if (model.cornerLeftTopRadius > 0.0) {
            model.cornerLeftTopRadius
        } else {
            0.0
        }
        if (w < 2.0 * cornerLeftTopRadius) {
            cornerLeftTopRadius = w / 2.0
        }
        if (h < 2.0 * cornerLeftTopRadius) {
            cornerLeftTopRadius = h / 2.0
        }
        var cornerLeftBottomRadius = if (model.cornerLeftBottomRadius > 0.0) {
            model.cornerLeftBottomRadius
        } else {
            0.0
        }
        if (w < 2.0 * cornerLeftBottomRadius) {
            cornerLeftBottomRadius = w / 2.0
        }
        if (h < 2.0 * cornerLeftBottomRadius) {
            cornerLeftBottomRadius = h / 2.0
        }
        var cornerRightTopRadius = if (model.cornerRightTopRadius > 0.0) {
            model.cornerRightTopRadius
        } else {
            0.0
        }
        if (w < 2.0 * cornerRightTopRadius) {
            cornerRightTopRadius = w / 2.0
        }
        if (h < 2.0 * cornerRightTopRadius) {
            cornerRightTopRadius = h / 2.0
        }
        var cornerRightBottomRadius = if (model.cornerRightBottomRadius > 0.0) {
            model.cornerRightBottomRadius
        } else {
            0.0
        }
        if (w < 2.0 * cornerRightBottomRadius) {
            cornerRightBottomRadius = w / 2.0
        }
        if (h < 2.0 * cornerRightBottomRadius) {
            cornerRightBottomRadius = h / 2.0
        }
        var r1 = r
        if (w < 2.0 * r1) {
            r1 = w / 2.0
        }
        if (h < 2.0 * r1) {
            r1 = h / 2.0
        }
        cornerLeftTopRadius = if (cornerLeftTopRadius == 0.0) {
            r1
        } else {
            cornerLeftTopRadius
        }
        cornerLeftBottomRadius = if (cornerLeftBottomRadius == 0.0) {
            r1
        } else {
            cornerLeftBottomRadius
        }
        cornerRightTopRadius = if (cornerRightTopRadius == 0.0) {
            r1
        } else {
            cornerRightTopRadius
        }
        cornerRightBottomRadius = if (cornerRightBottomRadius == 0.0) {
            r1
        } else {
            cornerRightBottomRadius
        }
        // 创建一个新的绘制路径
        context.beginPath()
        // 路径从当前点移动到指定点
        context.moveTo(x + cornerLeftTopRadius, y)
        // 右上圆角
        context.arcTo(x + w, y, x + w, y + h, cornerRightTopRadius)
        // 右下圆角
        context.arcTo(x + w, y + h, x, y + h, cornerRightBottomRadius)
        // 左下圆角
        context.arcTo(x, y + h, x, y, cornerLeftBottomRadius)
        // 左上圆角
        context.arcTo(x, y, x + w, y, cornerLeftTopRadius)
        // 结束当前路径形成一个封闭路径
        context.closePath()
    }

    func setOval() {
        let borderWidth = if(model.borderWidth > 0.0){
            model.borderWidth
        } else {
            0.0
        }
        match (model.scaleType) {
            case None => ()
            case Some(ScaleType.FIT_START) =>
                context.ellipse(
                    srcWidth * minScale / 2.0,
                    srcHeight * minScale / 2.0,
                    (srcWidth * minScale - borderWidth) / 2.0,
                    (srcHeight * minScale - borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0
                )
            case Some(ScaleType.FIT_END) =>
                context.ellipse(
                    model.uiWidth - srcWidth * minScale + srcWidth * minScale / 2.0,
                    srcHeight * minScale / 2.0,
                    (srcWidth * minScale - borderWidth) / 2.0,
                    (srcHeight * minScale - borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0
                )
            case Some(ScaleType.FIT_CENTER) =>
                context.ellipse(
                    model.uiWidth / 2.0,
                    srcHeight * minScale / 2.0,
                    (srcWidth * minScale - borderWidth) / 2.0,
                    (srcHeight * minScale - borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0
                )
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
                context.ellipse(
                    (x + w) / 2.0,
                    (y + h) / 2.0,
                    (w - borderWidth) / 2.0,
                    (h - borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0
                )
            case Some(ScaleType.CENTER_CROP) =>
                context.ellipse(
                    model.uiWidth / 2.0,
                    model.uiHeight / 2.0,
                    (model.uiWidth - borderWidth) / 2.0,
                    (model.uiHeight - borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0
                )
            case Some(ScaleType.FIT_XY) =>
                context.ellipse(
                    model.uiWidth / 2.0,
                    model.uiHeight / 2.0,
                    (srcWidth * scaleW - borderWidth) / 2.0,
                    (srcHeight * scaleH - borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0
                )
            case Some(ScaleType.CENTER_INSIDE) =>
                context.ellipse(
                    model.uiWidth / 2.0,
                    model.uiHeight / 2.0,
                    (srcWidth * minScale - borderWidth) / 2.0,
                    (srcHeight * minScale - borderWidth) / 2.0,
                    0.0,
                    0.0,
                    mathPI * 2.0
                )
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
                        context.translate(srcWidth + Float64(indexW) * srcWidth * 2.0, srcHeight + Float64(indexH) * srcHeight * 2.0)
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

    private func drawBitmap() {
        let callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit = {
            pixelMap, width, height, error =>
                if (error) {
                    launch {
                        img = pixelMap
                        srcWidth = Float64(width)
                        srcHeight = Float64(height)
                        let padding = if(model.padding > 0.0){
                            model.padding
                        } else {
                            0.0
                        }
                        scaleW = (model.uiWidth - padding * 2.0) / srcWidth
                        scaleH = (model.uiHeight - padding * 2.0) / srcHeight
                        // 绘制边框
                        if(model.borderWidth > 0.0){
                            // 边框大于0的时候才绘制边框
                            if (let Some(v) <- model.borderColor) {
                                context.strokeStyle(v)
                            } else if (let Some(v) <- model.borderColorUInt32) {
                                context.strokeStyle(v)
                            } else if (let Some(v) <- model.borderColorCanvasGradient) {
                                context.strokeStyle(v)
                            }
                            context.lineWidth(model.borderWidth)
                        }
                        context.save()
                        // 图形矩阵变化
                        setImageCanvasTransform()
                        // 图片内容绘制
                        setImage()
                        context.restore()
                        context.globalCompositeOperation(CompositeOperation.DestinationIn)
                        setRect()
                        context.fill()
                        context.globalCompositeOperation(CompositeOperation.SourceOver)
                        setRect()
                        if(model.borderWidth > 0.0){
                            context.stroke()
                        }
                    }
                }
        }
        fut = PixelMapUtils.createPixelMap(model.src, model.srcResource, model.srcArray, model.srcType, model.isSvg, callback, model.getContext())
    }

    private func drawOvals() {
        let callback: (pixelMap: ?PixelMap, width: Int64, height: Int64, error: Bool) -> Unit = {
            pixelMap, width, height, error =>
                if (error) {
                    launch {
                        img = pixelMap
                        srcWidth = Float64(width)
                        srcHeight = Float64(height)
                        let padding = if(model.padding > 0.0){
                            model.padding
                        } else {
                            0.0
                        }
                        scaleW = (model.uiWidth - padding * 2.0) / srcWidth
                        scaleH = (model.uiHeight - padding * 2.0) / srcHeight
                        if(model.borderWidth > 0.0){
                            // 边框大于0的时候才绘制边框
                            if (let Some(v) <- model.borderColor) {
                                context.strokeStyle(v)
                            } else if (let Some(v) <- model.borderColorUInt32) {
                                context.strokeStyle(v)
                            } else if (let Some(v) <- model.borderColorCanvasGradient) {
                                context.strokeStyle(v)
                            }
                            context.lineWidth(model.borderWidth)
                        }
                        context.save()
                        setImageCanvasTransform()
                        setImage()
                        context.restore()
                        context.globalCompositeOperation(CompositeOperation.DestinationIn)
                        setOval()
                        context.fill()
                        context.globalCompositeOperation(CompositeOperation.SourceOver)
                        setOval()
                        if(model.borderWidth > 0.0){
                            context.stroke()
                        }
                    }
                }
        }
        fut = PixelMapUtils.createPixelMap(model.src, model.srcResource, model.srcArray, model.srcType, model.isSvg, callback, model.getContext())
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
        if(model.borderWidth > 0.0){
            // 边框大于0的时候才绘制边框
            if (let Some(v) <- model.borderColor) {
                context.strokeStyle(v)
            } else if (let Some(v) <- model.borderColorUInt32) {
                context.strokeStyle(v)
            } else if (let Some(v) <- model.borderColorCanvasGradient) {
                context.strokeStyle(v)
            } else {
            }
            context.lineWidth(model.borderWidth)
        }
        let borderWidth = if(model.borderWidth > 0.0){
            model.borderWidth
        } else {
            0.0
        }
        let cornerRadius = if(model.cornerRadius > 0.0){
            model.cornerRadius
        } else {
            0.0
        }
        match (model.scaleType) {
            case None => ()
            case Some(ScaleType.FIT_START) =>
                context.fillRect(0.0, 0.0, model.colorWidth * minScale, model.colorHeight * minScale)
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                roundRect(
                    context,
                    borderWidth / 2.0,
                    borderWidth / 2.0,
                    model.colorWidth * minScale - borderWidth,
                    model.colorHeight * minScale - borderWidth,
                    cornerRadius
                )
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                roundRect(
                    context,
                    borderWidth / 2.0,
                    borderWidth / 2.0,
                    model.colorWidth * minScale - borderWidth,
                    model.colorHeight * minScale - borderWidth,
                    cornerRadius
                )
                if(model.borderWidth > 0.0){
                    context.stroke()
                }
            case Some(ScaleType.FIT_END) =>
                context.fillRect(
                    model.uiWidth - model.colorWidth * minScale,
                    model.uiHeight - model.colorHeight * minScale,
                    model.colorWidth * minScale,
                    model.colorHeight * minScale
                )
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                roundRect(
                    context,
                    model.uiWidth - model.colorWidth * minScale + borderWidth / 2.0,
                    model.uiHeight - model.colorHeight * minScale + borderWidth / 2.0,
                    model.colorWidth * minScale - borderWidth,
                    model.colorHeight * minScale - borderWidth,
                    cornerRadius
                )
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                roundRect(
                    context,
                    model.uiWidth - model.colorWidth * minScale + borderWidth / 2.0,
                    model.uiHeight - model.colorHeight * minScale + borderWidth / 2.0,
                    model.colorWidth * minScale - borderWidth,
                    model.colorHeight * minScale - borderWidth,
                    cornerRadius
                )
                if(model.borderWidth > 0.0){
                    context.stroke()
                }
            case Some(ScaleType.FIT_CENTER) =>
                context.fillRect(
                    (model.uiWidth - model.colorWidth * minScale) / 2.0,
                    (model.uiHeight - model.colorHeight * minScale) / 2.0,
                    model.colorWidth * minScale,
                    model.colorHeight * minScale
                )
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                roundRect(
                    context,
                    (model.uiWidth - model.colorWidth * minScale) / 2.0 + borderWidth / 2.0,
                    (model.uiHeight - model.colorHeight * minScale) / 2.0 + borderWidth / 2.0,
                    model.colorWidth * minScale - borderWidth,
                    model.colorHeight * minScale - borderWidth,
                    cornerRadius
                )
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                roundRect(
                    context,
                    (model.uiWidth - model.colorWidth * minScale) / 2.0 + borderWidth / 2.0,
                    (model.uiHeight - model.colorHeight * minScale) / 2.0 + borderWidth / 2.0,
                    model.colorWidth * minScale - borderWidth,
                    model.colorHeight * minScale - borderWidth,
                    cornerRadius
                )
                if(model.borderWidth > 0.0){
                    context.stroke()
                }
            case _ =>
                context.fillRect(0.0, 0.0, model.uiWidth, model.uiHeight)
                context.globalCompositeOperation(CompositeOperation.DestinationIn)
                roundRect(
                    context,
                    borderWidth / 2.0,
                    borderWidth / 2.0,
                    model.uiWidth - borderWidth,
                    model.uiHeight - borderWidth,
                    cornerRadius
                )
                context.fill()
                context.globalCompositeOperation(CompositeOperation.SourceOver)
                roundRect(
                    context,
                    borderWidth / 2.0,
                    borderWidth / 2.0,
                    model.uiWidth - borderWidth,
                    model.uiHeight - borderWidth,
                    cornerRadius
                )
                if(model.borderWidth > 0.0){
                    context.stroke()
                }
        }
        if(model.borderWidth > 0.0){
            context.stroke()
        }
    }

    private func drawBackground() {
        if (let Some(v) <- model.backgroundColor) {
            bottomLayerContext.fillStyle(v)
        } else if (let Some(v) <- model.backgroundColorUInt32) {
            bottomLayerContext.fillStyle(v)
        } else if (let Some(v) <- model.backgroundColorCanvasGradient) {
            bottomLayerContext.fillStyle(v)
        }
        if(model.borderWidth > 0.0){
            // 边框大于0的时候才绘制边框
            if (let Some(v) <- model.borderColor) {
                bottomLayerContext.strokeStyle(v)
            } else if (let Some(v) <- model.borderColorUInt32) {
                bottomLayerContext.strokeStyle(v)
            } else if (let Some(v) <- model.borderColorCanvasGradient) {
                bottomLayerContext.strokeStyle(v)
            }
            bottomLayerContext.lineWidth(model.borderWidth)
        }
        bottomLayerContext.fillRect(0.0, 0.0, model.uiWidth, model.uiHeight)
        bottomLayerContext.globalCompositeOperation(CompositeOperation.DestinationIn)
        let borderWidth = if(model.borderWidth > 0.0){
            model.borderWidth
        } else {
            0.0
        }
        let cornerRadius = if(model.cornerRadius > 0.0){
            model.cornerRadius
        } else {
            0.0
        }
        roundRect(
            bottomLayerContext,
            borderWidth / 2.0,
            borderWidth / 2.0,
            model.uiWidth - borderWidth,
            model.uiHeight - borderWidth,
            cornerRadius
        )
        bottomLayerContext.fill()
        bottomLayerContext.globalCompositeOperation(CompositeOperation.SourceOver)
        roundRect(
            bottomLayerContext,
            borderWidth / 2.0,
            borderWidth / 2.0,
            model.uiWidth - borderWidth,
            model.uiHeight - borderWidth,
            cornerRadius
        )
        if(model.borderWidth > 0.0){
            bottomLayerContext.stroke()
        }
    }

    func build() {
        Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
            if (model.typeValue == ImgValueType.IMG_VALUE_BITMAP) {
                Canvas(context)
                    .width(model.uiWidth)
                    .height(model.uiHeight)
                    .onReady({
                        => drawBitmap()
                    })
            } else if (model.typeValue == ImgValueType.IMG_VALUE_OVALS) {
                Canvas(context)
                    .width(model.uiWidth)
                    .height(model.uiHeight)
                    .onReady({
                        => drawOvals()
                    })
            } else if (model.typeValue == ImgValueType.IMG_VALUE_COLOR) {
                Canvas(context)
                    .width(model.uiWidth)
                    .height(model.uiHeight)
                    .onReady({
                        => drawColors()
                    })
            } else if (model.typeValue == ImgValueType.IMG_VALUE_BACKGROUND) {
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
                    .padding(paddingSize(model.padding))
                }
                .width(model.uiWidth)
                .height(model.uiHeight)
            } else if (model.typeValue == ImgValueType.IMG_VALUE_SVG) {
                Canvas(context)
                    .width(model.uiWidth)
                    .height(model.uiHeight)
                    .onReady({
                        => drawBitmap()
                    })
            }
        }
        // 组件卸载消失时触发此回调
        .onDisAppear({ =>
            threadFutureCancel(fut)
            delPixelMap(img)
        })
    }
}
