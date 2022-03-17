#┌────────────────┐
#│ Исходный образ │
#└────────────────┘

FROM alpine:3.11

#┌────────────────┐
#│ Базовые пакеты │
#└────────────────┘

RUN apk add --update --no-cache g++ make python tmux curl bash bash-doc bash-completion openssh-client git py-pip python-dev \

#┌─────────┐
#│ Node.js │
#└─────────┘

&& apk add --update --no-cache nodejs=8.14.0-r0 npm -X http://dl-cdn.alpinelinux.org/alpine/v3.8/main/ \

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

&& pip install -U pip \
&& pip install -U virtualenv \
&& virtualenv --python=python2 /root/.c9/python2 \
&& source /root/.c9/python2/bin/activate \
&& mkdir /tmp/codeintel \
&& pip download codeintel==2.0.0 -d /tmp/codeintel \
&& cd /tmp/codeintel \
&& tar xf CodeIntel-2.0.0.tar.gz \
&& tar czf CodeIntel-2.0.0.tar.gz CodeIntel-2.0.0 \
&& pip install -U --no-index --find-links=/tmp/codeintel codeintel \

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

#┌────────────┐
#│ Entrypoint │
#└────────────┘

COPY docker-entrypoint /usr/local/bin/
RUN chmod 700 /usr/local/bin/docker-entrypoint
ENTRYPOINT ["/bin/bash", "docker-entrypoint"]
