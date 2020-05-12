var page = 0;
var panel = $("#Tutorial__Container");
var image_panel = panel.FindChildTraverse("Tutorial__Image"); 
var title_panel = panel.FindChildTraverse("Tutorial__Title"); 
var desc_panel = panel.FindChildTraverse("Tutorial__Description"); 
var button_panel = panel.FindChildTraverse("Tutorial_ContinueButton"); 

var data = [{
        title: "Movement",
        image: "file://{images}/custom_game/wasd.png",
        desc: "Use the WASD keys on your keyboard to move your hero over the map."
    },{
        title: "Spells",
        image: "file://{images}/custom_game/laptop.png",
        desc: "Use the SPACEBAR to cast your mobility spell, and Q, E, R, F to cast your other spells"
    },{
        title: "Attacks",
        image: "file://{images}/custom_game/mouse.png",
        desc: "Use the MOUSE to move the camera and aim your spells. Pressing LEFT CLICK performs a basic attack, and RIGHT CLICK performs a special attack."
}] 

function Next(){
    SetPage(page + 1);
}

function Close(){
    SetPage(0);
    panel.style.visibility = "collapse";
}

function SetPage(m_page){
    page = m_page
    OnSetPage();
}

function OnSetPage(){
    if(page > data.length - 1 ){
        Close();
        return;
    }
    image_panel.SetImage(data[page].image);
    title_panel.text = data[page].title;
    desc_panel.text = data[page].desc;

    if(page == data.length - 1){
        button_panel.GetChild(0).text = "Close"
    }
}

(function(){
    OnSetPage();
})();

panel.style.visibility = "visible"; 