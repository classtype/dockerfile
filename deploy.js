//--------------------------------------------------------------------------------------------------

const Exec = require('app.exec');

//--------------------------------------------------------------------------------------------------
/*
// Проверяем инициализирован-ли уже репозиторий
new Exec([
    ['git', 'status']
])
.onEnd((result) => {
// Инициализируем и заливаем на GitHub
    if (result.split('\n')[1].substring(0, 5) == 'fatal') {
        Exec([
            ['clear'],
            ['git', 'init'],
            ['git', 'add', '.'],
            ['git', 'commit', '-m', '1.0.0'],
            ['git', 'remote', 'add', 'origin', 'git@github.com:classtype/dockerfile.git'],
            ['git', 'push', '-u', 'origin', 'master', '-f'],
        ], true);
        return;
    }
    
// Заливаем на GitHub
    Exec([
        ['clear'],
        ['git', 'add', '.'],
        ['git', 'commit', '--amend', '--no-edit'],
        ['git', 'push', '-f']
    ], true);
});*/
//--------------------------------------------------------------------------------------------------