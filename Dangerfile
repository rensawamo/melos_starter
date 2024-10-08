# Dangerfile

# PRタイトルに "[WIP]" が含まれている場合、警告を表示
warn("⚠️ PR is still a Work In Progress.") if github.pr_title.include? "[WIP]"

# flutter analyze を実行して、解析結果を一時ファイルに保存
system("melos analyze > flutter_analyze_report.txt")

# 解析結果をファイルから読み込み
analyze_output = File.read("flutter_analyze_report.txt")

# エラーや警告が含まれているかチェック
if analyze_output.include?("info") || analyze_output.include?("error") || analyze_output.include?("warning")
  # エラーや警告が含まれている場合は、PRにコメントとして出力
  markdown("### Flutter Analyze Results\n\n```\n#{analyze_output}\n```")
else
  # 問題がない場合
  message("🎉 No issues found in the flutter analyze results.")
end

# danger-flutter_lint の設定
flutter_lint.only_modified_files = true
flutter_lint.lint(inline_mode: true)
