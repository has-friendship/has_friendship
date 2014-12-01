require 'rails_helper'

describe HasFriendship do
  it { should be_a(Module) }

  describe ".friendable?" do
    it "should be provided for models" do
      expect(Friendable).to respond_to(:friendable?)
      expect(Unfriendable).to respond_to(:friendable?)
    end

    context "for friendable models" do
      it "should return true" do
        expect(Friendable).to be_friendable
      end
    end

    context "for unfriendable models" do
      it "should return false" do
        expect(Unfriendable).not_to be_friendable
      end
    end
  end
end