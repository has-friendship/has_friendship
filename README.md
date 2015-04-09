# HasFriendship [![Build Status](https://travis-ci.org/sungwoncho/has_friendship.svg?branch=master)](https://travis-ci.org/sungwoncho/has_friendship) [![Coverage Status](https://coveralls.io/repos/sungwoncho/has_friendship/badge.png?branch=master)](https://coveralls.io/r/sungwoncho/has_friendship?branch=master)

Add social network friendship feature to your Active Record models.

*HasFriendship* allows objects in a model to send, accept, and decline friend requests using self-refernetial polymorphic association.

## Getting started

Add *HasFriendship* to your Gemfile:

```ruby
gem 'has_friendship'
```

After you install *HasFriendship*, you need to run the generator:

    $ rails generate has_friendship

The generator will copy a migration that creates `friendships` table. Run the migration to finish the setup.

    $ rake db:migrate

## Usage

Simply drop in `has_friendship` to a model:

```ruby
class User < ActiveRecord::Base
  has_friendship
end
```

#### Friend request

Now, User instances can send, accept, and decline friend requests:

```ruby
@mac = User.create(name: "Mac")
@dee = User.create(name: "Dee")

# @mac sends a friend request to @dee
@mac.friend_request(@dee)

# @dee can accept the friend request
@dee.accept_request(@mac)

# @dee can also decline the friend request
@dee.decline_request(@mac)
```

A Friendship can also be removed:

```ruby
# @dee removes @mac from its friends
@dee.remove_friend(@mac)
```

#### Type of friends

There are three types of friends. They can be accessed using association:

* `requested_friends`

Instances that sent friend request that has not been accepted yet.

```ruby
@mac.friend_request(@dee)

@dee.requested_friends # => [@mac]
```

* `pending_friends`

Instances that received but has not accepted the friend request yet.

```ruby
@mac.friend_request(@dee)

@mac.pending_friends # => [@dee]
```

* `friends`

Instances with accepted Friendship.

```ruby
@mac.friend_request(@dee)
@dee.accept_request(@mac)

@mac.friends # => [@dee]
@dee.friends # => [@mac]
```

## Contributing

Issues and pull reqeusts are welcomed.
