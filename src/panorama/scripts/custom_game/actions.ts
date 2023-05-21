import HeroController from "./heroController";
import LayoutController from "./layout/layoutController";

const layout = LayoutController.GetInstance();

type KeyState = "neverPressed" | "pressedAtLeastOnce";

type KeyCode =
  | "W"
  | "A"
  | "S"
  | "D"
  | "R"
  | "E"
  | "F"
  | "Q"
  | "C"
  | "1"
  | "2"
  | "Space"
  | "MOUSE_1"
  | "MOUSE_2";

enum HeroActions {
  MOVE_UP,
  MOVE_LEFT,
  MOVE_DOWN,
  MOVE_RIGHT,
  BASIC_ATTACK,
  SECOND_ATTACK,
  MOBILITY,
  COUNTER,
  SPECIAL_ATTACK,
  EXTRA,
  ULTIMATE,
  EX_ONE,
  EX_TWO,
  CANCEL,
}

enum MouseButtons {
  LEFT_CLICK = 0,
  RIGHT_CLICK = 1,
}

class MouseClickController {
  private static instance: MouseClickController;

  private onLeftClickPressed?: () => void;
  private onLeftClickReleased?: () => void;
  private onRightClickPressed?: () => void;
  private onRightClickReleased?: () => void;

  private constructor() {
    GameUI.SetMouseCallback((event, value) => {
      if (event === "pressed") {
        if (value === MouseButtons.LEFT_CLICK && this.onLeftClickPressed) {
          //TODO: It should be managed by the action, not by the mouse controller
          if (GameUI.IsControlDown()) {
            return false;
          }

          this.onLeftClickPressed();

          const reTry = () => {
            if (
              GameUI.IsMouseDown(MouseButtons.LEFT_CLICK) &&
              this.onLeftClickPressed
            ) {
              this.onLeftClickPressed();
              $.Schedule(0.05, reTry);
            }
          };
          $.Schedule(0.05, reTry);
          return true;
        } else if (
          value === MouseButtons.RIGHT_CLICK &&
          this.onRightClickPressed
        ) {
          this.onRightClickPressed();
          return true;
        }
      } else if (event === "released") {
        if (value === MouseButtons.LEFT_CLICK && this.onLeftClickReleased) {
          this.onLeftClickReleased();
          return true;
        } else if (
          value === MouseButtons.RIGHT_CLICK &&
          this.onRightClickReleased
        ) {
          this.onRightClickReleased();
          return true;
        }
      }
      return false;
    });
  }

  public static GetInstance(): MouseClickController {
    if (!MouseClickController.instance) {
      MouseClickController.instance = new MouseClickController();
    }

    return MouseClickController.instance;
  }

  public SetOnLeftClickPressed(onPressed: () => void): void {
    this.onLeftClickPressed = onPressed;
  }

  public SetOnRightClickPressed(onPressed: () => void): void {
    this.onRightClickPressed = onPressed;
  }

  public SetOnLeftClickReleased(onReleased: () => void): void {
    this.onLeftClickReleased = onReleased;
  }

  public SetOnRightClickReleased(onReleased: () => void): void {
    this.onRightClickReleased = onReleased;
  }
}

class Key {
  public keyCode: KeyCode;
  public state: KeyState = "neverPressed";
  public label: string;

  constructor(keyCode: KeyCode, label?: string) {
    this.keyCode = keyCode;
    this.label = label ? label : keyCode;
  }

  public SetState(state: KeyState): void {
    this.state = state;
  }
}

const GetKeyByKeyCode = (keys: Key[], keyCode: KeyCode): Key | undefined => {
  return keys.find((key) => key.keyCode == keyCode);
};

class Command {
  key: Key;
  action: Action;
  mouseClickController = MouseClickController.GetInstance();

  constructor(key: Key, action: Action) {
    this.key = key;
    this.action = action;
    this.mouseClickController = MouseClickController.GetInstance();

    this.Bind();
  }

  Bind(): void {
    if (this.key.keyCode == "MOUSE_1") {
      this.mouseClickController.SetOnLeftClickPressed(() =>
        this.action.OnStart()
      );
      this.mouseClickController.SetOnLeftClickReleased(() =>
        this.action.OnEnd()
      );
    } else if (this.key.keyCode == "MOUSE_2") {
      this.mouseClickController.SetOnRightClickPressed(() =>
        this.action.OnStart()
      );
      this.mouseClickController.SetOnRightClickReleased(() =>
        this.action.OnEnd()
      );
    } else {
      const commandName = `Custom_Key_Bind_${Date.now().toString()}_${
        this.key.keyCode
      }`;

      Game.AddCommand(
        "+" + commandName,
        () => {
          if (this.key.state == "neverPressed") {
            this.key.SetState("pressedAtLeastOnce");
          }
          this.action.OnStart();
        },
        "",
        0
      );
      Game.AddCommand(
        "-" + commandName,
        () => {
          if (this.key.state == "neverPressed") {
            return;
          }
          this.action.OnEnd();
        },
        "",
        0
      );

      Game.CreateCustomKeyBind(this.key.keyCode, "+" + commandName);
    }
  }

  Unbind() {
    // eslint-disable-next-line @typescript-eslint/no-empty-function
    Game.AddCommand("+" + this.key.keyCode + "Key", () => {}, "", 0);
    // eslint-disable-next-line @typescript-eslint/no-empty-function
    Game.AddCommand("-" + this.key.keyCode + "Key", () => {}, "", 0);

    this.key.SetState("neverPressed");
  }
}

