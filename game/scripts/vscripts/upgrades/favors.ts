import { Upgrade } from './common';

import JuggernautRewards from './juggernaut';
import PhantomRewards from './phantom';
import StormRewards from './storm';

const Favors: Upgrade[] = [
    ...JuggernautRewards.Favors,
    ...PhantomRewards.Favors,
    ...StormRewards.Favors,
];

export default Favors;