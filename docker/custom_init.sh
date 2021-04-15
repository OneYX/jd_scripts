#！/bin/sh

sed -i 's/requests/requests[socks]/g' /scripts/docker/bot/requirements.txt
sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
mkdir -p $HOME/.config/pip && cat > $HOME/.config/pip/pip.conf <<EOF
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn
EOF

if [[ "$TG_PROXY_HOST" != "" && "$TG_PROXY_PORT" != "" ]]; then
    echo "proxy=http://$TG_PROXY_AUTH@$TG_PROXY_HOST:$TG_PROXY_PORT" > $HOME/.curlrc
    cat $HOME/.curlrc
fi

sed -i 's#updater = Updater.*# \
    try: \
        if '"'"'TG_SOCKS_HOST'"'"' in os.environ: \
            proxy_host = os.getenv('"'"'TG_SOCKS_HOST'"'"') \
        if '"'"'TG_SOCKS_PORT'"'"' in os.environ: \
            proxy_port = os.getenv('"'"'TG_SOCKS_PORT'"'"') \
        if '"'"'TG_SOCKS_USERNAME'"'"' in os.environ: \
            proxy_username = os.getenv('"'"'TG_SOCKS_USERNAME'"'"') \
        if '"'"'TG_SOCKS_PASSWORD'"'"' in os.environ: \
            proxy_password = os.getenv('"'"'TG_SOCKS_PASSWORD'"'"') \
        REQUEST_KWARGS={ \
            '"'"'proxy_url'"'"': '"'"'socks5h://{proxy_host}:{proxy_port}'"'"'.format(proxy_host=proxy_host, proxy_port=proxy_port), \
            '"'"'urllib3_proxy_kwargs'"'"': { \
                '"'"'username'"'"': proxy_username, \
                '"'"'password'"'"': proxy_password, \
            } \
        } \
    except: \
        REQUEST_KWARGS={} \
    updater = Updater(bot_token, request_kwargs=REQUEST_KWARGS, use_context=True)#g' /scripts/docker/bot/jd_bot
