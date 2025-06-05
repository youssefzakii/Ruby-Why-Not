class User
  attr_reader :name
  attr_accessor :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def to_s
    "#{name} with balance #{balance}"
  end
end
