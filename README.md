# 開発環境

## 必要なもの

- [Docker](https://www.docker.com/)
- [Docker Compose](https://github.com/docker/compose)
- Git

## セットアップ

```bash
git clone https://github.com/Sakuten/devenv
cd devenv
git clone https://github.com/Sakuten/lottery-backend backend
git clone https://github.com/Sakuten/lottery-frontend frontend
```

## 開発を開始

```bash
docker-compose up
```

`.env`に記載されたポートが開くので、開発が開始できます
`frontend/`と`backend/`はそれぞれ編集すると自動でリロードがかかりますので、お好みのエディタで編集してください
