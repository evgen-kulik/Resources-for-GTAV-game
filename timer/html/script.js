window.addEventListener('message', function(event) {
    if (event.data.action === 'showRespawnScreen') {
        const respawnScreen = document.getElementById('respawn-screen');
        respawnScreen.style.opacity = 1; // Сделать экран видимым
        respawnScreen.style.display = 'flex'; // Показать элемент
    } else if (event.data.action === 'hideRespawnScreen') {
        const respawnScreen = document.getElementById('respawn-screen');
        respawnScreen.style.opacity = 0; // Сделать экран невидимым
        setTimeout(() => {
            respawnScreen.style.display = 'none'; // Скрыть элемент после завершения анимации
        }, 1000); // Задержка равна длительности анимации
    }
});

document.getElementById('respawn-button').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/respawn`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {
        console.log('[DEBUG] Response from respawn POST:', resp);
        if (resp === 'ok') {
            document.getElementById('respawn-screen').style.display = 'none';
            console.log('[DEBUG] Respawn screen hidden after POST response');
        } else {
            console.error('[ERROR] Unexpected response:', resp);
        }
    }).catch(error => {
        console.error('[ERROR] Fetch error:', error);
    });
});
