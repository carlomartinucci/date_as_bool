class User < ApplicationRecord
  date_as_bool :verified_at, :verified
end
