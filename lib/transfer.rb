class Transfer
  # your code here
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.valid? && (self.status == "pending" || self.status == "reversed")
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
        if self.valid?
          self.status = "complete"
        else
          self.status = "rejected"
          "Transaction rejected. Please check your account balance."
        end
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete" && self.valid?
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
      self.status = "reversed"
    end
  end

end
