# Anomaly Detection

## 位置づけ

このファイルでは、機械学習の異常検知ではなく、コードベース上の不整合や公開前リスクを洗い出します。  
実装を読んだときに「仕様として不自然」「将来壊れやすい」と判断した点を記録します。

## 検出した主な異常

### A-001 本番経路が未完成

対象:
- `lib/infrastructure/storage/db_accessor.dart`
- `lib/infrastructure/communicate/rest_client.dart`

内容:
- `DBAccessor` は `watchExperienceList()` と `insertOrUpdateExperience()` が未実装
- `RestClient` の `baseUrl` は `https://example.com/api/v1/`

影響:
- `FLAVOR=production` での実動作は成立しない

対応:
- 本番運用前に API と Storage を実装する

### A-002 Experience API の責務分離が崩れている

対象:
- `lib/infrastructure/communicate/raw_client.dart`
- `lib/infrastructure/repository/api_repository.dart`

内容:
- `RawClient` が API 呼び出しのふりをしながら Storage を直接更新している
- `ApiRepository` は結果の型変換や保存責務を持たない

影響:
- 開発実装と本番実装の差が大きくなり、置き換え時に破綻しやすい

対応:
- API は DTO を返すだけにし、保存責務を Repository か UseCase に寄せる

### A-004 ローカライズ実装が簡易版のまま

対象:
- `lib/l10n/l10n.dart`

内容:
- Flutter 標準生成コードではなく独自 `L10n` 実装を維持している
- UI 文言と mock データの両方で locale ごとの差分を手動管理している
- 一部コンテンツはローカライズ資産ではなく mock JSON 側で管理している

影響:
- Flutter 標準の i18n 実装としては不完全
- 表示言語の整合が取りにくい

対応:
- 生成ベースの l10n へ移行するか、単一言語方針に割り切って整理する

### A-005 テスト網羅がまだ限定的

対象:
- `test/widget_test.dart`
- `test/features/`

内容:
- `ExperiencePanel`、`ProfilePanel` などの Widget test はある
- 一方で `test/widget_test.dart` は Flutter の初期テンプレートがコメントアウトされたまま
- レスポンシブ全体のゴールデンテストや、主要導線を通す統合テストは未整備

影響:
- セクション単体の回帰は拾えても、ページ全体のレイアウト崩れや導線不整合は検知しにくい

対応:
- `widget_test.dart` を実アプリの smoke test に置き換える
- ブレークポイントごとの代表レイアウトをゴールデンテスト化する

### A-006 ドキュメント参照先の揺れ

対象:
- `README.md`
- `docs/`
- `dartdoc_options.yaml`

内容:
- 人間向けドキュメントは `docs/`
- `dartdoc_options.yaml` は `doc/README.md` を参照

影響:
- ドキュメント運用の導線が分かれ、更新漏れが起きやすい

対応:
- `doc` と `docs` のどちらを正式な置き場にするか決める

## 優先度

### 高

- A-001 本番経路未完成

### 中

- A-002 責務分離の崩れ
- A-004 ローカライズ簡易実装
- A-005 テスト不足

### 低

- A-006 ドキュメント参照先の揺れ

## 継続チェック項目

- `FLAVOR=production` でアプリがクラッシュしないか
- `assets/mock/*.json` と本番 API スキーマが乖離していないか
- 新しいセクション追加時に全ブレークポイントへ反映されているか
- クリック可能に見える UI が本当に動作するか
