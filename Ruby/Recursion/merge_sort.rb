# merge_sort.rb


def mergesort(numbers)

  num_elements = numbers.length
  # return numbers if <= 1 (already sorted)
  if num_elements <= 1
    return numbers
  end

  middle = (num_elements / 2).round

  left = mergesort(numbers[0..middle-1])
  right = mergesort(numbers[middle..num_elements])

  merge(left, right)
end

def merge(left, right)
  # if the right array is empty return the left
  if right.empty?
    return left
  end
  # if the left array is empty return the right
  if left.empty?
    return right
  end
  # compare first elements from left and right arrays,
  # continue to merge remainder of smaller half and the 
  # opposing half.
  if left.first < right.first
    [left.first] + merge(left[1..left.length], right)
  else
    [right.first] + merge(left, right[1..right.length])
  end
end

p mergesort([38, 27, 43, 3, 9, 82, 10, 4, 1, 160])