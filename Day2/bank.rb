class Bank
  def process_transactions(transactions, &block)
    raise NotImplementedError, "Subclasses must implement this method"
  end
end
