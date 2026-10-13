package roundedimageview

/**
 * 属性配置选项
 */
public class RoundedImageNameModel {
    var src: ?String = None
    var srcArray: ?Array<Byte> = None
    var srcResource: ?AppResource = None
    var srcType: ?SrcType = None
    var isSvg: Bool = false
    var typeValue: ImgValueType = ImgValueType.IMG_VALUE_BITMAP
    var uiWidth: Float64 = 0.0
    var uiHeight: Float64 = 0.0
    var backgroundColor: ?Color = None
    var backgroundColorUInt32: ?UInt32 = None
    var backgroundColorCanvasGradient: ?CanvasGradient = None
    var tileMode: ?TileMode = None
    var scaleType: ?ScaleType = None
    var cornerRadius: Float64 = 0.0
    var cornerLeftTopRadius: Float64 = 0.0
    var cornerLeftBottomRadius: Float64 = 0.0
    var cornerRightTopRadius: Float64 = 0.0
    var cornerRightBottomRadius: Float64 = 0.0
    var borderWidth: Float64 = 0.0
    var borderColor: ?Color = None
    var borderColorUInt32: ?UInt32 = None
    var borderColorCanvasGradient: ?CanvasGradient = None
    var padding: Float64 = 0.0
    var colorWidth: Float64 = 0.0
    var colorHeight: Float64 = 0.0
    var context: ?UIAbilityContext = None

    /**
     * 初始化RoundedImageNameModel
     */
    public init() {
    }

    /**
     * 设置上下文
     *
     * @param context 上下文
     * @return RoundedImageNameModel对象
     */
    public func setContext(context: UIAbilityContext): RoundedImageNameModel {
        this.context = context
        return this
    }

    /**
     * 获取上下文
     *
     * @return 上下文
     */
    public func getContext(): ?UIAbilityContext {
        return this.context
    }

    /**
     * 设置图片数据源
     *
     * @param src 图片数据源。(网络路径图片)(沙盒路径图片)(resources资源名)(rawfile路径)
     * @return RoundedImageNameModel对象
     */
    public func setImageSrc(src: ?String): RoundedImageNameModel {
        this.src = src
        this.srcArray = None
        this.srcResource = None
        return this
    }

    /**
     * 设置图片数据源
     *
     * @param srcArray 图片数组数据源
     * @return RoundedImageNameModel对象
     */
    public func setImageSrc(srcArray: ?Array<Byte>): RoundedImageNameModel {
        this.srcArray = srcArray
        this.src = None
        this.srcResource = None
        return this
    }

    /**
     * 设置图片数据源
     *
     * @param srcResource 图片resources资源
     * @return RoundedImageNameModel对象
     */
    public func setImageSrc(srcResource: ?AppResource): RoundedImageNameModel {
        this.srcResource = srcResource
        this.src = None
        this.srcArray = None
        return this
    }

    /**
     * 获取图片数据源
     *
     * @return 图片数据源
     */
    public func getImageSrc(): ?String {
        return this.src
    }

    /**
     * 获取图片数据源
     *
     * @return 图片数据源
     */
    public func getImageSrcArray(): ?Array<Byte> {
        return this.srcArray
    }

    /**
     * 获取图片数据源
     *
     * @return 图片数据源
     */
    public func getImageSrcResource(): ?AppResource {
        return this.srcResource
    }

    /**
     * 设置图片类型
     *
     * @param srcType 图片类型。(MEDIA：resources类型)(RAWFILE：rawfile类型)(URI：URI类型,沙盒)(URL：URL，网络)(ARRAYBUFFER：byte数组)
     * @return RoundedImageNameModel对象
     */
    public func setSrcType(srcType: ?SrcType): RoundedImageNameModel {
        this.srcType = srcType
        return this
    }

    /**
     * 获取图片类型
     *
     * @return 图片类型
     */
    public func getSrcType(): ?SrcType {
        return this.srcType
    }

