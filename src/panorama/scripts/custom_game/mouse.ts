let onLeftClickPressed = () => {};
let onLeftClickReleased = () => {};
let onRightClickPressed = () => {};
let onRightClickReleased = () => {};

enum MouseButtons {
  LEFT_CLICK = 0,
  RIGHT_CLICK = 1,
}

GameUI.SetMouseCallback((event, value) => {
  if (event === "pressed") {
    if (value === MouseButtons.LEFT_CLICK) {
      if (GameUI.IsControlDown()) {
        return false;
      }

      onLeftClickPressed();

      const reTry = () => {
        if (GameUI.IsMouseDown(MouseButtons.LEFT_CLICK)) {
          onLeftClickPressed();
          $.Schedule(0.05, reTry);
        }
      };
      $.Schedule(0.05, reTry);
      return true;
    }

    if (value === MouseButtons.RIGHT_CLICK) {
      onRightClickPressed();
      return true;
    }
  }

  if (event === "released") {
    if (value === MouseButtons.LEFT_CLICK) {
      onLeftClickReleased();
      return true;
    }

    if (value === MouseButtons.RIGHT_CLICK) {
      onRightClickReleased();
      return true;
    }
  }
  return false;
});

export function setOnLeftClickPressed(action: () => void) {
  onLeftClickPressed = action;
}

export function setOnRightClickPressed(action: () => void) {
  onRightClickPressed = action;
}

export function setOnLeftClickReleased(action: () => void) {
  onLeftClickReleased = action;
}

export function setOnRightClickReleased(action: () => void) {
  onRightClickReleased = action;
}
