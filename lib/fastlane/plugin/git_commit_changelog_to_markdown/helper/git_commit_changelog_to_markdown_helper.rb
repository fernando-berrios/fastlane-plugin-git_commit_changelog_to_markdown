require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class GitCommitChangelogToMarkdownHelper
      # class methods that you define here become available in your action
      # as `Helper::GitCommitChangelogToMarkdownHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the git_commit_changelog_to_markdown plugin helper!")
      end
    end
  end
end
