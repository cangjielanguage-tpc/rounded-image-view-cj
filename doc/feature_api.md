# roundedImageView API

## UI使用接口

### class RoundedImageView

RoundedImageView预览自定义控件

```cangjie
/**
 * roundedimageview预览自定义控件
 */
@Component
public class RoundedImageView {
    /**
    * 初始化roundedimageview自定义控件
    *
    * @param model 传入roundedimageview配置内容
    */
    RoundedImageView(model: model)
}
```

## UI配置接口

### class RoundedImageNameModel

RoundedImageNameModel数据源

```cangjie
/**
 * 属性配置选项
 */
public class RoundedImageNameModel {
    /**
     * 初始化RoundedImageNameModel
     */
    public init()

    /**
     * 设置上下文
     *
     * @param context 上下文
     * @return RoundedImageNameModel对象
     */
    public func setContext(context: AbilityContext): RoundedImageNameModel

    /**
     * 获取上下文
     *
     * @return 上下文
     */
    public func getContext(): ?AbilityContext

    /**
     * 设置图片数据源
     *
     * @param src 图片数据源。(网络路径图片)(沙盒路径图片)(resources资源名)(rawfile路径)
     * @return RoundedImageNameModel对象
     */
    public func setImageSrc(src: ?String): RoundedImageNameModel

    /**
     * 设置图片数据源
     *
     * @param srcArray 图片数组数据源
     * @return RoundedImageNameModel对象
     */
    public func setImageSrc(srcArray: ?Array<Byte>): RoundedImageNameModel

    /**
     * 设置图片数据源
     *
     * @param srcResource 图片resources资源
     * @return RoundedImageNameModel对象
     */
    public func setImageSrc(srcResource: ?CJResource): RoundedImageNameModel

    /**
     * 获取图片数据源
     *
     * @return 图片数据源
     */
    public func getImageSrc(): ?String

    /**
     * 获取图片数据源
     *
     * @return 图片数据源
     */
    public func getImageSrcArray(): ?Array<Byte>

    /**
     * 获取图片数据源
     *
     * @return 图片数据源
     */
    public func getImageSrcResource(): ?CJResource

    /**
     * 设置图片类型
     *
     * @param srcType 图片类型。(MEDIA：resources类型)(RAWFILE：rawfile类型)(URI：URI类型,沙盒)(URL：URL，网络)(ARRAYBUFFER：byte数组)
     * @return RoundedImageNameModel对象
     */
    public func setSrcType(srcType: ?SrcType): RoundedImageNameModel

    /**
     * 获取图片类型
     *
     * @return 图片类型
     */
    public func getSrcType(): ?SrcType

    /**
     * 设置是否是SVG图片
     *
     * @param isSvg 是否是SVG图片。(true：是SVG图片)(false：不是SVG图片)
     * @return RoundedImageNameModel对象
     */
    public func setIsSvg(isSvg: Bool): RoundedImageNameModel

    /**
     * 获取是否是SVG图片
     *
     * @return 是否是SVG图片
     */
    public func getIsSvg(): Bool

    /**
     * 设置显示类型
     *
     * @param typeValue 显示类型。(Bitmap:圆角图片类型)(Ovals:椭圆形图片类型)(Color:颜色类型)(Background:带有背景的类型)(SVG:SVG类型)
     * @return RoundedImageNameModel对象
     */
    public func setTypeValue(typeValue: ImgValueType): RoundedImageNameModel

    /**
     * 获取显示类型
     *
     * @return 显示类型
     */
    public func getTypeValue(): ImgValueType

    /**
     * 设置控件宽度
     *
     * @param 控件宽度
     * @return RoundedImageNameModel对象
     */
    public func setUiWidth(uiWidth: Float64): RoundedImageNameModel

    /**
     * 获取控件宽度
     *
     * @return 控件宽度
     */
    public func getUiWidth(): Float64

    /**
     * 设置控件高度
     *
     * @param 控件高度
     * @return RoundedImageNameModel对象
     */
    public func setUiHeight(uiHeight: Float64): RoundedImageNameModel

    /**
     * 获取控件高度
     *
     * @return 控件高度
     */
    public func getUiHeight(): Float64

    /**
     * 设置图片缩放类型
     *
     * @param scaleType 图片缩放类型。(FIT_START:等比缩放到控件大小，并放置在控件的上边或左边展示)(FIT_END:图片等比缩放到控件大小，并放置在控件的下边或右边展示)(FIT_CENTER:等比缩放到能够填充控件大小，并居中展示)(CENTER:不使用缩放，ImageView会展示图片的中心部分)(CENTER_CROP:等比缩放直到完全填充整个ImageView，并居中显示)(FIT_XY:缩放到控件大小，完全填充控件大小展示)(CENTER_INSIDE:等比缩放到能够完整展示在ImageView中并居中)
     * @return RoundedImageNameModel对象
     */
    public func setScaleType(scaleType: ?ScaleType): RoundedImageNameModel

    /**
     * 获取图片缩放类型
     *
     * @return 图片缩放类型
     */
    public func getScaleType(): ?ScaleType

    /**
     * 设置图片平铺方式
     *
     * @param tileMode。(CLAMP:复制边缘色彩 )(REPEAT:X、Y 轴进行重复图片显示)(MIRROR:在水平和垂直方向上使用交替镜像的方式重复图片的绘制)
     * @return RoundedImageNameModel对象
     */
    public func setTileModeXY(tileMode: ?TileMode): RoundedImageNameModel

    /**
     * 获取图片平铺方式
     *
     * @return 图片平铺方式
     */
    public func getTileModeXY(): ?TileMode

    /**
     * 设置背景颜色
     *
     * @param backgroundColor 背景颜色
     * @return RoundedImageNameModel对象
     */
    public func setBackgroundColor(backgroundColor: ?Color): RoundedImageNameModel

    /**
     * 设置背景颜色
     *
     * @param backgroundColorUInt32 背景颜色
     * @return RoundedImageNameModel对象
     */
    public func setBackgroundColor(backgroundColorUInt32: ?UInt32): RoundedImageNameModel

    /**
     * 设置背景颜色
     *
     * @param backgroundColorCanvasGradient 背景颜色
     * @return RoundedImageNameModel对象
     */
    public func setBackgroundColor(backgroundColorCanvasGradient: ?CanvasGradient): RoundedImageNameModel

    /**
     * 获取背景颜色
     *
     * @return 背景颜色
     */
    public func getBackgroundColor(): ?Color

    /**
     * 获取背景颜色
     *
     * @return 背景颜色
     */
    public func getBackgroundColorCanvasRendering(): ?UInt32

    /**
     * 获取背景颜色
     *
     * @return 背景颜色
     */
    public func getBackgroundColorCanvasGradient(): ?CanvasGradient

    /**
     * 设置圆角大小。设置圆角角半径为负数的时候，默认设置为0。分别设置四个圆角半径的时候，优先显示单独设置四个圆角半径。当设置值为负数或0的时候，通用圆角半径才生效
     *
     * @param cornerRadius 圆角大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerRadius(cornerRadius: Float64): RoundedImageNameModel

    /**
     * 获取圆角大小
     *
     * @return 圆角大小
     */
    public func getCornerRadius(): Float64
    
    /**
     * 设置圆角左上大小。设置圆角左上角半径为负数的时候，默认设置为0。
     *
     * @param cornerLeftTopRadius 圆角左上大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerLeftTopRadius(cornerLeftTopRadius: Float64): RoundedImageNameModel

    /**
     * 获取圆角左上大小
     *
     * @return 圆角左上大小
     */
    public func getCornerLeftTopRadius(): Float64

    /**
     * 设置圆角左下大小。设置圆角左下角半径为负数的时候，默认设置为0。
     *
     * @param cornerLeftBottomRadius 圆角左下大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerLeftBottomRadius(cornerLeftBottomRadius: Float64): RoundedImageNameModel

    /**
     * 获取圆角左下大小
     *
     * @return 圆角左下大小
     */
    public func getCornerLeftBottomRadius(): Float64

    /**
     * 设置圆角右上大小。设置圆角右上角半径为负数的时候，默认设置为0。
     *
     * @param cornerRightTopRadius 圆角右上大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerRightTopRadius(cornerRightTopRadius: Float64): RoundedImageNameModel

    /**
     * 获取圆角右上大小
     *
     * @return 圆角右上大小
     */
    public func getCornerRightTopRadius(): Float64

    /**
     * 设置圆角右下大小。设置圆角右下角半径为负数的时候，默认设置为0。
     *
     * @param cornerRightBottomRadius 圆角右下大小
     * @return RoundedImageNameModel对象
     */
    public func setCornerRightBottomRadius(cornerRightBottomRadius: Float64): RoundedImageNameModel

    /**
     * 获取圆角右下大小
     *
     * @return 圆角右下大小
     */
    public func getCornerRightBottomRadius(): Float64

    /**
     * 设置边框宽度。设置边框宽度为负数的时候，默认设置为0。
     *
     * @param borderWidth 边框宽度
     * @return RoundedImageNameModel对象
     */
    public func setBorderWidth(borderWidth: Float64): RoundedImageNameModel

    /**
     * 获取边框宽度
     *
     * @return 边框宽度
     */
    public func getBorderWidth(): Float64

    /**
     * 设置边框颜色
     *
     * @param borderColor 边框颜色
     * @return RoundedImageNameModel对象
     */
    public func setBorderColor(borderColor: ?Color): RoundedImageNameModel

    /**
     * 设置边框颜色
     *
     * @param borderColorUInt32 边框颜色
     * @return RoundedImageNameModel对象
     */
    public func setBorderColor(borderColorUInt32: ?UInt32): RoundedImageNameModel

    /**
     * 设置边框颜色
     *
     * @param borderColorCanvasGradient 边框颜色
     * @return RoundedImageNameModel对象
     */
    public func setBorderColor(borderColorCanvasGradient: ?CanvasGradient): RoundedImageNameModel

    /**
     * 获取边框颜色
     *
     * @return 边框颜色
     */
    public func getBorderColor(): ?Color

    /**
     * 获取边框颜色
     *
     * @return 边框颜色
     */
    public func getBorderColorCanvasRendering(): ?UInt32

    /**
     * 获取边框颜色
     *
     * @return 边框颜色
     */
    public func getBorderColorCanvasGradient(): ?CanvasGradient

    /**
     * 设置内边距大小。设置内边距大小为负数的时候，默认设置为0。
     *
     * @param padding 内边距大小
     * @return RoundedImageNameModel对象
     */
    public func setPadding(padding: Float64): RoundedImageNameModel

    /**
     * 获取内边距大小
     *
     * @return 内边距大小
     */
    public func getPadding(): Float64

    /**
     * 设置颜色宽度
     *
     * @param colorWidth 颜色宽度
     * @return RoundedImageNameModel对象
     */
    public func setColorWidth(colorWidth: Float64): RoundedImageNameModel

    /**
     * 获取颜色宽度
     *
     * @return 颜色宽度
     */
    public func getColorWidth(): Float64

    /**
     * 设置颜色高度
     *
     * @param colorHeight 颜色高度
     * @return RoundedImageNameModel对象
     */
    public func setColorHeight(colorHeight: Float64): RoundedImageNameModel

    /**
     * 获取颜色高度
     *
     * @return 颜色高度
     */
    public func getColorHeight(): Float64
}
```

