require 'rails_helper'

describe HasFriendship::Friendship do

  let(:user){ HasFriendship::Friendship.create(name: 'Jessie') }
  let(:friend){ HasFriendship::Friendship.create(name: 'Heisenberg') }

  describe "associations", focus: true do
    it { should belong_to(:friendable) }
    it { should belong_to(:friend).with_foreign_key(:friend_id) } # Why can't I use '.class_name('Friendable')'?
  end

  describe "class methods" do

    describe ".check_one_side" do
      it "should be provided" do
        expect(HasFriendship::Friendship).to respond_to(:check_one_side)
      end

      context "when a one-side friendship exists" do
        it "returns true" do
          HasFriendship::Friendship.create(friendable_id: user.id, friendable_type: user.class.base_class.name, friend_id: friend.id)
          expect(HasFriendship::Friendship.check_one_side(user, friend)).to be true
        end
      end

      context "when there is not one-side friendship" do
        it "returns false" do
          expect(HasFriendship::Friendship.check_one_side(user, friend)).to be false
        end
      end
    end

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

    describe ".find_friendship" do
      it "should be provided" do
        expect(HasFriendship::Friendship).to respond_to(:find_friendship)
      end

      it "should find friendship" do
        create_request(user, friend)
        friendship = HasFriendship::Friendship.find_by(friendable_id: user.id, friendable_type: user.class.base_class.name, friend_id: friend.id)

        expect(HasFriendship::Friendship.find_friendship(user, friend)).to eq friendship
      end
    end
  end
end