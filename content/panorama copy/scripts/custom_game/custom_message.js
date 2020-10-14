function OnMessageReceived(data)
{
    $('#CustomMessageText').text = data.text
    $('#CustomMessageText').style.opacity = 1.0;

    $.Schedule(5.0, function(){
        $('#CustomMessageText').style.opacity = 0.0;
    });
}

(function () {
    GameEvents.Subscribe("custom_message", OnMessageReceived);
})();