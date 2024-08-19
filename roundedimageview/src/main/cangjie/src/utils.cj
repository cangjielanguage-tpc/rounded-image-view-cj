/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
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
