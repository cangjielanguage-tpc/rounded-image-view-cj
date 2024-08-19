/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

class PictureItem {
    var src: ?String = None
    var srcArray: ?Array<Byte> = None
    var srcResource: ?CJResource = None
    var srcType: ?SrcType = None
    var isSvg: Bool = false
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
    var primaryTitle: String = ""
    var secondTitle: String = ""
    var scaleTypeName: String = ""

    public init(src!: ?String = None, srcArray!: ?Array<Byte>= None, srcResource!: ?CJResource= None, srcType!: ?SrcType = None, isSvg!: Bool = false,
        uiWidth!: Float64 = 0.0, uiHeight!: Float64 = 0.0, backgroundColor!: ?Color = None, backgroundColorUInt32!: ?UInt32 = None,
        backgroundColorCanvasGradient!: ?CanvasGradient = None, tileMode!: ?TileMode = None, scaleType!: ?ScaleType = None,
        cornerRadius!: Float64 = 0.0, borderWidth!: Float64 = 0.0, borderColor!: ?Color = None, borderColorUInt32!: ?UInt32 = None,
        borderColorCanvasGradient!: ?CanvasGradient = None, padding!: Float64 = 0.0, primaryTitle!: String = "", secondTitle!: String = "",
        scaleTypeName!: String = "") {
        this.src = src
        this.srcArray = srcArray
        this.srcResource = srcResource
        this.srcType = srcType
        this.isSvg = isSvg
        this.uiWidth = uiWidth
        this.uiHeight = uiHeight
        this.backgroundColor = backgroundColor
        this.backgroundColorUInt32 = backgroundColorUInt32
        this.backgroundColorCanvasGradient = backgroundColorCanvasGradient
        this.tileMode = tileMode
        this.scaleType = scaleType
        this.cornerRadius = cornerRadius
        this.borderWidth = borderWidth
        this.borderColor = borderColor
        this.borderColorUInt32 = borderColorUInt32
        this.borderColorCanvasGradient = borderColorCanvasGradient
        this.padding = padding
        this.primaryTitle = primaryTitle
        this.secondTitle = secondTitle
        this.scaleTypeName = scaleTypeName
    }
}
