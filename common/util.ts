export const Math = {
    Clamp(number: number, minimum: number, maximum: number): number{
        return number <= minimum ? minimum : number >= maximum ? maximum : number;
    }
};