class Series
  def initialize(numbers)
    @numbers = numbers
  end

  def slices(n)
    array_num = @numbers.split('')

    array_answer = []
    array_inside = []

    for i in (0..(n-1)).to_a
      array_inside.append(array_num[i])
    end

    array_answer.append(array_inside)


  end
end
