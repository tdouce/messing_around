# Ruby 1.9.3
# Rolling my own 'bubble sort'

class Array

  def bubble_sort
    _bubble_sort(self)
  end

  private

  def _bubble_sort(array, sorted = false, slice_at = 0)
    if sorted
      return array 
    else
      sorted = true 
      
      root = array[0...(array.length - slice_at)]
      tail = array[(array.length - slice_at)...array.length] 

      root.each_with_index do |current_number, current_index|
        next_index  = current_index + 1
        next_number = root[next_index]

        if !next_number.nil? && current_number > next_number 
          root[current_index] = next_number
          root[next_index]    = current_number
          sorted = false 
        end
      end
      _bubble_sort(root.concat(tail), sorted, slice_at + 1)
    end
  end
end


print [8,5,7,2,0,6,3,4,1,3].bubble_sort



