import { Upgrade } from "./common";

import JuggernautRewards from "./juggernaut";
import PhantomRewards from "./phantom";
import StormRewards from "./storm";
import SniperRewards from "./sniper";

const Favors: Upgrade[] = [
    ...JuggernautRewards.Favors,
    ...PhantomRewards.Favors,
    ...StormRewards.Favors,
    ...SniperRewards.Favors,
];

export default Favors;