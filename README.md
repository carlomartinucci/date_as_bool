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

You can also reset the field or change it dynamically with `user.update(verified: bool)`. If false, it resets `verified_at` to `nil`.

You get `User.verified`, equivalent to `User.where.not(verified_at: nil)`, and `User.not_verified` equivalent to `User.where(verified_at: nil)`.

## Motivation

I found myself quite often with the following design pattern:

```ruby
# == Schema Information
#
# Table name: subscriptions
#
#  id                           :integer          not null, primary key
#  paid_at                      :datetime
#  ...
#

class Subscription < ApplicationRecord
  scope :paid,     ->{ where.not(paid_at: nil) }
  scope :not_paid, ->{ where(paid_at: nil) }

  def paid=(bool)
    self.paid_at = bool ? Time.now : nil
  end

  alias_method :paid?, :paid
  def paid
    paid_at.present?
  end

  def paid!
    paid = true
    save
  end

  # ...
end
```

DateAsBool abstracts this behaviour in one line.

## Advanced Usage
If you want to give a different name to the boolean method, you can specify it as the second argument: `date_as_bool :verified_at` is just a shortcut for `date_as_bool :verified_at, :verified`.

## Contributing
Bug reports and pull requests are greatly appreciated.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
