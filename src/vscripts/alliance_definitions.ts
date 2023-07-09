export const allianceDefinitions: {
    id: AllianceId;
    teams: DotaTeam[];
}[] = [];

allianceDefinitions.push({ id: AllianceId.none, teams: [] });
allianceDefinitions.push({ id: AllianceId.radiant, teams: [DotaTeam.GOODGUYS, DotaTeam.BADGUYS] });
allianceDefinitions.push({ id: AllianceId.dire, teams: [DotaTeam.CUSTOM_1, DotaTeam.CUSTOM_2, DotaTeam.NEUTRALS] });
allianceDefinitions.push({ id: AllianceId.legion, teams: [DotaTeam.CUSTOM_3, DotaTeam.CUSTOM_4] });
allianceDefinitions.push({ id: AllianceId.void, teams: [DotaTeam.CUSTOM_5, DotaTeam.CUSTOM_6] });

export function findAllianceDefinitionByUnit(unit: CDOTA_BaseNPC) {
    return allianceDefinitions.find(alliance => alliance.teams.some(team => team == unit.GetTeam()));
}

export function findAllianceDefinitionByTeam(team: DotaTeam) {
    return allianceDefinitions.find(alliance => alliance.teams.some(allianceTeam => allianceTeam == team));
}
