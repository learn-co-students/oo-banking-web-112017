class Transfer
  attr_reader :receiver, :sender
  attr_writer
  attr_accessor :status, :amount


  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end


  def valid?
    self.sender.valid? && self.receiver.valid? ? true : false
  end


  def execute_transaction
    if self.valid? && self.sender.balance >= self.amount && self.status == "pending"
      self.sender.balance -= self.amount
      self.receiver.deposit(self.amount)
      self.status = "complete"
    else
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end


  def reverse_transfer
    if self.status == "complete"
      self.sender.deposit(self.amount)
      self.receiver.balance -= self.amount
      self.status = "reversed"
    end
  end





  # your code here
end
