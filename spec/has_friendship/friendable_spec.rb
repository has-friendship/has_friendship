require 'rails_helper'

describe User, focus: true do

  let(:user){ User.create(name: 'Jessie') }
  let(:friend){ User.create(name: 'Heisenberg') }

  describe "association" do
    # TODO: find a way to test condition
    it { should have_many(:friendships).class_name('HasFriendship::Friendship').dependent(:destroy) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:requested_friends).through(:friendships) }
    it { should have_many(:pending_friends).through(:friendships) }
  end

  describe "instance methods" do

    describe "#friend_request" do
      it "should be provided" do
        expect(user).to respond_to(:friend_request)
      end

      context "when user requests friendship to itself" do
        it "should not create Friendship" do
          expect {
            user.friend_request(user)
          }.to change(HasFriendship::Friendship, :count).by(0)
        end
      end

      context "when user requests friendship to friend" do
        context "if friendship already exists" do
          it "should not create Friendship" do
            create_friendship(user, friend)

            expect {
              user.friend_request(friend)
            }.to change(HasFriendship::Friendship, :count).by(0)
          end
        end

        context "if friendship does not yet exist" do
          it "should create 2 Friendship records" do
            expect {
              user.friend_request(friend)
            }.to change(HasFriendship::Friendship, :count).by(2)
          end

          it "should create requested_friends association" do
            user.friend_request(friend)
            expect(friend.requested_friends).to include user
          end

          it "should create pending_friends association" do
            user.friend_request(friend)
            expect(user.pending_friends).to include friend
          end

          describe "Friendship from user to friend" do
            before :each do
              user.friend_request(friend)
              @friendship = HasFriendship::Friendship.find_by(friendable_id: user.id, friendable_type: user.class.base_class.name, friend_id: friend.id)
            end

            it "should be created" do
              expect(@friendship).to be_present
            end

            it "should have status: 'pending'" do
              expect(@friendship.status).to eq 'pending'
            end
          end

          describe "Friendship from friend to user" do
            before :each do
              user.friend_request(friend)
              @friendship = HasFriendship::Friendship.find_by(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: user.id)
            end

            it "should be created" do
              expect(@friendship).to be_present
            end

            it "should have status: 'requested'" do
              expect(@friendship.status).to eq 'requested'
            end
          end
        end
      end
    end

    describe "#accept_request" do
      it "should be provided" do
        expect(user).to respond_to(:accept_request)
      end

      context "when there is no such request" do
        it "raises error" do
          expect {
            user.accept_request(friend)
          }.to raise_error
        end
      end

      context "when there is a request" do
        it "should create friends association" do
          create_request(user, friend)
          friend.accept_request(user)

          expect(user.friends).to match_array([friend])
          expect(friend.friends).to match_array([user])
        end

        it "should update the status of pending Friendship to 'accepted'" do
          create_request(user, friend)
          friend.accept_request(user)
          friendship = find_friendship_record(user, friend) # status: 'pending'

          expect(friendship.status).to eq 'accepted'
        end

        it "should update the status of requested Friendship to 'accepted'" do
          create_request(user, friend)
          friend.accept_request(user)
          friendship = find_friendship_record(friend, user) #status: 'requested'

          expect(friendship.status).to eq 'accepted'
        end
      end
    end

    describe "#decline_request" do
      it "should be provided" do
        expect(user).to respond_to(:decline_request)
      end

      context "when there is no such request" do
        it "raises error" do
          expect {
            user.decline_request(friend)
          }.to raise_error
        end
      end

      context "when there is a request" do
        it "should destroy both the pending and requested Friendship" do
          create_request(user, friend)
          expect {
            friend.decline_request(user)
          }.to change(HasFriendship::Friendship, :count).by(-2)
        end
      end
    end

    describe "#remove_friend" do
      it "should be provided" do
        expect(user).to respond_to(:remove_friend)
      end

      context "when there is Friendship" do
        it "should destroy both of the Friendship records" do
          create_friendship(user, friend)
          expect{
            user.remove_friend(friend)
          }.to change(HasFriendship::Friendship, :count).by(-2)
        end
      end

      context "when there is no Friendship" do
        it "raises error" do
          expect {
            user.remove_friend(friend)
          }.to raise_error
        end
      end
    end

    describe "#block_friend" do
      it "should be provided" do
        expect(user).to respond_to(:block_friend)
      end

      context "when friend is blocked" do

        it "should no longer be friends" do
          create_friendship(user, friend)
          user.block_friend(friend)
          expect(HasFriendship::Friendship.find_friendship(user, friend).present?).to eq false
        end

        it "should remain in the database" do
          create_friendship(user, friend)
          user.block_friend(friend)
          expect(find_friendship_record(user,friend).present?).to eq true
        end

      end

    end



    describe '#friends_with?' do
      context 'when accepted friendship exists' do
        it 'returns true' do
          create_friendship(user, friend)
          expect(user.friends_with?(friend)).to eq true
        end
      end

      context 'when accepted friendship does not exist' do
        it 'returns false' do
          create_friendship(user, friend)
          jon = User.create(name: 'jon')
          expect(jon.friends_with?(user)).to eq false
        end
      end
    end
  end
end
