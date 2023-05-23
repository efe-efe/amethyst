import { BaseAbility } from "../../lib/dota_ts_adapter";

export class CustomAbility extends BaseAbility {
    caster = this.GetCaster();
}