### class GlobalContext

GlobalContext上下文

```cangjie
/**
 * 上下文
 */
public class GlobalContext {
    /**
     * 单列获取对象
     */
    public static func getContext(): GlobalContext

    /**
     * 获取上下文对象
     */
    public func getAbilityContext(): ?AbilityContext

    /**
     * 设置上下文对象
     */
    public func setAbilityContext(objectClass: AbilityContext): Unit
}
```

### enum ScaleType 

ScaleType图片缩放类型

```cangjie
/**
 * 图片缩放类型
 */
public enum ScaleType <: Hashable & Equatable<ScaleType> & ToString {
    // 等比缩放到控件大小，并放置在控件的上边或左边展示
    | FIT_START
    // 图片等比缩放到控件大小，并放置在控件的下边或右边展示
    | FIT_END
    // 等比缩放到能够填充控件大小，并居中展示
    | FIT_CENTER
    // 不使用缩放，控件会展示图片的中心部分
    | CENTER
    // 等比缩放直到完全填充整个控件，并居中显示
    | CENTER_CROP
    // 缩放到控件大小，完全填充控件大小展示
    | FIT_XY
    // 等比缩放到能够完整展示在控件中并居中
    | CENTER_INSIDE

    /**
     * 获取hashCode
     *
     * @return hashCode
     */
    public override func hashCode(): Int64

    /**
     * 判断两个枚举是否相等
     *
     * @param that 其他枚举
     * @return 是否相等
     */
    public operator func ==(that: ScaleType): Bool

    /**
     * 判断两个枚举是否不相等
     *
     * @param that 其他枚举
     * @return 是否不相等
     */
    public operator func !=(that: ScaleType): Bool

    /**
     * 获取toString
     *
     * @return toString
     */
    public override func toString(): String
}
```

