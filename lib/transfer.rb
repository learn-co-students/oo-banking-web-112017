class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount = 50)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    return true if sender.valid? && receiver.valid?
    false
  end

  def execute_transaction
    if self.valid? && sender.balance > amount
      @sender.balance -= amount
      @receiver.balance += amount
      self.status = 'complete'
      @last_transfer = amount
      self.amount = 0
    else
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @last_transfer != nil
      @sender.balance += @last_transfer
      @receiver.balance -= @last_transfer
      self.status = 'reversed'
    end
  end

end
