/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package roundedimageview

public class GlobalContext {
    private static var instance: ?GlobalContext = Option<GlobalContext>.None
    private var _objects = HashMap<String, AbilityContext>()
    private init() {}

    public static func getContext(): GlobalContext {
        if (let Some(instance) <- GlobalContext.instance) {
        } else {
            GlobalContext.instance = GlobalContext()
        }
        return GlobalContext.instance()
    }

    public func getObject(value: String): ?AbilityContext {
        return this._objects.get(value)
    }

    public func setObject(key: String, objectClass: AbilityContext): Unit {
        this._objects.put(key, objectClass)
    }
}
