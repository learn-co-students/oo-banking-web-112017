class Transfer
  @@all = []

  def self.all
    @@all
  end

  attr_reader :amount
  attr_accessor :sender, :receiver, :status

  def initialize(transfer_from, transfer_to, transfer_amount)
    @sender = BankAccount.find_account_by_name(transfer_from) || transfer_from
    @receiver = BankAccount.find_account_by_name(transfer_to) || transfer_to
    @amount = transfer_amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.sender.balance > self.amount && self.receiver.valid? ? true : false
  end

  def execute_transaction
    if self.valid? == true && self.status == "pending"
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.status = "complete"
      @@all << self

    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    last = @@all.pop
    last.sender.balance += last.amount
    last.receiver.balance -= last.amount
    last.status = "reversed"
  end

end
