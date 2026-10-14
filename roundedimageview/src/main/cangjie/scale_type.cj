package roundedimageview

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
    public override func hashCode(): Int64 {
        return toString().hashCode()
    }

    /**
     * 判断两个枚举是否相等
     *
     * @param that 其他枚举
     * @return 是否相等
     */
    public operator func ==(that: ScaleType): Bool {
        match ((this, that)) {
            case (FIT_START, FIT_START) => true
            case (FIT_END, FIT_END) => true
            case (FIT_CENTER, FIT_CENTER) => true
            case (CENTER, CENTER) => true
            case (CENTER_CROP, CENTER_CROP) => true
            case (FIT_XY, FIT_XY) => true
            case (CENTER_INSIDE, CENTER_INSIDE) => true
            case _ => false
        }
    }

    /**
     * 判断两个枚举是否不相等
     *
     * @param that 其他枚举
     * @return 是否不相等
     */
    public operator func !=(that: ScaleType): Bool {
        return !(this == that)
    }

    /**
     * 获取toString
     *
     * @return toString
     */
    public override func toString(): String {
        match (this) {
            case FIT_START => "FIT_START"
            case FIT_END => "FIT_END"
            case FIT_CENTER => "FIT_CENTER"
            case CENTER => "CENTER"
            case CENTER_CROP => "CENTER_CROP"
            case FIT_XY => "FIT_XY"
            case CENTER_INSIDE => "CENTER_INSIDE"
        }
    }
}
