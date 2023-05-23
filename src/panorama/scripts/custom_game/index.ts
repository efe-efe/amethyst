import "./controllers/cameraController";
import "./controllers/mousePositionController";

import LayoutController from "./layout/layoutController";
import HeroOverhead from "./overhead/heroOverhead";
import HeroInfoCard from "./heroInfoCard";
import AllianceBar from "./allianceBar";
import util, { tables } from "./util";
import "./pve";
import "./targetIndicator";
import "./actions";
import CustomEntities from "./customEntities";
import { CustomGameState, HeroData, UnitData } from "./types";
import { ReadyBar } from "./readyBar";
import UnitOverhead from "./overhead/unitOverhead";

(function () {
  const customEntities = CustomEntities.GetInstance();
  const layout = LayoutController.GetInstance();

  const refunder = $("#refunder") as Button;
  const gameStatePanel = $("#game-state") as LabelPanel;
  const clockPanel = $("#top-bar__clock-text") as LabelPanel;
  const pvePanels = layout.GetTopPanel().FindChildrenWithClassTraverse("pve");
  const pvpPanels = layout.GetTopPanel().FindChildrenWithClassTraverse("pvp");
  const currentLevelPanel = $("#current-room") as LabelPanel;
  const currentStagePanel = $("#current-stage") as LabelPanel;
  const enemiesCountPanel = $("#enemies-count") as LabelPanel;
  const nextRewardPanel = $("#next-reward") as LabelPanel;
  const roomPhasePanel = $("#room-phase") as LabelPanel;
  const roomTypePanel = $("#room-type") as LabelPanel;
  const refunderButton = $("#refunder__button") as Button;
  const refunderPanel = $("#refunder");
  const customHotkeysPanel = $("#custom-hotkeys");
  const hideShowButton = $("#custom-hotkeys__hide-show-button") as Button;
  const swapButton = $("#custom-hotkeys__swap-button") as Button;
  const customHotkeysAllRowsPanel = $("#custom-hotkeys__hotkeys");
  const customHotkeysTextPanel = hideShowButton.FindChildrenWithClassTraverse(
    "custom-hotkeys__button-text"
  )[0] as LabelPanel;

  const heroOverheads: any = {};
  const unitOverheads: any = {};
  const heroInfoCards: any = {};
  const allianceBars: any = {};

  let customHotkeysShowing = true;
  let maxScore = 3;

  GameUI.SetDefaultUIEnabled(
    DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY,
    false
  );
  GameUI.SetDefaultUIEnabled(
    DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES,
    false
  );
  GameUI.SetDefaultUIEnabled(
    DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD,
    false
  );
  GameUI.SetDefaultUIEnabled(
    DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP,
    false
  );
  GameUI.SetDefaultUIEnabled(
    DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME,
    false
  );
  GameUI.SetDefaultUIEnabled(
    DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS,
    false
  );
  GameUI.SetDefaultUIEnabled(
    DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS,
    false
  );
  GameUI.SetDefaultUIEnabled(
    DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP,
    false
  );

  layout.CollapsePanel("level_stats_frame");
  layout.CollapsePanel("inventory_tpscroll_container");
  layout.CollapsePanel("inventory_neutral_slot_container");
  layout.CollapsePanelByClass("AbilityInsetShadowRight");
  layout.CollapsePanel("StatBranch");
  layout.CollapsePanel("health_mana");
  layout.CollapsePanel("AghsStatusContainer");

  const rightFlarePanel = layout
    .GetTopPanel()
    .FindChildTraverse("right_flare")!;
  rightFlarePanel.style.width = "52px";
  rightFlarePanel.style.height = "97px";
  rightFlarePanel.style.marginRight = "244px";

  const centerWithStatsPanel = layout
    .GetTopPanel()
    .FindChildTraverse("center_with_stats")!;
  centerWithStatsPanel.style.horizontalAlign = "left";
  centerWithStatsPanel.style.marginLeft = "80px";

  const buffContainerPanel = layout
    .GetTopPanel()
    .FindChildTraverse("BuffContainer")!;
  buffContainerPanel.style.width = "40%";

  const abilitiesAndStatsBranchPanel = layout
    .GetTopPanel()
    .FindChildTraverse("AbilitiesAndStatBranch")!;
  abilitiesAndStatsBranchPanel.style.marginBottom = "-15px";

  const centerBgPanel = layout.GetTopPanel().FindChildTraverse("center_bg")!;
  centerBgPanel.style.height = "90px";

  layout.SetPanelMargin("debuffs", { bottom: "95px" });
  layout.SetPanelMargin("buffs", { left: "38.5%", bottom: "95px" });
  layout.UpdateCurrency();

  customEntities.AddCallback((value: UnitData) => {
    const entityIndex = value.entityIndex;

    if (value.playerId !== undefined) {
      if (!heroOverheads[entityIndex]) {
        heroOverheads[entityIndex] = new HeroOverhead(value as HeroData);
      } else {
        heroOverheads[entityIndex].UpdateData(value);
      }

      if (!heroInfoCards[entityIndex]) {
        let container: Panel | null;
        const allianceName = (value as HeroData).allianceName;

        if (allianceName == "DOTA_ALLIANCE_RADIANT") {
          container = $("#alliances-status").FindChildTraverse(
            "alliances-status__radiant"
          );
        }
        if (allianceName == "DOTA_ALLIANCE_DIRE") {
          container = $("#alliances-status").FindChildTraverse(
            "alliances-status__dire"
          );
        }
        if (allianceName == "DOTA_ALLIANCE_LEGION") {
          container = $("#alliances-status").FindChildTraverse(
            "alliances-status__legion"
          );
        }
        if (allianceName == "DOTA_ALLIANCE_VOID") {
          container = $("#alliances-status").FindChildTraverse(
            "alliances-status__void"
          );
        }

        heroInfoCards[entityIndex] = new HeroInfoCard(
          value as HeroData,
          container!
        );
      } else {
        heroInfoCards[entityIndex].UpdateData(value);
      }
    } else {
      if (!unitOverheads[entityIndex]) {
        unitOverheads[entityIndex] = new UnitOverhead(value);
      } else {
        unitOverheads[entityIndex].UpdateData(value);
      }
    }
  });
  customEntities.OnReload();

  const tableNameAlliance = "alliances" as never;
  tables.subscribeToNetTableAndLoadNow(
    tableNameAlliance,
    (table: never, key: string | number | symbol, value: any) => {
      const allianceName = value.name as string;

      if (!allianceBars[allianceName]) {
        const topBarContainerPanel = $("#top-bar");
        let topBarPanel: Panel | null = null;

        if (allianceName == "DOTA_ALLIANCE_RADIANT") {
          topBarPanel =
            topBarContainerPanel.FindChildTraverse("top-bar__radiant");
        }
        if (allianceName == "DOTA_ALLIANCE_DIRE") {
          topBarPanel = topBarContainerPanel.FindChildTraverse("top-bar__dire");
        }
        if (allianceName == "DOTA_ALLIANCE_LEGION") {
          topBarPanel =
            topBarContainerPanel.FindChildTraverse("top-bar__legion");
        }
        if (allianceName == "DOTA_ALLIANCE_VOID") {
          topBarPanel = topBarContainerPanel.FindChildTraverse("top-bar__void");
        }

        if (topBarPanel) {
          allianceBars[allianceName] = new AllianceBar(topBarPanel, value);
          allianceBars[allianceName].UpdateMaxScore(maxScore);
        }
      } else {
        allianceBars[allianceName].UpdateData(value);
      }
    }
  );

  const tableNameMain = "main" as never;
  tables.subscribeToNetTableKey(
    tableNameMain,
    "gameState",
    true,
    function (data: any) {
      const state = data.gameState;

      if (Game.IsInToolsMode()) {
        gameStatePanel.text = CustomGameState[data.gameState];
      }
      if (state == CustomGameState.PRE_ROUND) {
        new ReadyBar(4.0);
      }
      if (state == CustomGameState.ROUND_IN_PROGRESS) {
        layout.HideDimmer();
        refunder.style.visibility = "collapse";
      }
      if (state == CustomGameState.WARMUP_IN_PROGRESS) {
        refunder.style.visibility = "visible";
      }
    }
  );

  tables.subscribeToNetTableKey(
    tableNameMain,
    "maxScore",
    true,
    function (data: any) {
      maxScore = data.max_score;

      for (const allianceName in allianceBars) {
        const allianceBar = allianceBars[allianceName];
        allianceBar.UpdateMaxScore(maxScore);
      }
    }
  );

  tables.subscribeToNetTableKey(
    tableNameMain,
    "pve",
    true,
    function (data: any) {
      if (Game.IsInToolsMode()) {
        if (data.nextReward) {
          nextRewardPanel.text = "Next reward: " + data.nextReward;
        }
        if (data.roomPhases) {
          let phasesAsText = "";
          for (const key in data.roomPhases) {
            const phase = data.roomPhases[key];
            phasesAsText = `${phasesAsText} \n\t${phase}`;
            if (parseInt(key, 10) === data.roomPhaseIndex + 1) {
              phasesAsText = phasesAsText + " <==";
            }
          }
          roomPhasePanel.text = "Room phases: " + phasesAsText;
        }
        if (data.roomType) {
          roomTypePanel.text = "Room type: " + data.roomType;
        }
      }
      if (data.currentStage) {
        currentStagePanel.text = "Stage: " + data.currentStage;
      }
      if (data.currentRoom) {
        currentLevelPanel.text = "Room: " + data.currentRoom;
      }
      if (data.remainingEnemies && data.maxEnemies) {
        enemiesCountPanel.text =
          "Killed enemies: " + data.remainingEnemies + "/" + data.maxEnemies;
      }
    }
  );

  function UpdateTime(data: any): void {
    clockPanel.text =
      data.timer_minute_10.toString() +
      data.timer_minute_01.toString() +
      ":" +
      data.timer_second_10.toString() +
      data.timer_second_01.toString();
  }

  GameEvents.Subscribe("countdown", UpdateTime);
  GameEvents.Subscribe("not_enough_energy", function () {
    GameUI.SendCustomHUDError(
      "Not Enough Energy",
      "versus_screen.towers_nopass"
    );
  });

  refunderButton.SetPanelEvent("onactivate", () => {
    const playerId = util.getCurrentPlayer();

    GameEvents.SendCustomGameEventToServer("refund_points", {
      playerIndex: playerId,
    } as never);

    refunderPanel.style.visibility = "collapse";
  });

  customHotkeysPanel.SetPanelEvent("onmouseover", () => {
    customHotkeysPanel.style.opacity = "1.0";
  });
  customHotkeysPanel.SetPanelEvent("onmouseout", () => {
    customHotkeysPanel.style.opacity = "0.5";
  });

  hideShowButton.SetPanelEvent("onactivate", () => {
    if (customHotkeysShowing) {
      customHotkeysPanel.style.width = "140px";
      customHotkeysAllRowsPanel.style.height = "0px";
      customHotkeysTextPanel.text = "SHOW HOTKEYS";
      swapButton.style.visibility = "collapse";
      customHotkeysShowing = false;
    } else {
      customHotkeysPanel.style.width = "340px";
      customHotkeysAllRowsPanel.style.height = "410px";
      customHotkeysTextPanel.text = "HIDE HOTKEYS";
      swapButton.style.visibility = "visible";
      customHotkeysShowing = true;
    }
  });

  swapButton.SetPanelEvent("onactivate", () => {
    SwapRF();
  });

  function SwapRF() {
    const playerId = util.getCurrentPlayer();
    GameEvents.SendCustomGameEventToServer("swap_r_f", {
      playerIndex: playerId,
    } as never);
  }

  if (Game.GetMapInfo().map_display_name === "pvp") {
    pvePanels.forEach((panel) => {
      panel.style.visibility = "collapse";
    });
  } else {
    pvpPanels.forEach((panel) => {
      panel.style.visibility = "collapse";
    });
  }
})();