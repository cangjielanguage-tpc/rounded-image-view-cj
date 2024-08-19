/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class TestSVG {
    private let picIdxArr: ArrayList<Int64> = ArrayList<Int64>(0, 1, 2, 3, 4, 5, 6)
    private var viewModels: ArrayList<RoundedImageNameModel> = ArrayList<RoundedImageNameModel>()
    let screenWidth: Int32 = getDefaultDisplaySync().width
    let widthPx: Float64 = Float64(screenWidth) * 0.95
    let widthLength: Length = widthPx.px
    private let uiWidth: Float64 = px2vp(widthLength).getOrThrow().value
    private let uiHeight: Float64 = 200.0
    private let scroller: Scroller = Scroller()
    var typeValue: String = "SVG"
    private let svgItems: ArrayList<PictureItem> = ArrayList<PictureItem>(
        PictureItem(
            srcResource: @r(app.media.ic_svg),
            srcType: SrcType.MEDIA,
            isSvg: true,
            primaryTitle: "SVG",
            secondTitle: "",
            scaleTypeName: "CENTER",
            scaleType: ScaleType.CENTER,
            uiWidth: this.uiWidth,
            uiHeight: this.uiHeight,
            cornerRadius: 25.0,
            borderWidth: 10.0,
            borderColor: Color(0x317AF7),
            padding: 0.0
        ),
        PictureItem(
            srcResource: @r(app.media.ic_svg),
            srcType: SrcType.MEDIA,
            isSvg: true,
            primaryTitle: "SVG",
            secondTitle: "",
            scaleTypeName: "CENTER_CROP",
            scaleType: ScaleType.CENTER_CROP,
            uiWidth: this.uiWidth,
            uiHeight: this.uiHeight,
            cornerRadius: 25.0,
            borderWidth: 10.0,
            borderColor: Color(0x317AF7),
            padding: 0.0
        ),
        PictureItem(
            srcResource: @r(app.media.ic_svg),
            srcType: SrcType.MEDIA,
            isSvg: true,
            primaryTitle: "SVG",
            secondTitle: "",
            scaleTypeName: "CENTER_INSIDE",
            scaleType: ScaleType.CENTER_INSIDE,
            uiWidth: this.uiWidth,
            uiHeight: this.uiHeight,
            cornerRadius: 25.0,
            borderWidth: 10.0,
            borderColor: Color(0x317AF7),
            padding: 0.0
        ),
        PictureItem(
            src: "ic_svg.svg",
            srcType: SrcType.RAWFILE,
            isSvg: true,
            primaryTitle: "SVG",
            secondTitle: "",
            scaleTypeName: "FIT_CENTER",
            scaleType: ScaleType.FIT_CENTER,
            uiWidth: this.uiWidth,
            uiHeight: this.uiHeight,
            cornerRadius: 25.0,
            borderWidth: 10.0,
            borderColor: Color(0x317AF7),
            padding: 0.0
        ),
        PictureItem(
            src: "ic_svg.svg",
            srcType: SrcType.RAWFILE,
            isSvg: true,
            primaryTitle: "SVG",
            secondTitle: "",
            scaleTypeName: "FIT_END",
            scaleType: ScaleType.FIT_END,
            uiWidth: this.uiWidth,
            uiHeight: this.uiHeight,
            cornerRadius: 25.0,
            borderWidth: 10.0,
            borderColor: Color(0x317AF7),
            padding: 0.0
        ),
        PictureItem(
            src: "ic_svg.svg",
            srcType: SrcType.RAWFILE,
            isSvg: true,
            primaryTitle: "SVG",
            secondTitle: "",
            scaleTypeName: "FIT_START",
            scaleType: ScaleType.FIT_START,
            uiWidth: this.uiWidth,
            uiHeight: this.uiHeight,
            cornerRadius: 25.0,
            borderWidth: 10.0,
            borderColor: Color(0x317AF7),
            padding: 0.0
        ),
        PictureItem(
            src: "ic_svg.svg",
            srcType: SrcType.RAWFILE,
            isSvg: true,
            primaryTitle: "SVG",
            secondTitle: "",
            scaleTypeName: "FIT_XY",
            scaleType: ScaleType.FIT_XY,
            uiWidth: this.uiWidth,
            uiHeight: this.uiHeight,
            cornerRadius: 25.0,
            borderWidth: 10.0,
            borderColor: Color(0x317AF7),
            padding: 0.0
        )
    )

    protected override func onAppear() {
        initViewModels()
        updateViewModels(svgItems)
    }

    private func initViewModels(): Unit {
        for (index in 0..picIdxArr.size) {
            viewModels.append(RoundedImageNameModel())
        }
    }

    private func updateViewModels(pictureItem: ArrayList<PictureItem>) {
        for (idx in 0..pictureItem.size) {
            viewModels[idx].setImageSrc(pictureItem[idx].src).setImageSrc(pictureItem[idx].srcArray).setImageSrc(
                pictureItem[idx].srcResource).setBackgroundColor(pictureItem[idx].backgroundColor).setBackgroundColor(
                pictureItem[idx].backgroundColorUInt32).setBackgroundColor(
                pictureItem[idx].backgroundColorCanvasGradient).setSrcType(pictureItem[idx].srcType).setIsSvg(
                pictureItem[idx].isSvg).setTypeValue(typeValue).setUiWidth(pictureItem[idx].uiWidth).setUiHeight(
                pictureItem[idx].uiHeight).setScaleType(pictureItem[idx].scaleType).setTileModeXY(
                pictureItem[idx].tileMode).setCornerRadius(pictureItem[idx].cornerRadius).setBorderWidth(
                pictureItem[idx].borderWidth).setBorderColor(pictureItem[idx].borderColor).setBorderColor(
                pictureItem[idx].borderColorUInt32).setBorderColor(pictureItem[idx].borderColorCanvasGradient).
                setPadding(pictureItem[idx].padding).setColorWidth(uiHeight).setColorHeight(uiHeight).setContext(
                getGlobalAbilityContext())
        }
    }

    func build() {
        Scroll(scroller) {
            List() {
                ForEach(
                    picIdxArr,
                    itemGeneratorFunc: {
                        item: Int64, idx: Int64 => ListItem() {
                            viewItem(viewModels[item], svgItems[item])
                        }.editable(false)
                    }
                )
            }
        }
    }

    @Builder
    func viewItem(roundedImageViewModel: RoundedImageNameModel, pictureItem: PictureItem) {
        Column(5) {
            RoundedImageView(model: roundedImageViewModel)
            Column() {
                Text(pictureItem.primaryTitle).height(35).fontColor(0xFAFAFA).backgroundColor(0x7f000000).fontSize(18).
                    position(x: 20, y: 40)
                Text(pictureItem.secondTitle).height(20).fontColor(0xFAFAFA).backgroundColor(0x7f000000).fontSize(16).
                    position(x: 20, y: 90)
                Text(pictureItem.scaleTypeName).height(20).fontColor(0xFAFAFA).backgroundColor(0x7f000000).fontSize(14).
                    position(x: 20, y: 120)
            }
        }.width(100.percent)
    }
}
