require 'rails_helper'

# Might not be needed
describe "HasFriendship API" do

  let(:user){ User.create(name: "Jessie", id: 100) }
  let(:friend){ User.create(name: "Heisenberg", id: 101) }

	describe "Friend request" do

    context "when sent" do
      before { user.friend_request(friend) }

      it "should create pending_friends association" do
        expect(user.pending_friends).to include(friend)
      end

      it "should create requested_friends association" do
        expect(friend.requested_friends).to include(user)
      end
    end

    context "when sent and accepted" do
      before { user.friend_request(friend) }
      before { friend.accept_request(user) }

      it "should create friends association" do
        expect(user.friends).to include(friend)
        expect(friend.friends).to include(user)
      end
    end

    describe "When Friendships is a polymorphic relation" do
      let(:tom){ Pet.create(name: "Tom", id: 100) }
      let(:jerry){ Pet.create(name: "Jerry", id: 101) }

      before do
        tom.friend_request(jerry)
        jerry.accept_request(tom)
      end

      context "when different friendable_type is added to the table" do
        it "creates association using that friendable_type" do
          expect(tom.friends).to include(jerry)
          expect(jerry.friends).to include(tom)
          expect(jerry.friendships.last.friendable_type).to eq(tom.class.to_s)
        end
      end

      context "when other friendships records use the same IDs for a different table" do
        before do
          user.friend_request(friend)
          friend.accept_request(user)
        end

        it "supports all the different friendable_type records" do
          expect(HasFriendship::Friendship.count).to eq(4)
        end
      end
    end
  end

end
