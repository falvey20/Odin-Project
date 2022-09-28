# fibonacci_recursion.rb

def fibs(num)
  return num if num <= 2
  result = [0, 1]
  until result.length == num
    result.push(result[-1]+result[-2])
  end
  return result
end

def fibs_rec(num, seq = [0, 1])
  return seq if num <= 2
  seq << seq[-1] + seq[-2]
  fibs_rec(num-1, seq)
end

p fibs(8)
p fibs_rec(8)