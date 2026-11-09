package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

public var globalAbilityContext: ?UIAbilityContext = None

class MainAbility <: UIAbility {
    public init() {
        super()
        registerSelf()
    }

    public override func onCreate(want: Want, launchParam: LaunchParam): Unit {
        globalAbilityContext = context
        GlobalContext.getContext().setUIAbilityContext(globalAbilityContext.getOrThrow())
        Hilog.info(0, "MainAbility", "MainAbility OnCreated.${want.abilityName}")
        match (launchParam.launchReason) {
            case LaunchReason.START_ABILITY => Hilog.info(0, "MainAbility", "START_ABILITY")
            case _ => ()
        }
    }

    public override func onWindowStageCreate(windowStage: WindowStage): Unit {
        Hilog.info(0, "MainAbility", "MainAbility onWindowStageCreate.")
        windowStage.loadContent("MyView")
    }
}

public func getGlobalAbilityContext(): UIAbilityContext {
    globalAbilityContext.getOrThrow()
}