### enum SrcType

SrcType 图片类型

```cangjie
/**
 * 图片类型
 */
public enum SrcType <: Hashable & Equatable<SrcType> & ToString {
    // resources类型
    | MEDIA
    // rawfile类型
    | RAWFILE
    // URI类型,沙盒
    | URI
    // URL，网络
    | URL
    // byte数组
    | ARRAYBUFFER

    /**
     * 获取hashCode
     *
     * @return hashCode
     */
    public override func hashCode(): Int64

    /**
     * 判断两个枚举是否相等
     *
     * @param that 其他枚举
     * @return 是否相等
     */
    public operator func ==(that: SrcType): Bool

    /**
     * 判断两个枚举是否不相等
     *
     * @param that 其他枚举
     * @return 是否不相等
     */
    public operator func !=(that: SrcType): Bool

    /**
     * 获取toString
     *
     * @return toString
     */
    public override func toString(): String
}
```

### enum TileMode

TileMode图片平铺方式

```cangjie
/**
 * 图片平铺方式
 */
public enum TileMode <: Hashable & Equatable<TileMode> & ToString {
    // 复制边缘色彩
    | CLAMP
    // X、Y 轴进行重复图片显示
    | REPEAT
    // 在水平和垂直方向上使用交替镜像的方式重复图片的绘制
    | MIRROR

    /**
     * 获取hashCode
     *
     * @return hashCode
     */
    public override func hashCode(): Int64

    /**
     * 判断两个枚举是否相等
     *
     * @param that 其他枚举
     * @return 是否相等
     */
    public operator func ==(that: TileMode): Bool

    /**
     * 判断两个枚举是否不相等
     *
     * @param that 其他枚举
     * @return 是否不相等
     */
    public operator func !=(that: TileMode): Bool

    /**
     * 获取toString
     *
     * @return toString
     */
    public override func toString(): String
}
```

### enum ImgValueType

ImgValueType图片显示类型

```cangjie
/**
 * 图片显示类型
 */
public enum ImgValueType <: Hashable & Equatable<ImgValueType> & ToString {
    // 圆角图片
    | IMG_VALUE_BITMAP
    // 椭圆图片
    | IMG_VALUE_OVALS
    // 颜色
    | IMG_VALUE_COLOR
    // 背景
    | IMG_VALUE_BACKGROUND
    // SVG
    | IMG_VALUE_SVG

    /**
     * 获取hashCode
     *
     * @return hashCode
     */
    public override func hashCode(): Int64

    /**
     * 判断两个枚举是否相等
     *
     * @param that 其他枚举
     * @return 是否相等
     */
    public operator func ==(that: ImgValueType): Bool

    /**
     * 判断两个枚举是否不相等
     *
     * @param that 其他枚举
     * @return 是否不相等
     */
    public operator func !=(that: ImgValueType): Bool

    /**
     * 获取toString
     *
     * @return toString
     */
    public override func toString(): String
}
```