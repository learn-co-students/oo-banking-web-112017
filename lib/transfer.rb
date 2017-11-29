require 'pry'
class Transfer
  attr_reader :sender, :receiver
  attr_accessor :status, :amount
  def initialize(status = 'pending', sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = status
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.sender.valid? && self.sender.balance >= self.amount && @status == 'pending'
      sender.balance -= @amount
      receiver.balance += @amount
      self.status = 'complete'
    else
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      sender.balance += @amount
      receiver.balance -= @amount
      self.status = 'reversed'
    end
  end
end
