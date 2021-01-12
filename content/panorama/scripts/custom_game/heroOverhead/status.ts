import ProgressBar from '../progressBar';
import { modifiers, panels } from '../shared/util';


export enum StatusTrigger {
    STATUS_TRIGGER_DURATION = 1,
    STATUS_TRIGGER_STACKS
}

export enum StatusContent {
    STATUS_CONTENT_CLEAROUT = 1,
    STATUS_CONTENT_FILLUP
}

export default class Status{
    panel: Panel;
    entityIndex: EntityIndex;

    trigger: StatusTrigger | undefined;
    modifierName: string | undefined;
    maxStacks: number | undefined;
    content: StatusContent | undefined;
    style: string | undefined;

    textPanel: LabelPanel;
    textGlowPanel: LabelPanel;
    progressBar: ProgressBar;

    constructor(container: Panel, entityIndex: EntityIndex){
        this.panel = panels.createPanelSimple(container, 'status');
        this.entityIndex = entityIndex;

        const topPanel = panels.createPanelSimple(this.panel, 'status__top');
        const botPanel = panels.createPanelSimple(this.panel, 'status__bot');
        this.textGlowPanel = panels.createPanelSimple(topPanel, 'status__text status__text--glow', 'Label') as LabelPanel;
        this.textPanel = panels.createPanelSimple(topPanel, 'status__text', 'Label') as LabelPanel;

        this.progressBar = new ProgressBar('status__progress-bar' , botPanel, {
            background_color: 'rgba(0, 0, 0, 0.9)'
        });

        this.SetText('Status');
    }

    SetText(text: string): void{
        this.textGlowPanel.text = text.toUpperCase();
        this.textPanel.text = text.toUpperCase();
    }

    Activate(text: string, style: string, trigger: StatusTrigger, modifierName: string, maxStacks?: number, content?: StatusContent): void{
        this.modifierName = modifierName;
        this.trigger = trigger;
        this.maxStacks = maxStacks;
        this.style = style;
        this.content = content;

        this.SetText(text);
        this.Update();
    }

    Deactivate(): void{
        this.modifierName = undefined;
        this.trigger = undefined;
        this.maxStacks = undefined;
        this.style = undefined;
        
        this.SetText('Status');
    }

    Update(): void{
        if(!this.modifierName){
            return;
        } else {
            let modifierIndex = modifiers.findModifierByName(this.entityIndex, this.modifierName);
    
            if(modifierIndex){
                modifierIndex = modifierIndex as BuffID;

                const progressRatio = this.GetProgressRatio(this.entityIndex, modifierIndex, this.content!, this.trigger!, this.maxStacks);
                this.progressBar.SetProgress(progressRatio * 100);
    
                const style = styles[this.style!] && styles[this.style!] || styles['Generic'];
                this.progressBar.SetForegroundColor(style.backgroundColor || '#FAFAFA');
                
                this.textGlowPanel.style.textShadow = style.textShadow || 'none';
                this.textPanel.style.color = style.color || '#FAFAFA';
            }
    
            $.Schedule(0.03, () => {
                this.Update();
            });
        }
    }   

    GetPanel(): Panel{
        return this.panel;
    }

    GetProgressRatio(entityIndex: EntityIndex, modifierIndex: BuffID, content: StatusContent, trigger: StatusTrigger, maxStacks?: number): number{
        let progressRatio = 1;

        if(trigger == StatusTrigger.STATUS_TRIGGER_DURATION){
            const duration = Buffs.GetDuration(entityIndex, modifierIndex);
            const remaining = Buffs.GetRemainingTime(entityIndex, modifierIndex);
            if (remaining && duration){ progressRatio = remaining/duration; }
            if (isNaN(progressRatio)){ progressRatio = 1; }
            if (content == StatusContent.STATUS_CONTENT_FILLUP){progressRatio = 1 - progressRatio;}
        } else if (trigger == StatusTrigger.STATUS_TRIGGER_STACKS) {
            const stacks = (Buffs.GetStackCount(entityIndex, modifierIndex)||0);
            if (maxStacks) { progressRatio = stacks/maxStacks; }
            if (isNaN(progressRatio)) { progressRatio = 1; }
            if (content == StatusContent.STATUS_CONTENT_FILLUP){progressRatio = 1 - progressRatio;}
        }
        
        return progressRatio;
    }
}

const SKY_BLUE = '#84f4eb';
const LIGHT_GREEN = '#b2f7bd';
const PURPLE = '#C655C4';
const BLUE = '#3b55ed';
const LIGHT_BLUE = '#81c3f9';
const RED = '#ed4747';
const ORANGE = '#E55C34';

