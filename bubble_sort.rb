# bubble sorting

def bubble_sort(arr)
  len = arr.length
  if len < 1
    arr
  else

    no_change = true
    i = 0
    while true
      if i + 1 >= len && no_change
        break
      elsif i + 1 >= len
        i = 0
        no_change = true
      elsif arr[i] > arr[i+1]
        no_change = false
        arr[i], arr[i+1] = arr[i+1], arr[i]
        i += 2
      else
        i += 1
      end
    end

    arr
  end
end
