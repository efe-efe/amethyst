import Alliance from "./alliance";
import Player from "./player";

export enum CustomGameState {
  NONE = 0,
  PRE_WARMUP,
  WARMUP_IN_PROGRESS,
  PRE_ROUND,
  ROUND_IN_PROGRESS,
  PRE_RUN,
  RUN_IN_PROGRESS,
  POST_RUN,
}

export default class GameState {
  alliances: Alliance[];
  timeRemaining: number;
  infinite: boolean;

  constructor(alliances: Alliance[], duration: number) {
    this.alliances = alliances;
    this.timeRemaining = duration * 30;
    this.infinite = duration == -1;
  }

  Update(): void {
    if (this.timeRemaining > 0) {
      this.timeRemaining = this.timeRemaining - 1;
    }
  }

  GetAllPlayers(): Player[] {
    const players: Player[] = [];
    if (this.alliances) {
      this.alliances.forEach((alliance) => {
        alliance.players.forEach((player) => {
          players.push(player);
        });
      });
    }

    return players;
  }

  GetDuration(): number {
    return math.floor(this.timeRemaining / 30);
  }

  SetDuration(duration: number): void {
    this.timeRemaining = duration * 30;
  }

  UpdateGameTimer(time: number): void {
    const minutes = math.floor(time / 60);
    const seconds = time - minutes * 60;
    const m10 = math.floor(minutes / 10);
    const m01 = minutes - m10 * 10;
    const s10 = math.floor(seconds / 10);
    const s01 = seconds - s10 * 10;
    const broadcast_gametimer = {
      timer_minute_10: m10,
      timer_minute_01: m01,
      timer_second_10: s10,
      timer_second_01: s01,
    } as never;

    CustomGameEventManager.Send_ServerToAllClients(
      "countdown",
      broadcast_gametimer
    );
  }
}
