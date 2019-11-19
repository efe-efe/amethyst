var styles = {};
styles["Ultimate"] = {
    backgroundColor: "#F5E767",
    textShadow: CreateTextShadow("#F5E767"),
};

styles["ChannelingUltimate"] = {
    backgroundColor: "#F5E767",
    textShadow: CreateTextShadow("#F5E767"),
    color: "#F5E767",
};

styles["Recast"] = {
    backgroundColor: "#ADC6DE",
    textShadow: CreateTextShadow("#ADC6DE"),
};

styles["Desolate"] = {
    backgroundColor: "#C655C4",
    color: "#C655C4"
};

styles["Silence"] = {
    backgroundColor: "#C655C4",
    textShadow: CreateTextShadow("#FFBF20"),
};

styles["Mount"] = {
    backgroundColor: "#CEDCFF",
    color: "#CEDCFF"
};

styles["Shield"] = {
    backgroundColor: "#E8C070",
}

styles["DancingBlades"] = {
    backgroundColor: "#DC8668",
    color: "#DC8668"
}

styles["Darkness"] = {
    backgroundColor: "#DC8668",
    color: "#DC8668"
}

styles["Counter"] = {
    backgroundColor: "#9DBDEC",
    textShadow: CreateTextShadow("#9DBDEC"),
}

styles["Slow"] = {
    backgroundColor: "#C2AB71",
    color: "#C2AB71"
}

styles["Sleep"] = {
    backgroundColor: "#E55C34",
    textShadow: CreateTextShadow("#E55C34"),
}

styles["Stun"] = {
    backgroundColor: "#ABD5FF",
    textShadow: CreateTextShadow("#ABD5FF"),
}

styles["Root"] = {
    backgroundColor: "#94A551",
    textShadow: CreateTextShadow("#94A551"),
}

styles["Chill"] = {
    backgroundColor: "#9ccee6",
    textShadow: CreateTextShadow("#9ccee6"),
}

styles["Vengance"] = {
    backgroundColor: "#cb70dd",
    color: "#cb70dd"
}

function CreateTextShadow( color ){
    return "0px 0px 30px 8.0 " + color + ";"
}