# Documentation Index

このディレクトリは、`tiwa-cc.github.io` の実装状況をもとに設計メモを整理したものです。  
コードの理想像ではなく、2026-04-07 時点の実装と未実装をそのまま反映しています。

現行のユーザー向けセクションは `Profile`、`Contents`、`Core Skills`、`About`、`Software Skills`、`Experience`、`Contact` です。

## 一覧

- [architecture.md](architecture.md)
  UI、`ThemeExtension` を含む shared 構成、状態管理、データアクセスを含む全体構成です。
- [assets.md](assets.md)
  SVG ベースのブランド素材運用、`assets/original` と `assets` の役割分担、Header の見せ方をまとめています。
- [api-design.md](api-design.md)
  `about`、`contents`、`experience` などのデータ取得抽象、現在の疑似 API、将来の本番 API 方針をまとめています。
- [state-machine.md](state-machine.md)
  画面初期化、スクロール、データ表示の状態遷移を整理しています。
- [decisions.md](decisions.md)
  実装から読み取れる設計判断とそのトレードオフです。
- [roadmap.md](roadmap.md)
  現状の不足を埋めるための優先タスクです。
- [anomaly-detection.md](anomaly-detection.md)
  コードベース上の不整合、仮実装、リスクを洗い出しています。

## 参照順

初見で追うなら、次の順が最短です。

1. `architecture.md`
2. `assets.md`
3. `decisions.md`
4. `api-design.md`
5. `state-machine.md`
6. `roadmap.md`
7. `anomaly-detection.md`

## 補足

- 主要な構成図は各 Markdown に Mermaid で埋め込んでいるため、GitHub 上でそのまま参照できます。
- 図は `docs/plantuml/` に一部ありますが、本文との対応づけはまだ未整理です。
- 実コードとドキュメントに差分が出た場合は、コードを正とします。
