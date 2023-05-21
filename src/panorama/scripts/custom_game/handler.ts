//This handler asumes that the keyName is the same as the object accessor

export default class Handler {
  private state: any;
  private listeners: ((state: any) => void)[] = [];

  constructor() {
    const tableName = this.GetTableName() as never;
    const initialState = this.GetInitialData(tableName);

    this.SetNetTableListener(tableName);
    if (initialState) {
      this.SetState(initialState);
    }
  }

  private GetInitialData(tableName: never): any {
    const keyName = this.GetTableKeyName();
    const initialState = CustomNetTables.GetTableValue(
      tableName,
      keyName
    ) as any;
    if (initialState) {
      return initialState[keyName];
    }
    return this.GetDefaultState();
  }

  public GetDefaultState(): any {
    return undefined;
  }

  public GetTableName(): string {
    return "";
  }

  public GetTableKeyName(): string {
    return "";
  }

  private SetNetTableListener(tableName: never) {
    const keyName = this.GetTableKeyName();

    CustomNetTables.SubscribeNetTableListener(
      tableName,
      (table: never, key: string | number | symbol, value: any) => {
        if (key == keyName) {
          this.SetState(value[keyName]);
        }
      }
    );
  }

  public AddListenerAndRunImmediatly(listener: (state: any) => void): void {
    listener(this.state);
    this.AddListener(listener);
  }

  public AddListener(listener: (state: any) => void): void {
    this.listeners = [...this.listeners, listener];
  }

  public SetState(state: any): void {
    this.state = state;
    this.OnStateChange();
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  private OnStateChange(): void {
    this.listeners.forEach((listener) => {
      listener(this.state);
    });
  }
}
