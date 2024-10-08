# Dangerfile

# PRタイトルに "[WIP]" が含まれている場合、警告を表示
warn("⚠️ PR is still a Work In Progress.") if github.pr_title.include? "[WIP]"

# Flutter analyze を実行して、その結果を一時ファイルに保存
analyze_output = `flutter analyze`

# 解析結果にエラーや警告が含まれているかチェック
if analyze_output.include?("info") || analyze_output.include?("error") || analyze_output.include?("warning")
  # 解析結果をPRにコメントとして表示
  markdown("### Flutter Analyze Results\n\n```\n#{analyze_output}\n```")
else
  message("No issues found with flutter analyze.")
end
