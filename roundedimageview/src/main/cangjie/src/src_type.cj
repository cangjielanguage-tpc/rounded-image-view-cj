/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package roundedimageview

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
    public override func hashCode(): Int64 {
        return toString().hashCode()
    }

    /**
     * 判断两个枚举是否相等
     *
     * @param that 其他枚举
     * @return 是否相等
     */
    public operator func ==(that: SrcType): Bool {
        match ((this, that)) {
            case (MEDIA, MEDIA) => true
            case (RAWFILE, RAWFILE) => true
            case (URI, URI) => true
            case (URL, URL) => true
            case (ARRAYBUFFER, ARRAYBUFFER) => true
            case _ => false
        }
    }

    /**
     * 判断两个枚举是否不相等
     *
     * @param that 其他枚举
     * @return 是否不相等
     */
    public operator func !=(that: SrcType): Bool {
        return !(this == that)
    }

    /**
     * 获取toString
     *
     * @return toString
     */
    public override func toString(): String {
        match (this) {
            case MEDIA => "MEDIA"
            case RAWFILE => "RAWFILE"
            case URI => "URI"
            case URL => "URL"
            case ARRAYBUFFER => "ARRAYBUFFER"
        }
    }
}
