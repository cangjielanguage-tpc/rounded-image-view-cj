/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

public class RoundedImageNameModel {
    var src: ?String = None
    var srcArray: ?Array<Byte> = None
    var srcResource: ?CJResource = None
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

    public func setImageSrc(src: ?String): RoundedImageNameModel {
        this.src = src
        return this
    }

    public func setImageSrc(srcArray: ?Array<Byte>): RoundedImageNameModel {
        this.srcArray = srcArray
        return this
    }

    public func setImageSrc(srcResource: ?CJResource): RoundedImageNameModel {
        this.srcResource = srcResource
        return this
    }

    public func getImageSrc(): ?String {
        return this.src
    }

    public func getImageSrcArray(): ?Array<Byte> {
        return this.srcArray
    }

    public func getImageSrcResource(): ?CJResource {
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

    public func setBackgroundColor(backgroundColor: ?Color): RoundedImageNameModel {
        this.backgroundColor = backgroundColor
        return this
    }

    public func setBackgroundColor(backgroundColorUInt32: ?UInt32): RoundedImageNameModel {
        this.backgroundColorUInt32 = backgroundColorUInt32
        return this
    }

    public func setBackgroundColor(backgroundColorCanvasGradient: ?CanvasGradient): RoundedImageNameModel {
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

    public func setBorderColor(borderColor: ?Color): RoundedImageNameModel {
        this.borderColor = borderColor
        return this
    }

    public func setBorderColor(borderColorUInt32: ?UInt32): RoundedImageNameModel {
        this.borderColorUInt32 = borderColorUInt32
        return this
    }

    public func setBorderColor(borderColorCanvasGradient: ?CanvasGradient): RoundedImageNameModel {
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
