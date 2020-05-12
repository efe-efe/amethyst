var SKY_BLUE = "#84f4eb"


var styles = {};
styles["Generic"] = {       backgroundColor: "#F5E767", textShadow: CreateTextShadow("#F5E767"), };
styles["Ultimate"] = {      backgroundColor: "#F5E767", textShadow: CreateTextShadow("#F5E767"), };
styles["Recast"] = {        backgroundColor: "#ADC6DE", textShadow: CreateTextShadow("#ADC6DE"), };
styles["Silence"] = {       backgroundColor: "#C655C4", textShadow: CreateTextShadow("#FFBF20"), };
styles["Adrenaline"] = {    backgroundColor: "#CEDCFF", color: "#CEDCFF" };
styles["Shield"] = {        backgroundColor: "#E8C070", }
styles["Counter"] = {       backgroundColor: "#9DBDEC", textShadow: CreateTextShadow("#9DBDEC"), }
styles["Stun"] = {          backgroundColor: "#ABD5FF", textShadow: CreateTextShadow("#ABD5FF"), }
styles["Slow"] = {          backgroundColor: "#C2AB71", color: "#C2AB71" }
styles["Root"] = {          backgroundColor: "#94A551", textShadow: CreateTextShadow("#94A551"), }
styles["Channeling"] = {    backgroundColor: "#F5E767", }
styles["Invisible"] = {     backgroundColor: "#AEB3A3", color: "#AEB3A3", }
styles["BladeFury"] = {     backgroundColor: "#E55C34", textShadow: CreateTextShadow("#DC8668"), color: "#FFF5D7", };
styles["Mekansm"] = {       backgroundColor: SKY_BLUE, };
styles["Meteor"] = {        backgroundColor: SKY_BLUE, color: "#DC8668", };
styles["Nullifier"] = {     backgroundColor: SKY_BLUE, textShadow: CreateTextShadow("#C655C4"), };



styles["Desolate"] = {
    backgroundColor: "#C655C4",
    color: "#C655C4"
};

styles["DancingBlades"] = {
    backgroundColor: "#DC8668",
    color: "#DC8668"
}

styles["Darkness"] = {
    backgroundColor: "#DC8668",
    color: "#DC8668"
}


styles["Sleep"] = {
    backgroundColor: "#E55C34",
    textShadow: CreateTextShadow("#E55C34"),
}


styles["Chill"] = {
    backgroundColor: "#9ccee6",
    textShadow: CreateTextShadow("#9ccee6"),
}

styles["Vengance"] = {
    backgroundColor: "#cb70dd",
    color: "#cb70dd"
}

styles["Fear"] = {
    backgroundColor: "#E55C34",
    textShadow: CreateTextShadow("#DC8668"),
    color: "#DC8668"
}

styles["Confused"] = {
    backgroundColor: "#E55C34",
    textShadow: CreateTextShadow("#DC8668"),
    color: "#DC8668"
}

styles["Infection"] = {
    backgroundColor: "#E55C34",
    textShadow: CreateTextShadow("#DC8668"),
    color: "#1aed4e"
}

styles["Raze"] = {
    backgroundColor: "#E55C34",
    textShadow: CreateTextShadow("#DC8668"),
    color: "#E8C070"
}

styles["Desolation"] = {
    backgroundColor: "#E55C34",
    textShadow: CreateTextShadow("#DC8668"),
    color: "#E8C070"
}

function CreateTextShadow( color ){
    return "0px 0px 30px 8.0 " + color + ";"
}