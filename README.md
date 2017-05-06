# HasFriendship [![Build Status](https://travis-ci.org/sungwoncho/has_friendship.svg?branch=master)](https://travis-ci.org/sungwoncho/has_friendship) [![Coverage Status](https://coveralls.io/repos/sungwoncho/has_friendship/badge.png?branch=master)](https://coveralls.io/r/sungwoncho/has_friendship?branch=master)

Add friendship features to your ActiveRecord models.

*HasFriendship* allows ActiveRecord objects to send, accept, and decline friend requests using self-refernetial polymorphic association.

## Getting started

Add *HasFriendship* to your Gemfile:

```ruby
gem 'has_friendship'
```

After you install *HasFriendship*, you need to run the generator:

    $ rails generate has_friendship

The generator will copy a migration that creates `friendships` table. Run the migration to finish the setup.

    $ rake db:migrate

### Upgrading to 0.1.0

`0.1.0` adds a blocking feature for friendables. This requires an additional
column in the `friendships` table, and a migration should be run. You will need
to run the generator and run the new migration.

### Upgrading to 1.x.x

If upgrading from <= 0.1.3 to 1.x.x, please run the following generator:

    $ rails generate has_friendship_update

Then, run the migration:

    $ rake db:migrate

## Usage

Simply drop in `has_friendship` to a model:

```ruby
class User < ActiveRecord::Base
  has_friendship
end
```

### Managing friendship

Now, instances of `User` can send, accept, and decline friend requests:

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

A friendship can also be removed:

```ruby
# @dee removes @mac from its friends
@dee.remove_friend(@mac)
```

### Blocking a friendable

A friendable can be blocked. When blocked, the friendable cannot request or
remove friendship to the one that initially blocked it.

```ruby
@dee.request_friend(@mac)

# @mac blocks @dee from making any more friendship actions
@mac.block_friend(@dee)

# @mac unblocks @dee
# Only @mac can perform this action
@mac.unblock_friend(@dee)
```

### Checking friendship

```ruby
# Check if there is an accepted friendship between @mac and @dee
@mac.friends_with?(@dee)
```

### Type of friends

There are four types of friends:

* requested_friends
* pending_friends
* blocked_friends
* friends

Each type returns an array of friends, which should be looped through to
access specific friends. They can be accessed using association.

#### requested_friends

Instances that sent friend request that has not been accepted.

```ruby
@mac.friend_request(@dee)

@dee.requested_friends # => [@mac]
```

#### pending_friends

Instances that received but has not accepted the friend request.

```ruby
@mac.friend_request(@dee)

@mac.pending_friends # => [@dee]
```

#### blocked_friends

Instances that are blocked from taking any friendship actions

```ruby
@dee.friend_request(@mac)
@mac.block_friend(@dee)

@mac.blocked_friends # => [@dee]
```

#### friends

Instances with accepted Friendship.

```ruby
@mac.friend_request(@dee)
@dee.accept_request(@mac)

@mac.friends # => [@dee]
@dee.friends # => [@mac]
```

### Callbacks

To use callbacks you can add methods described below, to your Friendable model.

```ruby
def on_friendship_created(friendship)
  ...
end

def on_friendship_accepted(friendship)
  ...
end

def on_friendship_blocked(friendship)
  ...
end
```

## Roadmap

Thanks for all the contributors. Pull requests are encouraged for the following
features.

- [ ] Make a separate table/model for friendship blocking records, with `blocker_id`
and `blockee_id`. Currently, `Friendship` model is kind of bloated.
- [x] Implement state machine for friendship status. ([#24](https://github.com/sungwoncho/has_friendship/pull/24))