const styles: {[key: string]: {
    backgroundColor: string;
    textShadow?: string;
    color?: string;
}} = {};

styles['Generic'] = {       backgroundColor: '#F5E767', textShadow: CreateTextShadow('#F5E767'), };
styles['Heal'] = {          backgroundColor: LIGHT_GREEN, color: LIGHT_GREEN, };
styles['Mana'] = {          backgroundColor: LIGHT_BLUE, color: LIGHT_BLUE, };
styles['Ultimate'] = {      backgroundColor: '#F5E767', textShadow: CreateTextShadow('#F5E767'), };
styles['Recast'] = {        backgroundColor: '#ADC6DE', textShadow: CreateTextShadow('#ADC6DE'), };
styles['Silence'] = {       backgroundColor: '#C5FAFF', textShadow: CreateTextShadow('#FFBF20'), };
styles['Adrenaline'] = {    backgroundColor: '#CEDCFF', color: '#CEDCFF' };
styles['Shield'] = {        backgroundColor: '#E8C070', };
styles['Counter'] = {       backgroundColor: '#9DBDEC', textShadow: CreateTextShadow('#9DBDEC'), };
styles['Stun'] = {          backgroundColor: '#ABD5FF', textShadow: CreateTextShadow('#ABD5FF'), };
styles['Slow'] = {          backgroundColor: '#C2AB71', color: '#C2AB71' };
styles['Root'] = {          backgroundColor: '#94A551', textShadow: CreateTextShadow('#94A551'), };
styles['Channeling'] = {    backgroundColor: '#F5E767', };
styles['Invisible'] = {     backgroundColor: '#AEB3A3', color: '#AEB3A3', };
styles['BladeFury'] = {     backgroundColor: ORANGE, textShadow: CreateTextShadow('#DC8668'), color: '#FFF5D7', };
styles['Mekansm'] = {       backgroundColor: SKY_BLUE, };
styles['Meteor'] = {        backgroundColor: SKY_BLUE, color: '#DC8668', };
styles['Nullify'] = {       backgroundColor: PURPLE, textShadow: CreateTextShadow(PURPLE), };
styles['Swiftness'] = {     backgroundColor: LIGHT_GREEN, color: LIGHT_GREEN};
styles['Inhibit'] = {       backgroundColor: BLUE, textShadow: CreateTextShadow(BLUE) };
styles['Sacrifice'] = {     backgroundColor: LIGHT_BLUE, textShadow: CreateTextShadow(RED), };
styles['Flutter'] = {       backgroundColor: LIGHT_GREEN, textShadow: CreateTextShadow(LIGHT_GREEN), };
styles['Fear'] = {          backgroundColor: ORANGE, textShadow: CreateTextShadow('#DC8668'), color: '#DC8668' };
styles['PhaseShift'] = {    backgroundColor: LIGHT_BLUE, textShadow: CreateTextShadow(LIGHT_BLUE) };
styles['SpellBlock'] = {    backgroundColor: LIGHT_BLUE, textShadow: CreateTextShadow(RED) };
styles['FairyDust'] = {     backgroundColor: PURPLE, textShadow: CreateTextShadow(LIGHT_BLUE) };
styles['Desolate'] = {      backgroundColor: '#C655C4', color: '#C655C4' };
styles['DancingBlades'] = { backgroundColor: '#DC8668', color: '#DC8668' };
styles['Raze'] = {          backgroundColor: ORANGE, textShadow: CreateTextShadow('#DC8668'), color: '#E8C070' };
styles['Desolation'] = {    backgroundColor: '#E55C34', textShadow: CreateTextShadow('#DC8668'), color: '#E8C070' };
styles['StormUnleashed'] = {backgroundColor: BLUE, textShadow: CreateTextShadow(LIGHT_BLUE), color: SKY_BLUE };
styles['Bleeding'] = {      backgroundColor: ORANGE, textShadow: CreateTextShadow(PURPLE), color: RED };
styles['Revenant'] = {      backgroundColor: ORANGE, textShadow: CreateTextShadow(PURPLE), color: RED };
styles['Ruby'] = {      backgroundColor: ORANGE, textShadow: CreateTextShadow(ORANGE), color: RED };
styles['Darkness'] = {      backgroundColor: '#DC8668', color: '#DC8668'};
styles['Sleep'] = {         backgroundColor: '#CB8CFF', textShadow: CreateTextShadow('#CB8CFF'),};

function CreateTextShadow(color: string){
    return '0px 0px 30px 8.0 ' + color + ';';
}