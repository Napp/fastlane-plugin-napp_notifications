describe Fastlane::Actions::NappNotificationsAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The napp_notifications plugin is working!")

      Fastlane::Actions::NappNotificationsAction.run(nil)
    end
  end
end
