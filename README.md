# DateAsBool

DateAsBool is a simple Rails Gem to get both a datetime and a boolean behaviour from the same database column.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'date_as_bool'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install date_as_bool
```

## Usage
Let's say you have a `users` table with column `verified_at:datetime`.

Add
```ruby
class User < ApplicationRecord
  date_as_bool :verified_at
  ...
```

Now you can use `user.verified` or `user.verified?` to test for `verified_at` presence, and `user.verified!` as an alias for `user.update(verified_at: Time.now)`.

You can change the field with `user.update(verified: bool)`. If false, it resets `verified_at` to `nil`, if true, it sets it to `Time.now`.

You also get the scopes `User.verified`, equivalent to `User.where.not(verified_at: nil)`, and `User.not_verified` equivalent to `User.where(verified_at: nil)`.

### Methods

* `User.verified == User.where.not(verified_at: nil)`
* `User.not_verified == User.where(verified_at: nil)`
* `user.verified == user.verified_at.present?`
* `user.verified? == user.verified_at.present?`
* `user.verified! == user.update(verified: true) == user.update(verified_at: Time.now)`
* `user.update(verified: false) == user.update(verified_at: nil)`

## Motivation

Often, when you need a boolean flag on a model, you can accomplish more by using a datetime attribute instead, that captures the first time the flag turned on. But to recover the simplicity of dealing with a boolean instead of a datetime you have to write some lines of code.

So, I found myself quite often with the following design pattern:

```ruby
# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  verified_at :datetime
#  ...
#

class User < ApplicationRecord
  scope :verified,     -> { where.not(verified_at: nil) }
  scope :not_verified, -> { where(verified_at: nil) }

  def verified=(bool)
    self.verified_at = bool ? Time.now : nil
  end

  def verified
    verified_at.present?
  end
  alias verified? verified

  def verified!
    verified = true
    save
  end

  # ...
end
```

This way, I can both use `User.verified` and `User.where(verified_at: 2.days.ago..Time.now)`.

DateAsBool abstracts this behaviour in one line.

## Advanced Usage
If you want to give a different name to the boolean method, you can specify it as the second argument.

`date_as_bool :verified_at` is just a shortcut for `date_as_bool :verified_at, :verified`.

## Contributing
Bug reports and pull requests are greatly appreciated.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
