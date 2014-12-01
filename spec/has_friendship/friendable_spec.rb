require 'rails_helper'

describe Friendable do

  let(:user){ Friendable.create(name: 'Jessie') }
  let(:friend){ Friendable.create(name: 'Heisenberg') }

  describe "association" do
    it { should have_many(:friendships).dependent(:destroy) }
    it { should have_many(:friends).through(:friendships).conditions(status: 'accepted') }
    it { should have_many(:requested_friends).through(:friendships).conditions(status: 'requested') }
    it { should have_many(:pending_friends).through(:friendships).conditions(status: 'pending') }
  end

  describe "instance methods" do
    
    describe ".friend_request" do
      it "should be provided" do
        expect(user).to respond_to(:friend_request)
      end

      context "when user requests friendship to itself" do
        it "should not create Friendship" do
          expect { 
            user.friend_request(user)
          }.to change(Friendship, :count).by(0)
        end
      end

      context "when user requests friendship to friend" do
        context "if friendship already exists" do
          it "should not create Friendship" do
            create_friendship(user, friend)

            expect {
              user.friend_request(friend)
            }.to change(Friendship, :count).by(0)
          end
        end

        context "if friendship does not yet exist" do
          it "should create Friendship from user to friend" do
            user.friend_request(friend)
            friendship = Friendship.find_by(friendable_id: user.id, friendable_type: user.class.base_class.name, friend_id: friend.id)

            expect(friendship).to be_present
          end
        end
      end
    end
  end
end