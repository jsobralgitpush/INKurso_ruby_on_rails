class Series
  def initialize(numbers)
    @numbers = numbers
  end

  def slices(n)
    array_num = @numbers.split('')

    array_answer = []

    for i in (0..(array_num.length()-n)).to_a
      array_answer.append('')
    end

    j = 0
    a = 0
    b = 0

    while j != (array_answer.length())

      for i in (1..n).to_a

        array_answer[j] += array_num[a]

        if i == n
        else
          a +=1
        end
        
      end
      b +=1
      a = b

      if n == 1
        j  +=n
      else
        j  +=(n-1)
      end
    end

    return array_answer
  end
end
