/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*


/**
 * 读取路径下文件夹
 */
func getFileListStr(str: String): Array<String> {
    let resourceManager = ResourceManager.getResourceManager(getStageContext(getGlobalAbilityContext()))
    try {
        return resourceManager.getRawFileList(str)
    } catch (e: Exception) {
        return Array<String>()
    }
}

/**
 * 读取路径下文件内容
 */
func getFileContextStr(str: String): String {
    let resourceManager = ResourceManager.getResourceManager(getStageContext(getGlobalAbilityContext()))
    try {
        return String.fromUtf8(resourceManager.getRawFileContent(str))
    } catch (e: Exception) {
        return ""
    }
}