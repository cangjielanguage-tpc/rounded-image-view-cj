/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class MyView {
    func build() {
        Column {
            Text("测试页面")
                // 宽度
                .width(100.percent)
                // 文本颜色
                .fontColor(0x000000)
                // 背景颜色
                .backgroundColor(0xFFFFFF)
                // 字体大小
                .fontSize(25)
            Divider()
                // 分割线颜色
                .color(0x000000)
                // 分割线高度
                .strokeWidth(1)
                // 内边距属性
                .margin(top: 10, bottom: 10)
            Scroll() {
                Column {
                    Button("跳转bitmap")
                        // 高度
                        .height(40)
                        // 宽度
                        .width(80.percent)
                        // 圆角
                        .shape(ShapeType.Capsule)
                        // 文本颜色
                        .fontColor(0xFFFFFF)
                        // 背景颜色
                        .backgroundColor(0xFF0000)
                        // 内边距
                        .padding(5)
                        // 内容对齐方式
                        .align(Alignment.Center)
                        // 外边距
                        .margin(5)
                        // 字体大小
                        .fontSize(10)
                        // 点击动作触发该方法调用
                        .onClick {Router.push(url: "TestBitmap")}
                    Button("跳转ovals")
                        // 高度
                        .height(40)
                        // 宽度
                        .width(80.percent)
                        // 圆角
                        .shape(ShapeType.Capsule)
                        // 文本颜色
                        .fontColor(0xFFFFFF)
                        // 背景颜色
                        .backgroundColor(0xFF0000)
                        // 内边距
                        .padding(5)
                        // 内容对齐方式
                        .align(Alignment.Center)
                        // 外边距
                        .margin(5)
                        // 字体大小
                        .fontSize(10)
                        // 点击动作触发该方法调用
                        .onClick {Router.push(url: "TestOvals")}
                    Button("跳转color")
                        // 高度
                        .height(40)
                        // 宽度
                        .width(80.percent)
                        // 圆角
                        .shape(ShapeType.Capsule)
                        // 文本颜色
                        .fontColor(0xFFFFFF)
                        // 背景颜色
                        .backgroundColor(0xFF0000)
                        // 内边距
                        .padding(5)
                        // 内容对齐方式
                        .align(Alignment.Center)
                        // 外边距
                        .margin(5)
                        // 字体大小
                        .fontSize(10)
                        // 点击动作触发该方法调用
                        .onClick {Router.push(url: "TestColor")}
                    Button("跳转background")
                        // 高度
                        .height(40)
                        // 宽度
                        .width(80.percent)
                        // 圆角
                        .shape(ShapeType.Capsule)
                        // 文本颜色
                        .fontColor(0xFFFFFF)
                        // 背景颜色
                        .backgroundColor(0xFF0000)
                        // 内边距
                        .padding(5)
                        // 内容对齐方式
                        .align(Alignment.Center)
                        // 外边距
                        .margin(5)
                        // 字体大小
                        .fontSize(10)
                        // 点击动作触发该方法调用
                        .onClick {Router.push(url: "TestBackground")}
                    Button("跳转SVG")
                        // 高度
                        .height(40)
                        // 宽度
                        .width(80.percent)
                        // 圆角
                        .shape(ShapeType.Capsule)
                        // 文本颜色
                        .fontColor(0xFFFFFF)
                        // 背景颜色
                        .backgroundColor(0xFF0000)
                        // 内边距
                        .padding(5)
                        // 内容对齐方式
                        .align(Alignment.Center)
                        // 外边距
                        .margin(5)
                        // 字体大小
                        .fontSize(10)
                        // 点击动作触发该方法调用
                        .onClick {Router.push(url: "TestSVG")}
                    Text("")
                        // 高度
                        .height(300)
                }
                .width(100.percent)
            }
            .scrollable(ScrollDirection.Vertical)
        }
    }
}
