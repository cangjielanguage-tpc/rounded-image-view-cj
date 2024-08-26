/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

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
    public override func hashCode(): Int64 {
        return toString().hashCode()
    }

    /**
     * 判断两个枚举是否相等
     *
     * @param that 其他枚举
     * @return 是否相等
     */
    public operator func ==(that: ImgValueType): Bool {
        match ((this, that)) {
            case (IMG_VALUE_BITMAP, IMG_VALUE_BITMAP) => true
            case (IMG_VALUE_OVALS, IMG_VALUE_OVALS) => true
            case (IMG_VALUE_COLOR, IMG_VALUE_COLOR) => true
            case (IMG_VALUE_BACKGROUND, IMG_VALUE_BACKGROUND) => true
            case (IMG_VALUE_SVG, IMG_VALUE_SVG) => true
            case _ => false
        }
    }

    /**
     * 判断两个枚举是否不相等
     *
     * @param that 其他枚举
     * @return 是否不相等
     */
    public operator func !=(that: ImgValueType): Bool {
        return !(this == that)
    }

    /**
     * 获取toString
     *
     * @return toString
     */
    public override func toString(): String {
        match (this) {
            case IMG_VALUE_BITMAP => "Bitmap"
            case IMG_VALUE_OVALS => "Ovals"
            case IMG_VALUE_COLOR => "Color"
            case IMG_VALUE_BACKGROUND => "Background"
            case IMG_VALUE_SVG => "SVG"
        }
    }
}
