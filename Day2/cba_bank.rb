require_relative 'logger'
require_relative 'bank'

class CBABank < Bank
  include Logger

  def initialize(users)
    @users = users
  end

  def process_transactions(transactions, &callback)
    transaction_list = transactions.map(&:to_s).join(', ')
    log_info("Processing Transactions #{transaction_list}...")

    transactions.each do |txn|
      user = txn.user
      value = txn.value

      begin
        unless @users.include?(user)
          raise "#{user.name} not exist in the bank!!"
        end

        if user.balance + value < 0
          raise "Not enough balance"
        end

        user.balance += value
        log_info("#{txn} succeeded")

        if user.balance == 0
          log_warning("#{user.name} has 0 balance")
        end

        puts "Call endpoint for success of #{txn}"
        callback.call(:success)
      rescue => e
        log_error("#{txn} failed with message #{e.message}")
        puts "Call endpoint for failure of #{txn} with reason #{e.message}"
        callback.call(:failure)
      end
    end
  end
end
