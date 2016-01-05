# vim:set et ts=2 sw=2 syntax=dockerfile:

FROM       docker.xlands-inc.com/baoyu/debian
MAINTAINER djluo <dj.luo@baoyugame.com>

RUN export http_proxy="http://172.17.42.1:8080/" \
    && export DEBIAN_FRONTEND=noninteractive     \
    && apt-get update \
    && apt-get install -y python \
    && apt-get clean \
    && unset http_proxy DEBIAN_FRONTEND percona \
    && rm -rf usr/share/locale \
    && rm -rf usr/share/man    \
    && rm -rf usr/share/doc    \
    && rm -rf usr/share/info   \
    && find var/lib/apt -type f -exec rm -fv {} \;

COPY ./entrypoint.pl   /entrypoint.pl
COPY ./py-kms/         /py-kms/

ENTRYPOINT ["/entrypoint.pl"]
CMD        ["python", "/py-kms/server.py", "0.0.0.0", "1688"]
