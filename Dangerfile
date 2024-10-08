# Dangerfile

warn("⚠️ PR is still a Work In Progress.") if github.pr_title.include? "[WIP]"

flutter_lint.only_modified_files = true
flutter_lint.lint(inline_mode: true)


system("flutter analyze > flutter_analyze_report.txt")
analyze_output = File.read("flutter_analyze_report.txt")

if analyze_output.include?("info")

  warn("⚠️ Flutter analyze found info level messages. Review the output carefully.")
end
