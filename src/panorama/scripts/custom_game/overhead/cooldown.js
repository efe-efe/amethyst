import { modifiers, panels } from '../util';
export default class Cooldown {
    constructor(container, entityIndex, modifierName) {
        this.panel = panels.createPanelSimple(container, 'cooldown');
        this.entityIndex = entityIndex;
        this.modifierName = modifierName;
        this.backgroundPanel = panels.createPanelSimple(this.panel, 'cooldown__background');
        this.foregroundPanel = panels.createPanelSimple(this.panel, 'cooldown__foreground');
        this.Update();
    }
    Update() {
        let modifierIndex = modifiers.findModifierByName(this.entityIndex, this.modifierName);
        if (modifierIndex) {
            modifierIndex = modifierIndex;
            const duration = Buffs.GetDuration(this.entityIndex, modifierIndex);
            if (duration == -1) {
                this.foregroundPanel.style.clip = 'radial(50% 50%, 0deg, ' + 360 + 'deg)';
                this.foregroundPanel.style.backgroundColor = 'rgb(162, 249, 154)';
                $.Schedule(0.03, () => {
                    this.Update();
                });
                return;
            }
            const remaining = Buffs.GetRemainingTime(this.entityIndex, modifierIndex);
            let progressRatio = 1;
            if (remaining && duration) {
                progressRatio = remaining / duration;
            }
            if (isNaN(progressRatio)) {
                progressRatio = 1;
            }
            progressRatio = 1 - progressRatio;
            const degree = 360 * progressRatio;
            this.foregroundPanel.style.clip = 'radial(50% 50%, 0deg, ' + degree + 'deg)';
            this.foregroundPanel.style.backgroundColor = 'rgb(238, 53, 0)';
            if (degree == 360) {
                this.foregroundPanel.style.backgroundColor = 'rgb(162, 249, 154)';
            }
        }
        $.Schedule(0.03, () => {
            this.Update();
        });
    }
    GetPanel() {
        return this.panel;
    }
}
