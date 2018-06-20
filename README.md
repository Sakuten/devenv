# 開発環境

## 必要なもの

- [Docker](https://www.docker.com/)
   - Windows 64bit: [Docker CE for Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows)
   - Windows 32bit または上記の方法でうまく行かない場合: `docker-machine`を使用。[詳しく見る](/README.md#windows-32bit)
   - macOS: [Docker CE for macOS](https://store.docker.com/editions/community/docker-ce-desktop-mac)
   - GNU/Linux: [適当にディストリを選んで](https://www.docker.com/community-edition#/download)
- [Docker Compose](https://github.com/docker/compose)
   - [ここを読んでインストール](https://docs.docker.com/compose/install/)
- Git
   - Windows: [Git for Windows](https://gitforwindows.org/)
   - macOS: `brew install git`
   - GNU/Linux: ディストリごとに適当に
- gitflow-avh (ただのgitflowではなくAVH Editionを使用してください)
   - Windows: Git for Windowsに同梱
   - macOS: `brew install gitflow-avh`
   - GNU/Linux: See [Here](https://github.com/petervanderdoes/gitflow-avh/wiki/Installing-on-Linux,-Unix,-etc.)

## セットアップ

```bash
git clone --recursive https://github.com/Sakuten/devenv
cd devenv
# フロントエンドの開発をする場合
cd frontend
git pull origin develop # 最新のソースに更新
# バックエンドの開発をする場合
cd backend
git pull origin develop # 最新のソースに更新
```

## 開発を開始

`docker-compose.yml`があるディレクトリで

```bash
docker-compose up
```

`.env`に記載されたポートが開くので、開発が開始できます
`frontend/`と`backend/`はそれぞれ編集すると自動でリロードがかかりますので、お好みのエディタで編集してください

## ワークフロー

0. (バグを見つけたり、やらなきゃいけないことを見つけたりしたらIssueを立てます。)
1. あなたががIssueにアサインされます
2. ローカルでfeatureやbugfixブランチを切ります
   (`develop`で最新のコミットをpullした状態か確認してから行う)
```bash
# 機能追加の場合
git flow feature start feature-name # feature-nameは例です。自分で名付けます。慣習的に`kebab-case`です
```

```bash
# バグ修正の場合
git flow bugfix start bugfix-name # bugfix-nameは例です。自分で名付けます。慣習的に`kebab-case`です
```

3. 実装できたらそのブランチをpushしてGitHub上でPull Requestを出します (ここで`git flow feature finish`しないでください)
```bash
git push origin feature/feature-name # 先ほど作ったブランチをpushする
```

4. あなたのPull Requestを[@Sakuten/moderator](https://github.com/orgs/Sakuten/teams/moderator) がレビューします。指示があったら従ってください
5. マージされたらIssue解決です、ありがとうございました。

# Windows 32bit

64BitでもDocker CEが入らなさそうだったらこっちでお願いします

ちょっと手順が特殊です

1. [Chocolateyをインストール](https://chocolatey.org/install)
2. [VirtualBoxをインストール](https://www.virtualbox.org/wiki/Downloads)
3. [Git for Windowsをインストール](https://gitforwindows.org/)
4. docker-machineをインストール: `choco install docker-machine -y`
5. Powershellで`fsutil behavior set SymlinkEvaluation L2L:1 R2R:1 L2R:1 R2L:1`と実行
6. Git Bashで以下を実行し、仮想マシンを作る

```bach
docker-machine create --driver virtualbox default
```

7. Git Bashで以下を実行し、仮想マシンに入る

```bash
docker-machine ssh default -L 8000:localhost:8000 -L 8081:localhost:8081 -L 8888:localhost:8888
```

8. (ここから仮想マシン上で)以下のコマンドを実行し、composeをインストールする

```bash
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

9. `devenv`のディレクトリへ`cd`
10. `docker-compose up`
11. 完了。あとはWindows側から更新すれば自動ビルドがかかります

初回以降は7からやればOKです
