# Dangerfile

# flutter analyze を実行して、解析結果を一時ファイルに保存
system("melos analyze > flutter_analyze_report.txt")

# 解析結果をファイルから読み込み
analyze_output = File.read("flutter_analyze_report.txt")

# エラーや警告が含まれているかチェック
if analyze_output.include?("info") 
  markdown("### found info issues in the flutter analyze results")
else
  message("🎉 No issues found in the flutter analyze results.")
end

# danger-flutter_lint の設定
flutter_lint.only_modified_files = true
flutter_lint.lint(inline_mode: true)
