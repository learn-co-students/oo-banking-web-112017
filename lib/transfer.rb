require 'pry'
# require_relative './bank_account.rb'

class Transfer

attr_reader :sender, :receiver, :amount, :status

def initialize(sender, receiver, amount)
  @sender = sender
  @receiver = receiver
  @amount = amount
  @status = 'pending'
end

def valid?
  @sender.valid? && @receiver.valid?
end

def execute_transaction
  if @sender.valid? && @sender.balance > @amount && self.status == 'pending'
    @sender.balance -= @amount
    @receiver.balance += @amount
    @status = 'complete'
    @status
  else
    @status = 'rejected'
    "Transaction rejected. Please check your account balance."
  end
end

def reverse_transfer
  if self.status == "complete"
     @sender.balance += @amount
     @receiver.balance -= @amount
     @status = 'reversed'
  else
    "Transaction rejected. Please check your account balance."
    @status = 'rejected'
  end
end

end

# sandy = BankAccount.new("Sandy")
# jill = BankAccount.new("Jill")
# transfer1 = Transfer.new(sandy, jill, 300)
# binding.pry
