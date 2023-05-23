import Item from "../clases/Item";

export class CustomItems {
    private static instance: CustomItems;
    private items: Item[] = [];

    private constructor() {
        //Singleton initialization
    }

    public static GetInstance(): CustomItems {
        if (!CustomItems.instance) {
            CustomItems.instance = new CustomItems();
        }

        return CustomItems.instance;
    }

    GetParent(item: CDOTA_Item): Item | undefined {
        return this.items.filter(_item => _item.GetItem() === item)[0];
    }

    AddItem(item: Item): void {
        this.items.push(item);
    }
}
