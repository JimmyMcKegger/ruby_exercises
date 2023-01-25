# Takes in an array of stock prices, one for each day. Returns a pair of days representing the best day to buy and the best day to sell.

def stock_picker(arr)
  buy = 0
  sell = 0
  profit = 0

  arr.each_with_index do |element, i|
    if arr[i..-1].max - element > profit 
      buy = arr.index(element)
      sell = arr.index(arr[i..-1].max)
      profit = arr[i..-1].max - element
    end
  end

  [buy, sell]
end

#stock_picker([17,3,6,9,15,8,6,1,10])
#=> [1,4]
