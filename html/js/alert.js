var notifs = {}

window.addEventListener('message', function(event) {
    if (event.data.action == null) return;
    if (!event.data.action == "displayAlert") return;

    ShowNotif(event.data.data);
});

function CreateNotification(data) {
    let $notification = $(document.createElement('div'));
    $notification.addClass('notification').addClass(data.type);
    $notification.html(data.text);
    $notification.fadeIn();
    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }

    return $notification;
}

function UpdateNotification(data) {
    let $notification = $(notifs[data.id])
    $notification.addClass('notification').addClass(data.type);
    $notification.html(data.text);

    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }
}

function ShowNotif(data) {
    let $notification = CreateNotification(data);
    $('.notif-container').append($notification);
    setTimeout(function() {
        $.when($notification.fadeOut()).done(function() {
            $notification.remove()
        });
    }, data.length != null ? data.length : 2500);
}