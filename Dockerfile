#┌────────────────┐
#│ Исходный образ │
#└────────────────┘

FROM alpine:3.11

#┌────────────────┐
#│ Базовые пакеты │
#└────────────────┘

RUN apk add --update --no-cache g++ make python curl bash bash-doc bash-completion openssh-client git py-pip python-dev \

#┌──────────────────┐
#│ Локальные пакеты │
#└──────────────────┘

&& mkdir /apks \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/nodejs-8.14.0-r0.apk -o /apks/nodejs.apk \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/npm-8.14.0-r0.apk -o /apks/npm.apk \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.15/main/x86_64/nodejs-16.14.2-r0.apk -o /apks/nodejs-last-version.apk \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.15/main/x86_64/npm-8.1.3-r0.apk -o /apks/npm-last-version.apk \

&& curl http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/libcrypto1.0-1.0.2u-r0.apk -o /apks/libcrypto1.0-1.0.2u-r0.apk \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/http-parser-2.8.1-r0.apk -o /apks/http-parser-2.8.1-r0.apk \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/libssl1.0-1.0.2u-r0.apk -o /apks/libssl1.0-1.0.2u-r0.apk \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.11/main/x86_64/libuv-1.34.0-r0.apk -o /apks/libuv-1.34.0-r0.apk \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.15/main/x86_64/brotli-libs-1.0.9-r5.apk -o /apks/brotli-libs-1.0.9-r5.apk \
&& curl http://dl-cdn.alpinelinux.org/alpine/v3.11/main/x86_64/busybox-1.31.1-r11.apk -o /apks/busybox-1.31.1-r11.apk \

#┌─────────┐
#│ Node.js │
#└─────────┘

&& apk add --update --no-cache nodejs=8.14.0-r0 npm -X http://dl-cdn.alpinelinux.org/alpine/v3.8/main/ \
#&& apk add --update --allow-untrusted --no-network --no-cache --repositories-file=/dev/null /apks/nodejs.apk /apks/npm.apk /apks/*.apk \

#┌──────┐
#│ Tmux │
#└──────┘

#&& apk add --update --no-cache tmux=2.4-r0 -X http://dl-cdn.alpinelinux.org/alpine/v3.6/main/ \
&& apk add --update --no-cache tmux -X http://dl-cdn.alpinelinux.org/alpine/v3.15/main/ \

#┌──────┐
#│ Bash │
#└──────┘

&& echo > /etc/shells /bin/bash \
&& sed -i "s/root:x:0:0:root:\/root:\/bin\/ash/root:x:0:0:root:\/root:\/bin\/bash/" /etc/passwd \

#┌────────────┐
#│ Git-Prompt │
#└────────────┘

&& curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o /root/.git-prompt.sh \

#┌────────┐
#│ Cloud9 │
#└────────┘

&& git clone -b master --single-branch https://github.com/c9open/core.git /root/.c9 && cd /root/.c9 \
&& mkdir -p ./node/bin ./bin ./node_modules \
&& ln -sf "`which tmux`" ./bin/tmux \
&& ln -s "`which node`" ./node/bin/node \
&& ln -s "`which npm`" ./node/bin/npm \
&& npm i pty.js@0.3.1 \
&& npm i sqlite3@3.1.8 sequelize@2.0.0-beta.0 \
&& npm i https://github.com/cloud9ideopen/nak/tarball/c9 \
&& echo 1 > ./installed \
&& NO_PULL=1 ./scripts/install-sdk.sh \
&& npm cache clean --force \
&& git reset --hard \

#┌───────────┐
#│ Codeintel │
#└───────────┘

#&& pip install -U pip \
#&& pip install -U virtualenv \
#&& virtualenv --python=python2 /root/.c9/python2 \
#&& source /root/.c9/python2/bin/activate \
#&& mkdir /tmp/codeintel \
#&& pip download codeintel==2.0.0 -d /tmp/codeintel \
#&& cd /tmp/codeintel \
#&& tar xf CodeIntel-2.0.0.tar.gz \
#&& tar czf CodeIntel-2.0.0.tar.gz CodeIntel-2.0.0 \
#&& pip install -U --no-index --find-links=/tmp/codeintel codeintel \

#┌───────────────────────────┐
#│ Удаление временных файлов │
#└───────────────────────────┘

&& rm -rf /root/.c9/.git/objects/pack/* \
&& rm -rf /var/cache/apk/* \
&& rm -rf /var/tmp/* \
&& rm -rf /tmp/*

#┌──────────────────────────────────┐
#│ Рабочая дирректория по умолчанию │
#└──────────────────────────────────┘

ENV WORKSPACE "/workspace"

#┌──────────────┐
#│ Bash-профиль │
#└──────────────┘

COPY bash_profile /root/.bash_profile

#┌───────────────┐
#│ User.Settings │
#└───────────────┘

COPY user.settings /root/.c9/user.settings

#┌────────────┐
#│ Entrypoint │
#└────────────┘

COPY docker-entrypoint /usr/local/bin/
RUN chmod 700 /usr/local/bin/docker-entrypoint
ENTRYPOINT ["/bin/bash", "docker-entrypoint"]
