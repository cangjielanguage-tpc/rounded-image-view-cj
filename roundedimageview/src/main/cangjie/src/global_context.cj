/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

class GlobalContext {
    private static var instance: ?GlobalContext = Option<GlobalContext>.None
    private var _objects = HashMap<String, Object>()
    private init() {}

    public func getContext(): ?GlobalContext {
        if (let Some(instance) <- GlobalContext.instance) {
        } else {
            GlobalContext.instance = GlobalContext()
        }
        return GlobalContext.instance
    }

    func getObject(value: String): ?Object {
        return this._objects.get(value);
    }

    func setObject(key: String, objectClass: Object): Unit {
        this._objects.put(key, objectClass);
    }
}
