package roundedimageview

/**
 * 扩展Option，getOrThrow()方法直接用()
 */
extend<T> Option<T> {
    operator func ()(): T {
        this.getOrThrow()
    }
}

/**
 * 取消线程
 */
func threadFutureCancel(fut: ?Future<Unit>) {
    spawn {
        if (let Some(v) <- fut) {
            v.cancel()
        }
    }
}

/**
 * 释放PixelMap
 */
func delPixelMap(pixelMap: ?PixelMap) {
    spawn {
        if (let Some(v) <- pixelMap) {
            v.Release()
        }
    }
}

func paddingSize(size: Float64): Float64 {
    let padding = if(size > 0.0){
        size
    } else {
        0.0
    }
    return padding
}
