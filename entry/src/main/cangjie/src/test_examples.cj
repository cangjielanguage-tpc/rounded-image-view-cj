/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class TestExamples {
    func build() {
        Scroll() {
            RoundedImageView(model: getRoundedImageViewModel())
        }
    }

    func getRoundedImageViewModel(): RoundedImageNameModel {
        let roundedImageNameModel: RoundedImageNameModel = RoundedImageNameModel()
            // 设置图片
            .setImageSrc(@r(app.media.photo1))
            // 设置背景颜色
            .setBackgroundColor(Color(0x55AA66))
            // 设置图片类型
            .setSrcType(SrcType.MEDIA)
            // 图片是不是SVG图片
            .setIsSvg(false)
            // 显示类型
            .setTypeValue("Bitmap")
            // 设置图片显示的宽度
            .setUiWidth(100.0)
            // 设置图片显示的高度
            .setUiHeight(100.0)
            // 设置图片缩放类型
            .setScaleType(ScaleType.CENTER)
            // 设置图片的重复样式
            .setTileModeXY(TileMode.REPEAT)
            // 设置角半径
            .setCornerRadius(10.0)
            // 设置边框线宽
            .setBorderWidth(5.0)
            // 设置边框线颜色
            .setBorderColor(Color(0x317AF7))
            // 设置图片内边距
            .setPadding(0.0)
            // 颜色宽度
            .setColorWidth(100.0)
            // 颜色高度
            .setColorHeight(100.0)
            // 设置上下文
            .setContext(getGlobalAbilityContext())
        return roundedImageNameModel
    }
}
