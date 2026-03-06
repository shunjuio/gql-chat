# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概要

GraphQL を使ったシンプルなリアルタイムチャットアプリ。Rails バックエンド + React フロントエンドの構成。

## コマンド

### 開発サーバー起動

```bash
bin/dev  # Procfile.dev の全プロセスを起動 (web, js, css, codegen)
```

個別起動:
```bash
bin/rails server           # Rails サーバー
yarn build --watch         # JS ビルド (esbuild)
yarn build:css --watch     # CSS ビルド (Tailwind)
yarn codegen --watch       # GraphQL Codegen
```

### Lint

```bash
bin/rubocop                # Ruby lint (CI でも実行)
```

### GraphQL スキーマのエクスポート

codegen は `schema.graphql` ファイルを参照するため、GraphQL スキーマを変更した後はダンプが必要:

```bash
bundle exec rails graphql:schema:dump
```

その後 codegen を実行して型を再生成:

```bash
yarn codegen
```

## アーキテクチャ

### バックエンド (Rails + graphql-ruby)

- GraphQL エンドポイント: `POST /graphql` → `GraphqlController`
- WebSocket サブスクリプション: `/cable` (ActionCable + Redis アダプター)
- `app/graphql/gql_chat_schema.rb` がスキーマのエントリーポイント
- Relay スタイルのグローバル ID を使用 (Base64 エンコードされた GlobalID)
- サブスクリプションは `GraphQL::Subscriptions::ActionCableSubscriptions` を使用

GraphQL のディレクトリ構成:
- `app/graphql/types/` - 型定義
- `app/graphql/mutations/` - ミューテーション
- `app/graphql/resolvers/` - リゾルバ
- `app/graphql/subscriptions/` - サブスクリプション
- `app/graphql/connections/`, `edges/` - Relay Connection

`app/channels/graphql_channel.rb` が ActionCable 経由で GraphQL を実行するチャンネル。

### フロントエンド (React + Apollo Client)

- エントリーポイント: `app/javascript/application.jsx`
- Apollo Client の設定: `app/javascript/client.js`
  - HTTP リンク (`/graphql`) と ActionCable リンク (`/cable`) を操作種別で分岐
  - サブスクリプションは ActionCable、それ以外は HTTP
- メインコンポーネント: `app/javascript/app.jsx`
- GraphQL Codegen が `app/javascript/gql/` に型を生成 (コミット対象)
  - `codegen.yml` で設定、`schema.graphql` からスキーマを読み込む
  - JSX 内の `graphql()` タグ付きテンプレートリテラルから型を生成

### 認証

セッションベース。`SessionsController` でログイン処理、`concerns/login_session.rb` で共通処理。

### gem のバージョン制約

`graphql` gem は `~> 2.4.16` に固定 (skylight の graphql probe が 2.5.0 以降に未対応のため)。
