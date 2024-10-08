# Dangerfile

# flutter_analyze_report.txt が存在するか、空でないか確認
analyze_report_path = "flutter_analyze_report.txt"

if File.exist?(analyze_report_path) && !File.zero?(analyze_report_path)
  # flutter_analyze_report.txt に内容があれば警告を表示
  warn("Flutter analyze レポートに警告やエラーが含まれています。詳細は以下のリンクから確認してください。")
  
  # レポート内容を PR に表示
  report_content = File.read(analyze_report_path)
  markdown("### Flutter Analyze Report\n\n```\n#{report_content}\n```")
else
  # レポートが空の場合は何もしない
  message("Flutter analyze レポートは問題ありません。")
end
