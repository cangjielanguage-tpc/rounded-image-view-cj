/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

public enum SrcType <: Hashable & Equatable<SrcType> & ToString {
    | MEDIA
    | RAWFILE
    | URI
    | URL
    | ARRAYBUFFER

    public override func hashCode(): Int64 {
        return toString().hashCode()
    }

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

    public operator func !=(that: SrcType): Bool {
        return !(this == that)
    }

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
