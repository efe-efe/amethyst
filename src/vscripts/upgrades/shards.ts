import { Upgrade } from "./common";

import JuggernautRewards from "./juggernaut";
import PhantomRewards from "./phantom";
import StormRewards from "./storm";
import SniperRewards from "./sniper";

const Shards: Upgrade[] = [
  ...JuggernautRewards.Shards,
  ...PhantomRewards.Shards,
  ...StormRewards.Shards,
  ...SniperRewards.Shards,
];

export default Shards;