    /**
     * 设置是否是SVG图片
     *
     * @param isSvg 是否是SVG图片。(true：是SVG图片)(false：不是SVG图片)
     * @return RoundedImageNameModel对象
     */
    public func setIsSvg(isSvg: Bool): RoundedImageNameModel {
        this.isSvg = isSvg
        return this
    }

    /**
     * 获取是否是SVG图片
     *
     * @return 是否是SVG图片
     */
    public func getIsSvg(): Bool {
        return this.isSvg
    }

    /**
     * 设置显示类型
     *
     * @param typeValue 显示类型，默认Bitmap。(Bitmap:圆角图片类型)(Ovals:椭圆形图片类型)(Color:颜色类型)(Background:带有背景的类型)(SVG:SVG类型)
     * @return RoundedImageNameModel对象
     */
    public func setTypeValue(typeValue: ImgValueType): RoundedImageNameModel {
        this.typeValue = typeValue
        return this
    }

    /**
     * 获取显示类型
     *
     * @return 显示类型
     */
    public func getTypeValue(): ImgValueType {
        return this.typeValue
    }

    /**
     * 设置控件宽度
     *
     * @param 控件宽度
     * @return RoundedImageNameModel对象
     */
    public func setUiWidth(uiWidth: Float64): RoundedImageNameModel {
        this.uiWidth = uiWidth
        return this
    }

    /**
     * 获取控件宽度
     *
     * @return 控件宽度
     */
    public func getUiWidth(): Float64 {
        return this.uiWidth
    }

    /**
     * 设置控件高度
     *
     * @param 控件高度
     * @return RoundedImageNameModel对象
     */
    public func setUiHeight(uiHeight: Float64): RoundedImageNameModel {
        this.uiHeight = uiHeight
        return this
    }

    /**
     * 获取控件高度
     *
     * @return 控件高度
     */
    public func getUiHeight(): Float64 {
        return this.uiHeight
    }

    /**
     * 设置图片缩放类型
     *
     * @param scaleType 图片缩放类型。(FIT_START:等比缩放到控件大小，并放置在控件的上边或左边展示)(FIT_END:图片等比缩放到控件大小，并放置在控件的下边或右边展示)(FIT_CENTER:等比缩放到能够填充控件大小，并居中展示)(CENTER:不使用缩放，ImageView会展示图片的中心部分)(CENTER_CROP:等比缩放直到完全填充整个ImageView，并居中显示)(FIT_XY:缩放到控件大小，完全填充控件大小展示)(CENTER_INSIDE:等比缩放到能够完整展示在ImageView中并居中)
     * @return RoundedImageNameModel对象
     */
    public func setScaleType(scaleType: ?ScaleType): RoundedImageNameModel {
        this.scaleType = scaleType
        return this
    }

    /**
     * 获取图片缩放类型
     *
     * @return 图片缩放类型
     */
    public func getScaleType(): ?ScaleType {
        return this.scaleType
    }

    /**
     * 设置图片平铺方式
     *
     * @param tileMode。(CLAMP:复制边缘色彩 )(REPEAT:X、Y 轴进行重复图片显示)(MIRROR:在水平和垂直方向上使用交替镜像的方式重复图片的绘制)
     * @return RoundedImageNameModel对象
     */
    public func setTileModeXY(tileMode: ?TileMode): RoundedImageNameModel {
        this.tileMode = tileMode
        return this
    }

    /**
     * 获取图片平铺方式
     *
     * @return 图片平铺方式
     */
    public func getTileModeXY(): ?TileMode {
        return this.tileMode
    }

    /**
     * 设置背景颜色
     *
     * @param backgroundColor 背景颜色
     * @return RoundedImageNameModel对象
     */
    public func setBackgroundColor(backgroundColor: ?Color): RoundedImageNameModel {
        this.backgroundColor = backgroundColor
        this.backgroundColorUInt32 = None
        this.backgroundColorCanvasGradient = None
        return this
    }

