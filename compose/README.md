# 乡建 Demo Compose

这套 Compose 在运行主机上直接从固定 Git 提交构建 Rice 和新版前端，
不需要上传本地 Docker 镜像。PDS、PLC、AppView 和 Post Cache 使用固定镜像摘要。

## 启动

```bash
# 本地测试
./start.sh localhost

# demo.wamo.social 服务器
./start.sh demo.wamo.social
```

本地入口是 <http://localhost:18080>，服务器入口是
<https://demo.wamo.social>。浏览器始终使用所选入口下的同源
`/api`、`/pds` 和 `/post`。

`start.sh` 第一次运行时会生成随机测试密钥和仅供 Docker 内部使用的证书，
构建 Rice 与前端，启动服务，并写入两名 mock 用户、一个任务和两条帖子。
`.env` 和 `certs/` 不进入 Git。

## 服务器首次安装

```bash
git clone --branch demo-wamo-social --single-branch \
  https://github.com/xjdao2025/web5_deploy.git
cd web5_deploy/compose
./start.sh demo.wamo.social
```

以后更新部署配置：

```bash
git pull --ff-only
./start.sh demo.wamo.social
```

## 管理

```bash
docker compose --env-file .env -f compose.yml ps
docker compose --env-file .env -f compose.yml logs -f --tail=100
docker compose --env-file .env -f compose.yml down
```

只有需要完全重置 mock 数据时才执行：

```bash
docker compose --env-file .env -f compose.yml down -v
```

服务器上的 gateway 只监听 `127.0.0.1:18080`。外层 Traefik 负责把
`demo.wamo.social` 的 HTTPS 请求代理到该端口。
