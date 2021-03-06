import { create } from 'domain';
import { ModifierLocalization } from '../localizationInterfaces';

type KeywordOptions = { name: string, description: string, iconPath: string, color: string, function?: boolean };
type KeywordDefinitionOptions = { name: string, description: string, iconPath: string, color: string, function?: boolean };
type KeywordInstanceOptions = { name: string, iconPath: string, color: string, function?: boolean};

export interface Upgrade {
    id: string;
    name: string;
    description: string;
    hero?: string;
    ability?: string;
    attackCapability?: any;
    maxStacks: number;
    modifier?: any;
    tier: number;
    minLevel?: number;
    effect?(hero: any): void;
    type: UpgradeTypes;
    abilityIconName?: string;
    secondaryAbilities?: string[];
}

export const Upgrades = (upgrades: any[]) => {
    return upgrades.map((upgrade) => {
        return {
            modifier_classname: upgrade.modifier!.name,
            name: upgrade.name,
            description: upgrade.description,
        };
    });
};

export enum UpgradeTypes {
    FAVOR = 0,
    SHARD,
    ITEM,
}

export const Description = (data: {
    description: string,
    channeled?: boolean,
    level?: string, 
    subAbility?: { 
        name: string, 
        iconPath: string, 
        description: string 
    } 
}): string => {
    let output = '';
    
    if(data.channeled){
        output = output + '<img src="file://{images}/custom_game/clock.png" /> <b><font color="gold">CHANNELED</font></b> - '; 
    }

    output = output + data.description;

    if(data.level){
        output = output + '<br><br><b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b> <font color="gray">(PVP ONLY)</font><br>' + data.level;
    }
    if(data.subAbility){
        output = output + '<br><br><img src="file://{images}/custom_game/' + data.subAbility.iconPath + '" /> <b><font color="#ffffff">' + data.subAbility.name.toUpperCase() + '</font></b><br>' + data.subAbility.description;
    }
    return output;
};

export const Ability = (name: string, iconPath: string): string => {
    return '<img src="file://{images}/custom_game/' + iconPath + '" /> <b><font color="#ffffff">' + name + '</font></b>';
};

const createKeywordDefinition = (options: KeywordDefinitionOptions) => {
    let name = options.name.toUpperCase(); 
    if(options.function){
        name =  name + ' (X)';
    }

    return '<img src="file://{images}/custom_game/' + options.iconPath + '" /><b><font color="' + options.color + '"> '+ name + ': </font><font color="#B2B5B3">' + options.description + '</font></b>';
};

const keywordInstanceFactory = (options: KeywordInstanceOptions): string | any => {
    return (value?: string) => {
        if(value){
            return '<img src="file://{images}/custom_game/' + options.iconPath + '" /><b><font color="' + options.color + '">' + options.name + ' (' + value + ')</font></b>';
        }
        return '<img src="file://{images}/custom_game/' + options.iconPath + '" /><b><font color="' + options.color + '">' + options.name + '</font></b>';
    };
};

const createKeyword = (options: KeywordOptions) => {
    return {
        definition: createKeywordDefinition(options),
        instance: keywordInstanceFactory(options),
    };
};

export const multipleKeywords = (keywords: string[]): string => {
    let output = '';

    keywords.forEach((keyword, i) => {
        output = output + keyword;
        if(i !== keywords.length - 1){
            output = output + '<br><br>';
        }
    });

    return output;
};


export const Keywords = {
    FairyDust: createKeyword({
        name: 'Fairy Dust',
        description: 'Reduces the target movement speed by X percent and adds extra effects to <img src="file://{images}/custom_game/puck_second_attack.png" /> <b>Lightining Orb.',
        iconPath: 'fairy_dust.png',
        color: '#C5FAFF',
        function: true,
    }),
    Silence: createKeyword({
        name: 'Silence',
        description: 'Target is unable to use abilities.',
        iconPath: 'silence.png',
        color: '#C5FAFF'
    }),
    Stun: createKeyword({
        name: 'Stun',
        description: 'Target is unable to move and use abilities.',
        iconPath: 'stun.png',
        color: '#ffffff'
    }),
    SpellBlock: createKeyword({
        name: 'Spell Block',
        description: 'If affected unit cast any spell, it recives Silence for X seconds.',
        iconPath: 'spell_block.png',
        color: '#ed4747',
        function: true,
    }),
    FadingSlow: createKeyword({
        name: 'Fading Slow',
        description: 'Reduce movement speed by X percent. The effect decays linearly over time, gradually restoring the target\'s speed over the duration of this debuff.',
        iconPath: 'fading_slow.png',
        color: '#FFC1AA',
        function: true,
    }),
    Fear: createKeyword({
        name: 'Fear',
        description: 'The target runs uncontrollably in the opposite direction to the cause of fear.',
        iconPath: 'fear.png',
        color: '#DC8668'
    }),
    Sleep: createKeyword({
        name: 'Sleep',
        description: 'Target is unable to act. Any damage received will break this state.',
        iconPath: 'sleep.png',
        color: '#CB8CFF'
    }),
    PhantomStack: createKeyword({
        name: 'Phantom Stack',
        description: 'Extra effects on ' + Ability('Critical Strike', 'phantom_second_attack.png') + ', ' + Ability('Coup De Grace', 'phantom_ultimate.png') + ', and ' + Ability('Blur Strike', 'phantom_ex_counter.png') + '.',
        iconPath: 'phantom_stack.png',
        color: '#ff8da1',
    }),
    FuryStack: createKeyword({
        name: 'Fury Stack',
        description: 'Extra effects on ' + Ability('Blade Dance', 'juggernaut_second_attack.png') + ', ' + Ability('Omnislash', 'juggernaut_ultimate.png') + ' and ' + Ability('Weakspot', 'juggernaut_ex_second_attack.png') + '.',
        iconPath: 'fury_stack.png',
        color: '#FFB556',
    }),
    Swiftness: createKeyword({
        name: 'Swiftness',
        description: 'Increases the movement speed by X% with a max of 100% and gives the ability to pass through units. If applied when already active, the speed bonuses are added.',
        iconPath: 'swiftness.png',
        color: '#b2f7bd',
    }),
    Desolate: createKeyword({
        name: 'Desolate',
        description: 'Adds extra effects on ' + Ability('Void Strike', 'spectre_basic_attack.png') + '.',
        iconPath: 'desolate.png',
        color: '#9C24A0',
    }),
    Channeling: createKeyword({
        name: 'Channeled',
        description: 'Caster stops acting for the duration of this ability. This ability ends when the caster takes another action or is interrupted by another ability.',
        iconPath: 'clock.png',
        color: '#FBDE39',
    }),
    Root: createKeyword({
        name: 'Root',
        description: 'Target is unable to move.',
        iconPath: 'root.png',
        color: '#94A551',
    }),
    Bleeding: createKeyword({
        name: 'Bleeding',
        description: 'Deals 1 damage per stack every 1.0s. Can be stacked up to 3 times. The duration is refreshed every time is reapplied.',
        iconPath: 'bleeding.png',
        color: '#ed4747',
    }),
    BaseDamage: '<b><font color="#ffffff">base damage</font></b>' 
};