function OpenShop(){
    if(!Game.IsShopOpen()){
        $.DispatchEvent('DOTAHUDToggleShop');
    }	
}

function CloseShop(){
    if(Game.IsShopOpen()){
        $.DispatchEvent('DOTAHUDToggleShop');
    }	
}

(function() {
    //GameEvents.Subscribe( "open_shop", OpenShop );
    //GameEvents.Subscribe( "close_shop", CloseShop );
})();


