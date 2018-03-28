require 'fastlane/action'
require_relative '../helper/git_commit_changelog_to_markdown_helper'

module Fastlane
  module Actions
    class GitCommitChangelogToMarkdownAction < Action
      def self.run(params)
        if params && params[:filter]
          filter = params[:filter]
        else
          filter = nil
        end

        changelog = lane_context[SharedValues::FL_CHANGELOG]

        if changelog
          changelog_lines = changelog.split("\n")
          converted_lines = []

          changelog_lines.each do |line|
            if filter
              if filter.match(line)
                converted_lines.push("* #{line}\n")
              end
            else
              converted_lines.push("* #{line}\n")
            end
          end

          return converted_lines.join
        else
          UI.error("Changelog is missing from context!")
        end
      end

      def self.description
        "This plugin will take the output of the 'changelog_from_git_commits' plugin and convert it into markdown"
      end

      def self.authors
        ["Fernando Berrios"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "This plugin will take the output of the 'changelog_from_git_commits' plugin and convert it into markdown. This is useful for gautomatically generating release notes from the git commit log. Supports filtering so that you can include only the messages you want (e.g. only commits that start with 'USxxx:' or 'NOTES')."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :filter,
                                  env_name: "GIT_COMMIT_CHANGELOG_TO_MARKDOWN_FILTER",
                               description: "A description of your option",
                                  optional: true,
                                      type: Regexp)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