const GetActionByActionCode = (
  actions: Action[],
  actionCode: number
): Action | undefined => {
  return actions.filter((action) => action.actionCode == actionCode)[0];
};

class Action {
  actionCode: number;
  name: string;

  constructor(name: string, actionCode: number) {
    this.actionCode = actionCode;
    this.name = name;
  }

  OnStart(): void {
    $.Msg("Im starting the action: ", this.name);
  }

  OnEnd(): void {
    $.Msg("Im ending the action: ", this.name);
  }
}

class AbilityAction extends Action {
  slotIndex: number;
  showEffects: boolean;

  constructor(
    name: string,
    actionCode: HeroActions,
    slotIndex: number,
    showEffects = true
  ) {
    super(name, actionCode);
    this.slotIndex = slotIndex;
    this.showEffects = showEffects;
  }

  OnStart(): void {
    HeroController.CastAbility(this.slotIndex, this.showEffects);
  }

  OnEnd(): void {
    HeroController.StopCastAbility(this.slotIndex);
  }
}

class MovementAction extends Action {
  OnStart(): void {
    const direction = this.GetDirectionFromActionCode(this.actionCode);
    HeroController.StartMoving(direction);
  }

  OnEnd(): void {
    const direction = this.GetDirectionFromActionCode(this.actionCode);
    HeroController.StopMoving(direction);
  }

  GetDirectionFromActionCode(actionCode: HeroActions): [number, number] {
    let direction: [number, number] = [0, 0];

    if (actionCode == HeroActions.MOVE_UP) {
      direction = [0, 1];
    }
    if (actionCode == HeroActions.MOVE_DOWN) {
      direction = [0, -1];
    }
    if (actionCode == HeroActions.MOVE_LEFT) {
      direction = [-1, 0];
    }
    if (actionCode == HeroActions.MOVE_RIGHT) {
      direction = [1, 0];
    }

    return direction;
  }
}

class CancelAction extends Action {
  OnStart(): void {
    HeroController.Cancel();
  }
}

const allActions = [
  new MovementAction("Move up", HeroActions.MOVE_UP),
  new MovementAction("Move down", HeroActions.MOVE_DOWN),
  new MovementAction("Move left", HeroActions.MOVE_LEFT),
  new MovementAction("Move right", HeroActions.MOVE_RIGHT),
  new AbilityAction("Basic attack", HeroActions.BASIC_ATTACK, 0, false),
  new AbilityAction("Second attack", HeroActions.SECOND_ATTACK, 1),
  new AbilityAction("Mobility", HeroActions.MOBILITY, 2),
  new AbilityAction("Counter", HeroActions.COUNTER, 3),
  new AbilityAction("Special attack", HeroActions.SPECIAL_ATTACK, 4),
  new AbilityAction("Extra attack", HeroActions.EXTRA, 5),
  new AbilityAction("Ultimate", HeroActions.ULTIMATE, 6),
  new AbilityAction("EX one", HeroActions.EX_ONE, 7),
  new AbilityAction("EX two", HeroActions.EX_TWO, 8),
  new CancelAction("Cancel", HeroActions.CANCEL),
];

const allKeys = [
  new Key("W"),
  new Key("A"),
  new Key("S"),
  new Key("D"),
  new Key("R"),
  new Key("E"),
  new Key("F"),
  new Key("Q"),
  new Key("C"),
  new Key("1"),
  new Key("2"),
  new Key("Space", "SPACE"),
  new Key("MOUSE_1", "LMB"),
  new Key("MOUSE_2", "RMB"),
];

const CreateCommandByKeyAndActionCodes = (
  keyCode: KeyCode,
  actionCode: HeroActions,
  isAbility = false
): Command => {
  const key = GetKeyByKeyCode(allKeys, keyCode)!;
  const action = GetActionByActionCode(allActions, actionCode)!;

  if (isAbility) {
    const actionAsSpell = action as AbilityAction;
    layout.ChangeAbilityTextBySlotIndex(key.label, actionAsSpell.slotIndex);
  }

  return new Command(key, action);
};

CreateCommandByKeyAndActionCodes("W", HeroActions.MOVE_UP);
CreateCommandByKeyAndActionCodes("A", HeroActions.MOVE_LEFT);
CreateCommandByKeyAndActionCodes("S", HeroActions.MOVE_DOWN);
CreateCommandByKeyAndActionCodes("D", HeroActions.MOVE_RIGHT);
CreateCommandByKeyAndActionCodes("R", HeroActions.ULTIMATE, true);
CreateCommandByKeyAndActionCodes("F", HeroActions.EXTRA, true);
CreateCommandByKeyAndActionCodes("E", HeroActions.SPECIAL_ATTACK, true);
CreateCommandByKeyAndActionCodes("Q", HeroActions.COUNTER, true);
CreateCommandByKeyAndActionCodes("C", HeroActions.CANCEL);
CreateCommandByKeyAndActionCodes("1", HeroActions.EX_ONE, true);
CreateCommandByKeyAndActionCodes("2", HeroActions.EX_TWO, true);
CreateCommandByKeyAndActionCodes("Space", HeroActions.MOBILITY, true);
CreateCommandByKeyAndActionCodes("MOUSE_1", HeroActions.BASIC_ATTACK, true);
CreateCommandByKeyAndActionCodes("MOUSE_2", HeroActions.SECOND_ATTACK, true);
