import { registerAbility } from "../../../lib/dota_ts_adapter";
import { InvokerOrb } from "./invoker_helper";

@registerAbility("invoker_counter")
class InvokerCounter extends InvokerOrb {}
