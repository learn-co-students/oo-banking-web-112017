class BankAccount

  @@all_accounts = []

  def self.all_accounts
    @@all_accounts
  end

  def self.find_account_by_name(account_holder_name)
    self.all_accounts.detect do |bank_account|
      bank_account.name == account_holder_name
    end
  end

  attr_reader :name
  attr_accessor :balance, :status

  def initialize(account_holder_name)
    @name = account_holder_name
    @balance = 1000
    @status = "open"
    @@all_accounts << self
  end

  def deposit(deposit_amount)
    self.balance += deposit_amount
  end

  def display_balance
    "Your balance is $#{self.balance}."
  end

  def valid?
    self.status == "open" && self.balance > 0 ? true : false
  end

  def close_account
    self.status = "closed"
  end

end
