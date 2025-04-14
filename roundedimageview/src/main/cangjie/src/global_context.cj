/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package roundedimageview

/**
 * 上下文
 */
public class GlobalContext {
    private static var instance: ?GlobalContext = Option<GlobalContext>.None
    private var _objects = HashMap<String, AbilityContext>()

    private init() {}

    /**
     * 单列获取对象
     */
    public static func getContext(): GlobalContext {
        if (let Some(instance) <- GlobalContext.instance) {
        } else {
            GlobalContext.instance = GlobalContext()
        }
        return GlobalContext.instance()
    }

    /**
     * 获取上下文对象
     */
    public func getAbilityContext(): ?AbilityContext {
        return this._objects.get("context")
    }

    /**
     * 设置上下文对象
     */
    public func setAbilityContext(objectClass: AbilityContext): Unit {
        this._objects.put("context", objectClass)
    }
}