    /**
     * 设置背景颜色
     *
     * @param backgroundColorUInt32 背景颜色
     * @return RoundedImageNameModel对象
     */
    public func setBackgroundColor(backgroundColorUInt32: ?UInt32): RoundedImageNameModel {
        this.backgroundColorUInt32 = backgroundColorUInt32
        this.backgroundColor = None
        this.backgroundColorCanvasGradient = None
        return this
    }

    /**
     * 设置背景颜色
     *
     * @param backgroundColorCanvasGradient 背景颜色
     * @return RoundedImageNameModel对象
     */
    public func setBackgroundColor(backgroundColorCanvasGradient: ?CanvasGradient): RoundedImageNameModel {
        this.backgroundColorCanvasGradient = backgroundColorCanvasGradient
        this.backgroundColor = None
        this.backgroundColorUInt32 = None
        return this
    }

    /**
     * 获取背景颜色
     *
     * @return 背景颜色
     */
    public func getBackgroundColor(): ?Color {
        return this.backgroundColor
    }

    /**
     * 获取背景颜色
     *
     * @return 背景颜色
     */
    public func getBackgroundColorCanvasRendering(): ?UInt32 {
        return this.backgroundColorUInt32
    }

    /**
     * 获取背景颜色
     *
     * @return 背景颜色
     */
    public func getBackgroundColorCanvasGradient(): ?CanvasGradient {
        return this.backgroundColorCanvasGradient
    }

    /**
     * 设置圆角大小。设置圆角角半径为负数的时候，默认设置为0。分别设置四个圆角半径的时候，优先显示单独设置四个圆角半径。当设置值为负数或0的时候，通用圆角半径才生效
     *
     * @param cornerRadius 圆角大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerRadius(cornerRadius: Float64): RoundedImageNameModel {
        this.cornerRadius = if (cornerRadius > 0.0) {
            cornerRadius
        } else {
            0.0
        }
        return this
    }

    /**
     * 获取圆角大小
     *
     * @return 圆角大小
     */
    public func getCornerRadius(): Float64 {
        return this.cornerRadius
    }

    /**
     * 设置圆角左上大小。设置圆角左上角半径为负数的时候，默认设置为0。
     *
     * @param cornerLeftTopRadius 圆角左上大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerLeftTopRadius(cornerLeftTopRadius: Float64): RoundedImageNameModel {
        this.cornerLeftTopRadius = if (cornerLeftTopRadius > 0.0) {
            cornerLeftTopRadius
        } else {
            0.0
        }
        return this
    }

    /**
     * 获取圆角左上大小
     *
     * @return 圆角左上大小
     */
    public func getCornerLeftTopRadius(): Float64 {
        return this.cornerLeftTopRadius
    }

    /**
     * 设置圆角左下大小。设置圆角左下角半径为负数的时候，默认设置为0。
     *
     * @param cornerLeftBottomRadius 圆角左下大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerLeftBottomRadius(cornerLeftBottomRadius: Float64): RoundedImageNameModel {
        this.cornerLeftBottomRadius = if (cornerLeftBottomRadius > 0.0) {
            cornerLeftBottomRadius
        } else {
            0.0
        }
        return this
    }

    /**
     * 获取圆角左下大小
     *
     * @return 圆角左下大小
     */
    public func getCornerLeftBottomRadius(): Float64 {
        return this.cornerLeftBottomRadius
    }

    /**
     * 设置圆角右上大小。设置圆角右上角半径为负数的时候，默认设置为0。
     *
     * @param cornerRightTopRadius 圆角右上大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerRightTopRadius(cornerRightTopRadius: Float64): RoundedImageNameModel {
        this.cornerRightTopRadius = if (cornerRightTopRadius > 0.0) {
            cornerRightTopRadius
        } else {
            0.0
        }
        return this
    }

    /**
     * 获取圆角右上大小
     *
     * @return 圆角右上大小
     */
    public func getCornerRightTopRadius(): Float64 {
        return this.cornerRightTopRadius
    }

