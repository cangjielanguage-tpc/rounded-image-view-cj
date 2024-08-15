/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

public enum ScaleType <: Hashable & Equatable<ScaleType> & ToString {
    | FIT_START
    | FIT_END
    | FIT_CENTER
    | CENTER
    | CENTER_CROP
    | FIT_XY
    | CENTER_INSIDE

    public override func hashCode(): Int64 {
        return toString().hashCode()
    }

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

    public operator func !=(that: ScaleType): Bool {
        return !(this == that)
    }

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
