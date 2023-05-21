import { CustomItems } from "../util/custom_items";

const customItems = CustomItems.GetInstance();

export default class Item {
  item: CDOTA_Item | undefined;
  picked = false;

  SetItem(item: CDOTA_Item): void {
    this.item = item;
    customItems.AddItem(this);
  }

  GetItem(): CDOTA_Item | undefined {
    return this.item;
  }

  OnPickedUp(): void {
    UTIL_Remove(this.GetItem()); //otherwise it pollutes the player inventory
    this.picked = true;
  }

  Alive(): boolean {
    return !this.picked;
  }
}