    /**
     * 设置圆角右下大小。设置圆角右下角半径为负数的时候，默认设置为0。
     *
     * @param cornerRightBottomRadius 圆角右下大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerRightBottomRadius(cornerRightBottomRadius: Float64): RoundedImageNameModel {
        this.cornerRightBottomRadius = if (cornerRightBottomRadius > 0.0) {
            cornerRightBottomRadius
        } else {
            0.0
        }
        return this
    }

    /**
     * 获取圆角右下大小
     *
     * @return 圆角右下大小
     */
    public func getCornerRightBottomRadius(): Float64 {
        return this.cornerRightBottomRadius
    }

    /**
     * 设置边框宽度。设置边框宽度为负数的时候，默认设置为0。
     *
     * @param borderWidth 边框宽度
     * @return RoundedImageNameModel对象
     */
    public func setBorderWidth(borderWidth: Float64): RoundedImageNameModel {
        this.borderWidth = if (borderWidth > 0.0) {
            borderWidth
        } else {
            0.0
        }
        return this
    }

    /**
     * 获取边框宽度
     *
     * @return 边框宽度
     */
    public func getBorderWidth(): Float64 {
        return this.borderWidth
    }

    /**
     * 设置边框颜色
     *
     * @param borderColor 边框颜色
     * @return RoundedImageNameModel对象
     */
    public func setBorderColor(borderColor: ?Color): RoundedImageNameModel {
        this.borderColor = borderColor
        this.borderColorUInt32 = None
        this.borderColorCanvasGradient = None
        return this
    }

    /**
     * 设置边框颜色
     *
     * @param borderColorUInt32 边框颜色
     * @return RoundedImageNameModel对象
     */
    public func setBorderColor(borderColorUInt32: ?UInt32): RoundedImageNameModel {
        this.borderColorUInt32 = borderColorUInt32
        this.borderColor = None
        this.borderColorCanvasGradient = None
        return this
    }

    /**
     * 设置边框颜色
     *
     * @param borderColorCanvasGradient 边框颜色
     * @return RoundedImageNameModel对象
     */
    public func setBorderColor(borderColorCanvasGradient: ?CanvasGradient): RoundedImageNameModel {
        this.borderColorCanvasGradient = borderColorCanvasGradient
        this.borderColor = None
        this.borderColorUInt32 = None
        return this
    }

    /**
     * 获取边框颜色
     *
     * @return 边框颜色
     */
    public func getBorderColor(): ?Color {
        return this.borderColor
    }

    /**
     * 获取边框颜色
     *
     * @return 边框颜色
     */
    public func getBorderColorCanvasRendering(): ?UInt32 {
        return this.borderColorUInt32
    }

    /**
     * 获取边框颜色
     *
     * @return 边框颜色
     */
    public func getBorderColorCanvasGradient(): ?CanvasGradient {
        return this.borderColorCanvasGradient
    }

    /**
     * 设置内边距大小。设置内边距大小为负数的时候，默认设置为0。
     *
     * @param padding 内边距大小
     * @return RoundedImageNameModel对象
     */
    public func setPadding(padding: Float64): RoundedImageNameModel {
        this.padding = if (padding > 0.0) {
            padding
        } else {
            0.0
        }
        return this
    }

    /**
     * 获取内边距大小
     *
     * @return 内边距大小
     */
    public func getPadding(): Float64 {
        return this.padding
    }

    /**
     * 设置颜色宽度
     *
     * @param colorWidth 颜色宽度
     * @return RoundedImageNameModel对象
     */
    public func setColorWidth(colorWidth: Float64): RoundedImageNameModel {
        this.colorWidth = colorWidth
        return this
    }

    /**
     * 获取颜色宽度
     *
     * @return 颜色宽度
     */
    public func getColorWidth(): Float64 {
        return this.colorWidth
    }

    /**
     * 设置颜色高度
     *
     * @param colorHeight 颜色高度
     * @return RoundedImageNameModel对象
     */
    public func setColorHeight(colorHeight: Float64): RoundedImageNameModel {
        this.colorHeight = colorHeight
        return this
    }

    /**
     * 获取颜色高度
     *
     * @return 颜色高度
     */
    public func getColorHeight(): Float64 {
        return this.colorHeight
    }
}
