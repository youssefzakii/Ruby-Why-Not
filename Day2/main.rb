require_relative 'user'
require_relative 'transaction'
require_relative 'cba_bank'

users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

outside_users = [
  User.new("Menna", 400)
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(outside_users[0], -100)
]

bank = CBABank.new(users)

bank.process_transactions(transactions) do |result|
  
end
