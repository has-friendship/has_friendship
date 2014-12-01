require 'rails_helper'

describe Friendship do

  let(:user){ Friendable.create(name: 'Jessie') }
  let(:friend){ Friendable.create(name: 'Heisenberg') }

  describe "associations" do
    it { should belong_to(:friendable) }
    it { should belong_to(:friend).class_name('Friendable').with_foreign_key(:friend_id) }
  end

  describe "class methods" do

    describe ".check_one_side" do
      it "should be provided" do
        expect(Friendship).to respond_to(:check_one_side)
      end

      context "when a one-side friendship exists" do
        it "returns true" do
          Friendship.create(friendable_id: user.id, friendable_type: user.class.base_class.name, friend_id: friend.id)
          expect(Friendship.check_one_side(user, friend)).to be true
        end
      end

      context "when there is not one-side friendship" do
        it "returns false" do
          expect(Friendship.check_one_side(user, friend)).to be false
        end
      end
    end

    describe ".exist?" do
      it "should be provided" do
        expect(Friendship).to respond_to(:exist?)
      end

      context "when a friendship exists between user and friend" do
        it "returns true" do
          create_friendship(user, friend)
          expect(Friendship.exist?(user, friend)).to be true
        end
      end

      context "when a friendship does not exists" do
        it "returns false" do
          expect(Friendship.exist?(user, friend)).to be false
        end
      end
    end

    describe ".find_friendship" do
      it "should be provided" do
        expect(Friendship).to respond_to(:find_friendship)
      end

      it "should find friendship" do
        create_request(user, friend)
        friendship = Friendship.find_by(friendable_id: user.id, friendable_type: user.class.base_class.name, friend_id: friend.id)

        expect(Friendship.find_friendship(user, friend)).to eq friendship
      end
    end
  end
end