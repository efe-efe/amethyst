import { panels } from '../util';
export default class Recast {
    constructor(container) {
        this.panel = panels.createPanelSimple(container, 'recast');
        this.imagePanel = panels.createPanelSimple(this.panel, 'recast__image', 'DOTAAbilityImage');
        this.textPanel = panels.createPanelSimple(this.panel, 'recast__text', 'Label');
        this.imagePanel.abilityname = '';
        this.textPanel.text = 'Hello';
        this.Deactivate();
    }
    Deactivate() {
        this.panel.SetHasClass('recast--deactivated', true);
    }
    Activate(abilityName, key) {
        this.imagePanel.abilityname = abilityName;
        this.textPanel.text = key;
        this.panel.SetHasClass('recast--deactivated', false);
    }
}
