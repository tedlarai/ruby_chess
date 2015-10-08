module Pieces
  def self.path_range(num1, num2) #returns all numbers between them, in the same order as nums
    if num1 > num2
      self.path_range(num2, num1).reverse
    else
      Array(num1..num2)[1..-2]
    end
  end
end
