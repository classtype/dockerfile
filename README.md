## Быстрый старт

1. Клонируйте репозиторий.
```
git clone https://github.com/classtype/dockerfile.git .
```

2. Запустите "./build".
```
$ ./build
```


## Как применить изменения?

Просто еще раз запустите команду "./build".

```
$ ./build
```


## Как начать все с чистого листа?

Флаг "-f" удалит все образы из системы.

```
$ ./build -f
```


## start
#!/bin/bash
if ls -v >/dev/null 2>&1; then
    echo "Команда найдена!"
else
    echo "Команда не найдена!"
fi

if command_not_found >/dev/null 2>&1; then
    echo "Команда найдена!"
else
    echo "Команда не найдена!"
fi

command -v foo >/dev/null 2>&1 
type foo >/dev/null 2>&1 
hash foo 2>/dev/null


## TODO
Имя нового workspace не должно быть:
".c9"
"apks"
"bin"
"dev"
"etc"
"home"
"lib"
"media"
"mnt"
"opt"
"proc"
"root"
"run"
"sbin"
"srv"
"sys"
"tmp"
"usr"
"var"
".dockerenv"


## Правильные права доступа к ssh-key
```
https://serverfault.com/questions/253313/ssh-returns-bad-owner-or-permissions-on-ssh-config
```


## Сгенерировать новый ssh-key
```
ssh-keygen -t rsa -b 4096 -C "email@email.email"
```


## Выполнить команду в контейнере
```
docker exec CONTAINER_ID command
```


## Сохранить в файл "/1.log"
```
require('fs').appendFileSync('/1.log', JSON.stringify('Hello world!', 4, '    ') + '\n');
```


## Выполнить файл "синхронно"
```
console.log(require('child_process').spawnSync('/main/8.sh').stdout.toString());
```


## Получить содержимое файла "синхронно"
```
console.log(require('fs').readFileSync('/main/installing').toString());
```


## Font
```
sans-sans
```
