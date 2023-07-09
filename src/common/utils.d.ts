type ConstructTag<Value, TagName extends string, TagType> = {
    [K in TagName]: Value extends TagType ? Value : never;
};

type CompactUnion<TagName extends string, TagType, UnionData, T = IntersectKeyValue<UnionData, TagName, TagType>> = T[keyof T];

type IntersectKeyValue<UnionData, TagName extends string, TagType> = {
    [Key in keyof UnionData]: ConstructTag<Key, TagName, TagType> & UnionData[Key];
};

type Nothing = Record<symbol, never>;
