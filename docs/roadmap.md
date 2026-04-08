# Roadmap

## 前提

このロードマップは、現状のコードベースを「ポートフォリオとして公開可能な品質」へ引き上げるための順序です。  
大規模な再設計より、まず完成度を高めることを優先します。

## Phase 1: 公開最低ライン

### 1. コンテンツの実データ化

- Contact の未接続項目に実リンクまたは非表示条件を入れる

完了:
- `Contents` は public repo の README をもとに featured work カード表示と外部導線へ移行済み
- `AboutPanel` は mock JSON 経由の実文面表示へ移行済み
- `CoreSkillPanel` は mock JSON 経由の 6 項目箇条書き + 1 行説明表示へ移行済み
- `SoftwareSkillsPanel` は `software_skill.json` + catalog / presenter 方式で capability snapshot 表示へ移行済み

### 2. 見た目の最終調整

- `xs` から `xl` まで主要幅で表示確認する
- Chrome 以外のブラウザでもヘッダの SVG 表示とモーションを確認する
- セクション間余白とカード密度を調整する
- ヘッダの固定表示時の視認性と文言バランスを微調整する
- `ProfilePanel` の SVG とハンドル名の見え方は、レスポンシブ全体調整のタイミングで再確認する

### 3. README と docs の運用開始

- ドキュメントを更新対象として扱う
- 実装変更時に `docs/architecture.md`、`docs/decisions.md`、`docs/assets.md` を追随させる

## Phase 2: データ取得の本実装

### 1. API 契約の確定

- `AboutResponse`、`ContentResponse`、`ExperienceResponse` を実スキーマへ更新する
- `RestClient` の `baseUrl` を本番/開発設定から注入できるようにする
- 失敗時レスポンスとタイムアウト方針を決める

### 2. ヘキサゴナル境界の修正

- `SeverApiInterface` と `StorageAccessInterface` の配置を見直し、port を `app` または `domain` 側へ寄せる
- `shared/providers.dart` を分割し、UI 向け provider と composition root の責務を分ける
- `RawClient` から `Ref` 依存とストレージ更新副作用を除去し、取得専用 adapter に戻す
- `AssetExperience` を `res` から移し、開発用 data source として扱う
- `ApiResponse` の HTTP 依存を薄め、application 層で扱う結果型を整理する

### 3. Repository と Storage の整理

- `ApiRepository` に DTO -> Domain 変換責務を持たせる
- `RawClient` のストレージ副作用を除去する
- `DBAccessor` を実装するか、永続化不要なら削除して設計を簡素化する
- `StorageRepository` を実運用経路に乗せるか削除するか決め、低レベル storage への直結をなくす

### 4. UI 状態の改善

- エラー表示を具体化し、リトライ導線を入れる
- ローディング表示をセクション単位で整える

完了:
- `TopView` で timeout / 自動再試行 / 全体エラーオーバーレイを導入済み
- `ExperiencePanel` に Empty State を追加済み

## Phase 3: 運用性と品質

### 1. テスト追加

- `ExperiencePanel` の `loading / data / error` を Widget test 化
- `ProfilePanel` の theme 適用と semantics を Widget test 化
- `RawClient` の JSON 読み込みをユニットテスト化
- ブレークポイントごとの代表レイアウトをゴールデンテスト化

完了:
- `ExperiencePanel` の `loading / data / error` は Widget test 化済み
- `ProfilePanel` の theme 適用と semantics は Widget test 化済み

### 2. ローカライズ整備

- `l10n.dart` を Flutter 標準の生成ベースへ寄せる
- 日本語/英語の切り替え方針を明確にする

### 3. デプロイ整備

- GitHub Pages 向けビルド成果物配置を定義する
- WebAssembly 利用時のブラウザ互換を確認する
- 独自ドメインやメタ情報を整える

## 保留項目

- ブログや実績詳細ページの追加
- CMS 連携
- アニメーションやインタラクションの強化

これらは公開最低ラインを超えた後で十分です。  
まずは、現状の 1 ページ構成を完成させる方が投資対効果が高いです。
