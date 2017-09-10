# DateAsBool
A simple Rails Gem to get both a datetime and a boolean behaviour from the same database column. I found myself quite often with the following design pattern:

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
  attr_accessor :paid
  def paid=(bool)
    self.paid_at = bool ? Time.now : nil
  end
  def paid
    paid_at.present?
  end
  def paid!
    paid = true
    save
  end
  def paid?
    paid_at.present?
  end
  ...
```

This gem abstracts this behaviour in one line.


## Usage
Let's say you have a `users` table with column `verified_at:datetime`.

Add
```ruby
class User < ApplicationRecord
  date_as_bool :verified_at
  ...
```

Now you can use `user.verified?` to test for `verified_at` presence, and `user.verified!` as an alias for `user.update(verified_at: Time.now)`.

You can also reset the field or change it dynamically with `user.update(verified: bool)`. If false, it resets `verified_at` to `nil`.


## Advanced Usage
If you want to give a different name to the boolean method, you can specify it as the second argument: `date_as_bool :verified_at` gets translated to `date_as_bool :verified_at, :verified`.

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

## Contributing
Pull requests are greatly appreciated. This is my first gem, intended mainly for learning purposes. Its only target is to capture a small design pattern which may be safer to implement just by copy&paste.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
