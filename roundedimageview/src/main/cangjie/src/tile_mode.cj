/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package roundedimageview

/**
 * 图片平铺方式
 */
public enum TileMode <: Hashable & Equatable<TileMode> & ToString {
    // 原图显示
    | CLAMP
    // 图片重复显示
    | REPEAT
    // 图片镜像显示
    | MIRROR

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
    public operator func ==(that: TileMode): Bool {
        match ((this, that)) {
            case (CLAMP, CLAMP) => true
            case (REPEAT, REPEAT) => true
            case (MIRROR, MIRROR) => true
            case _ => false
        }
    }

    /**
     * 判断两个枚举是否不相等
     *
     * @param that 其他枚举
     * @return 是否不相等
     */
    public operator func !=(that: TileMode): Bool {
        return !(this == that)
    }

    /**
     * 获取toString
     *
     * @return toString
     */
    public override func toString(): String {
        match (this) {
            case CLAMP => "CLAMP"
            case REPEAT => "REPEAT"
            case MIRROR => "MIRROR"
        }
    }
}
