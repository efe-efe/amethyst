import HeroController from "./heroController";
import { KeyCode, registerKeyBind } from "./hotkeys";
import LayoutController from "./layout/layoutController";

const layout = LayoutController.GetInstance();

type Key = {
  code: KeyCode;
  label?: string;
};

enum MovementCode {
  MOVE_UP = "MOVE_UP",
  MOVE_LEFT = "MOVE_LEFT",
  MOVE_DOWN = "MOVE_DOWN",
  MOVE_RIGHT = "MOVE_RIGHT",
  BASIC_ATTACK = "BASIC_ATTACK",
  SECOND_ATTACK = "SECOND_ATTACK",
  MOBILITY = "MOBILITY",
  COUNTER = "COUNTER",
  SPECIAL_ATTACK = "SPECIAL_ATTACK",
  EXTRA = "EXTRA",
  ULTIMATE = "ULTIMATE",
  EX_ONE = "EX_ONE",
  EX_TWO = "EX_TWO",
  CANCEL = "CANCEL",
}

const allKeys: Key[] = [
  { code: "W" },
  { code: "A" },
  { code: "S" },
  { code: "D" },
  { code: "R" },
  { code: "E" },
  { code: "F" },
  { code: "Q" },
  { code: "C" },
  { code: "1" },
  { code: "2" },
  { code: "Space", label: "SPACE" },
  { code: "MOUSE_1", label: "LMB" },
  { code: "MOUSE_2", label: "RMB" },
];

const getKeyByKeyCode = (keys: Key[], keyCode: KeyCode) => {
  return keys.find((key) => key.code == keyCode);
};

function defineMovementAction(keyCode: KeyCode, movementCode: MovementCode) {
  function getDirectionFromMovementCode(code: MovementCode): [number, number] {
    let direction: [number, number] = [0, 0];

    if (code == "MOVE_UP") {
      direction = [0, 1];
    }
    if (code == "MOVE_DOWN") {
      direction = [0, -1];
    }
    if (code == "MOVE_LEFT") {
      direction = [-1, 0];
    }
    if (code == "MOVE_RIGHT") {
      direction = [1, 0];
    }

    return direction;
  }

  const direction = getDirectionFromMovementCode(movementCode);

  registerKeyBind(
    keyCode,
    () => HeroController.StartMoving(direction),
    () => HeroController.StopMoving(direction)
  );
}

function defineAbilityAction(
  keyCode: KeyCode,
  slotIndex: number,
  showEffects = true
) {
  const key = getKeyByKeyCode(allKeys, keyCode);

  if (key) {
    const label = key.label ?? key.code;
    layout.ChangeAbilityTextBySlotIndex(label, slotIndex);

    registerKeyBind(
      keyCode,
      () => HeroController.CastAbility(slotIndex, showEffects),
      () => HeroController.StopCastAbility(slotIndex)
    );
  }
}

registerKeyBind(
  "C",
  () => HeroController.Cancel(),
  () => {}
);

defineMovementAction("W", MovementCode.MOVE_UP);
defineMovementAction("A", MovementCode.MOVE_LEFT);
defineMovementAction("S", MovementCode.MOVE_DOWN);
defineMovementAction("D", MovementCode.MOVE_RIGHT);
defineAbilityAction("R", 6);
defineAbilityAction("F", 5);
defineAbilityAction("E", 4);
defineAbilityAction("Q", 3);
defineAbilityAction("1", 7);
defineAbilityAction("2", 8);
defineAbilityAction("Space", 2);
defineAbilityAction("MOUSE_1", 0, false);
defineAbilityAction("MOUSE_2", 1);
