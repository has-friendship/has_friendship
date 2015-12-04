require 'rails_helper'

# Might not be needed
describe "HasFriendship API" do

  let(:user){ User.create(name: "Jessie") }
  let(:friend){ User.create(name: "Heisenberg") }

	describe "Friend request" do
    context "when sent" do
      it "should create pending_friends association" do
        user.friend_request(friend)
        expect(user.pending_friends).to include friend
      end

      it "should create requested_friends association" do
        user.friend_request(friend)
        expect(friend.requested_friends).to include user
      end
    end

    context "when accepted" do
      it "should create friends association" do
        user.friend_request(friend)
        friend.accept_request(user)
        expect(user.friends).to include friend
        expect(friend.friends).to include user
      end
    end
  end
end
