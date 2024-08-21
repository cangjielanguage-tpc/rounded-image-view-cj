<div align="center">
<h1>roundedImageView4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.53.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-NA-red" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

roundedImageView4cj支持圆角（和椭圆或圆形）的快速 ImageView。

它支持许多附加功能，包括椭圆、圆角矩形、ScaleTypes 和 TileModes。

### 特性

1. 支持图片显示为圆角矩形并带边框
2. 支持图片显示为椭圆并带边框
3. 支持Color类型显示并带边框
4. 支持Background类型显示并带边框
5. 支持svg图片显示并带边框
6. 支持设置ScaleType七种缩放类型
7. 支持设置TileMode三种背景平铺类型
8. 支持路径uri、media、本地rawfile、网络url等相关数据绘制

## 软件架构

### 源码目录

```shell
├─AppScope
├─doc
├─entry
│  └─src
│      └─main
│          ├─cangjie
│          └─resources
├─roundedimageview
│  └─src
│      └─main
│          ├─cangjie
│          │  └─src
│          └─resources
└─hvigor

```

- `AppScope` 全局资源存放目录和应用全局信息配置目录
- `doc` API文档和使用手册存放目录
- `entry` 工程模块 - 编译生成一个HAP
- `entry src` APP代码目录
- `entry src main` APP项目目录
- `entry src main cangjie` 仓颉代码目录
- `entry src main resources` 资源文件目录
- `roundedimageview` 工程模块 - 编译生成一个har包
- `roundedimageview src` 模块代码目录
- `roundedimageview src main` 模块项目目录
- `roundedimageview src main cangjie` 仓颉代码目录
- `roundedimageview src main resources` 资源文件目录
- `hvigor` 构建工具目录

### 接口说明

主要类和函数接口说明详见 [API](doc/API.md)

## 使用说明

### 编译构建

1. 通过module引入
    1. 克隆下载项目
    2. 将roundedimageview模块拷贝到应用项目下
    3. 修改自身应用 entry 下的 oh-package.json5 文件，在 dependencies 字段添加 "roundedimageview": "file:../roundedimageview"
       ```json
       {
          "name": "entry",
          "version": "1.0.0",
          "description": "Please describe the basic information.",
          "main": "",
          "author": "",
          "license": "",
         "dependencies": {
             "roundedimageview": "file:../roundedimageview"
         }
       }
       ```
    4. 修改自身应用 entry/src/main/cangjie 下的 cjpm.toml 文件，在 [dependencies] 字段下添加 roundedimageview = {path = "../../../../roundedimageview/src/main/cangjie", version = "1.0.0"}
       ```toml
       [dependencies]
           roundedimageview = {path = "../../../../roundedimageview/src/main/cangjie", version = "1.0.0"}
       ```
    5. 在项目中使用 import roundedimageview.* 引用roundedimageview项目
       ```cangjie
       import roundedimageview.*
       ```

### 功能示例

```cangjie

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
```

### 预览效果

<img src="./doc/image/image_bitmap.jpeg" width="50%"/>

<img src="./doc/image/image_ovals.jpeg" width="50%"/>

<img src="./doc/image/image_color.jpeg" width="50%"/>

<img src="./doc/image/image_background.jpeg" width="50%"/>

## 约束与限制

当前基于 deveco-studio-5.0.3.600 版本实现的

## 开源协议

本项目基于 [Apache License 2.0](./LICENSE) ，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。