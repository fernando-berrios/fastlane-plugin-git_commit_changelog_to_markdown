describe Fastlane::Actions::GitCommitChangelogToMarkdownAction do
  describe '#run' do
    it 'shows an error when changelog is not available in context' do
      Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::FL_CHANGELOG] = nil

      expect(Fastlane::UI).to receive(:error).with("Changelog is missing from context!")

      output = Fastlane::Actions::GitCommitChangelogToMarkdownAction.run(nil)

      expect(output).to eq(nil)
    end

    it 'returns a bulleted list of commit messages formatted in markdown' do
      changelog = "First! This is commit number one!!\nCommit number 2, bummer.\nCommit number 3, it's not so bad down here..."
      Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::FL_CHANGELOG] = changelog

      output = Fastlane::Actions::GitCommitChangelogToMarkdownAction.run(nil)

      expect(output).to eq("* First! This is commit number one!!\n* Commit number 2, bummer.\n* Commit number 3, it's not so bad down here...\n")
    end

    it 'only lines that match the filter regex are included in output' do
      changelog = "US1234: This is a cool user story\nThis is a random commit message\nDE42523: This was an easy fix\nDE4162 & DE62352 - This was so difficult I forgot how to write commit messages\nWIP: Nobody needs to know about this other commit"
      Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::FL_CHANGELOG] = changelog

      arguments = Fastlane::ConfigurationHelper.parse(Fastlane::Actions::GitCommitChangelogToMarkdownAction, {
        filter: /(US.+:).+|(DE.+:).+|(US.+-).+|(DE.+-).+/
      })

      output = Fastlane::Actions::GitCommitChangelogToMarkdownAction.run(arguments)

      expect(output).to eq("* US1234: This is a cool user story\n* DE42523: This was an easy fix\n* DE4162 & DE62352 - This was so difficult I forgot how to write commit messages\n")
    end
  end
end
