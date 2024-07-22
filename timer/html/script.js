window.addEventListener('message', function(event) {
    // Показываем контент, когда скрипт готов
    document.body.style.visibility = 'visible'; 
    
    // Проверяем, что данные события имеют свойство action
    if (!event.data.action) {
        console.error('[ERROR] Event data does not have an action property');
        return;
    }

    if (event.data.action === 'showRespawnScreen') {
        document.getElementById('respawn-screen').style.display = 'flex';
    } else if (event.data.action === 'hideRespawnScreen') {
        document.getElementById('respawn-screen').style.display = 'none';
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
