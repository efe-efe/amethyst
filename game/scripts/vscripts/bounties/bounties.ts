export interface Bounty {
    id: string;
    name: string;
    description: string;
}

const Bounties: Bounty[] = [
    {
        id: 'bounty_upgrades',
        name: 'Upgrades',
        description: 'Upgrades one of your abilities.',
    },
    {
        id: 'bounty_improvements',
        name: 'Improvements',
        description: 'Improves one of your existing upgrades.',
    },
    {
        id: 'bounty_regenerate',
        name: 'Regenerate',
        description: 'Fully restores all your HP.',
    },/*
    {
        id: 'bounty_shop',
        name: 'Shop',
        description: 'Spawns a shop where you can buy goods.',
    },
    {
        id: 'bounty_money',
        name: 'Money',
        description: 'You get money to buy things and stuff.',
    }*/
];

export default Bounties;