require 'pry'

class Transfer

  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    #take money from sender
    #add money to receiver
    #if the status is complete stop the transaction
    if @status == "pending" && self.valid? && @amount <= sender.balance
      sender.balance -= @amount
      receiver.balance += @amount
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
     if @status == "complete"
       receiver.balance -= @amount
       sender.balance +=@amount
       @status = "reversed"
     end
  end
end
