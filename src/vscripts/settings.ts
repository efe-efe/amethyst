let settings = {
  FirstWarmupDuration: 40.0,
  WarmupDuration: 20.0,
  PreRoundDuration: 4.0,
  RoundDuration: 60.0,
  PickupsCreationTime: 20.0,
  AbilityPoints: 2,
  GemSpawnTime: 10.0,
  GemRespawnTime: 15.0,
  RoundsToWin: 5,
  RoundsDifferenceToWin: 3,
  PreStageDuration: 2.0,
  DrawTime: 3.0,
};

if (IsInToolsMode()) {
  settings = {
    ...settings,
    FirstWarmupDuration: 1.0,
    WarmupDuration: 1.0,
    PreRoundDuration: 1.0,
    RoundDuration: -1.0,
    PickupsCreationTime: 2.0,
    GemSpawnTime: 5.0,
    GemRespawnTime: 5.0,
    PreStageDuration: 2.0,
  };
}

export default settings;
