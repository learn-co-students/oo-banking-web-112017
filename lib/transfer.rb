require "pry"
class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    if sender.valid? && receiver.valid? && sender.balance >= @amount
      true
    else
      false
    end
    #review syntax of conditionals; most efficient?
  end

  def execute_transaction
    if @status != "complete"  #if nothing has been done yet
      if valid?  #if sender and receiver have valid accounts and amount checks out
        sender.balance -= self.amount
        receiver.balance += self.amount
        @status = "complete"
      else  #if not valid
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end #do nothing if something has already been done
  end

  def reverse_transfer
    if status == "complete"
    sender.balance += self.amount
    receiver.balance -= self.amount
    @status = "reversed"
    end
  end

end
