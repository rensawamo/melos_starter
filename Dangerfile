# Dangerfile

analyze_report_path = "flutter_analyze_report.txt"

if File.exist?(analyze_report_path) && !File.zero?(analyze_report_path)
  warn("Flutter analyze レポートに警告やエラーが含まれています。詳細は以下のリンクから確認してください。")
  report_content = File.read(analyze_report_path)
  markdown("### Flutter Analyze Report\n\n```\n#{report_content}\n```")
else
  message("Flutter analyze レポートは問題ありません。")
end
