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
      context "when a one-side friendship exists" do
        it "returns true" do
          create_oneside_friendship(user, friend)
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
  end
end