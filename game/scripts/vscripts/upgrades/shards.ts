import { Upgrade } from './common';

import JuggernautRewards from './juggernaut';
import PhantomRewards from './phantom';
import StormRewards from './storm';

const Shards: Upgrade[] = [
    ...JuggernautRewards.Shards,
    ...PhantomRewards.Shards,
    ...StormRewards.Shards,
];

export default Shards;