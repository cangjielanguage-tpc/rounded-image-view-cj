package ohos_app_cangjie_entry

class MyAbilityStage <: AbilityStage {
    public override func onCreate(): Unit {
        Hilog.info(0, "MyAbilityStage", "MyAbilityStage onCreated.")
    }
}
