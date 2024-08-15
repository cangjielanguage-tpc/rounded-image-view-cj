/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

public enum TileMode <: Hashable & Equatable<TileMode> & ToString {
    | CLAMP
    | REPEAT
    | MIRROR

    public override func hashCode(): Int64 {
        return toString().hashCode()
    }

    public operator func ==(that: TileMode): Bool {
        match ((this, that)) {
            case (CLAMP, CLAMP) => true
            case (REPEAT, REPEAT) => true
            case (MIRROR, MIRROR) => true
            case _ => false
        }
    }

    public operator func !=(that: TileMode): Bool {
        return !(this == that)
    }

    public override func toString(): String {
        match (this) {
            case CLAMP => "CLAMP"
            case REPEAT => "REPEAT"
            case MIRROR => "MIRROR"
        }
    }
}
