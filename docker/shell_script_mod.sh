#！/bin/sh

echo "mergedListFile: $mergedListFile"

mergedListFile="/scripts/docker/merged_list_file.sh"

echo "设定脚本中的代理认证..."
sed -i '/port: process.env.TG_PROXY_PORT \* 1$/s/$/,\proxyAuth: process.env.TG_PROXY_AUTH/' /scripts/*.js

echo "下载脚本并追加定时任务..."

downloadFiles="jdJxncTokens jx_cfdtx"

ROOT_PATH="https://waxgourd.coding.net/p/github/d/MyActions/git/raw/main"
for fileName in $downloadFiles; do
    curl -Lso- $ROOT_PATH/$fileName.js > /scripts/$fileName.js
done

curl -Lso- https://waxgourd.coding.net/p/github/d/jd_scripts/git/raw/develop/docker/my_crontab_list.sh >> $mergedListFile
