require 'rails_helper'

describe HasFriendship::Friendship, type: :model do

  let(:user){ User.create(name: "Jessie") }
  let(:friend){ User.create(name: "Heisenberg") }

  describe "associations" do
    it { should belong_to(:friendable) }
    it { should belong_to(:friend).with_foreign_key(:friend_id) } # Why can't I use '.class_name('Friendable')'?
  end

  describe "class methods" do
    describe ".exist?" do
      it "should be provided" do
        expect(HasFriendship::Friendship).to respond_to(:exist?)
      end

      context "when a friendship exists between user and friend" do
        it "returns true" do
          create_friendship(user, friend)
          expect(HasFriendship::Friendship.exist?(user, friend)).to be true
        end
      end

      context "when a friendship does not exists" do
        it "returns false" do
          expect(HasFriendship::Friendship.exist?(user, friend)).to be false
        end
      end
    end

    describe ".find_unblocked_friendship" do
      it "should be provided" do
        expect(HasFriendship::Friendship).to respond_to(:find_unblocked_friendship)
      end

      it "should find friendship" do
        create_request(user, friend)
        friendship = HasFriendship::Friendship.find_by(friendable_id: user.id, friendable_type: user.class.base_class.name, friend_id: friend.id)

        expect(HasFriendship::Friendship.find_unblocked_friendship(user, friend)).to eq friendship
      end
    end

    describe ".find_blocked_friendship" do
      it "should find a blocked friendship" do
        create_friendship(user, friend, status: 'blocked', blocker_id: user.id)
        friendship = find_friendship_record(user, friend)

        expect(HasFriendship::Friendship.find_blocked_friendship(user, friend)).to eq friendship
      end
    end

    describe '.find_one_side' do
      it 'finds a friendship record' do
        create_request(user, friend)
        friendship = find_friendship_record(user, friend)
        expect(HasFriendship::Friendship.find_one_side(user, friend)).to eq friendship
      end
    end
  end
end
