class HighScores
  def initialize(score)
    @score = score
  end

  def scores
    return @score
  end

  def latest
    return @score[-1]
  end

  def personal_best
    return (@score.sort())[-1]
  end

  def personal_top_three

    i = @score.sort()

    if @score.length >= 3
      first = i[-1]
      second = i[-2]
      third = i[-3]
      
      return array_answer = [first, second, third]

    elsif @score.length == 2 
      first = i[-1]
      second = i[-2]

      return array_answer = [first, second]

    elsif @score.length == 1
      first = i[-1]

      return array_answer = [first]
    end
  end

  def latest_is_personal_best?
    if @score[-1] == (@score.sort())[-1]
      return true
    else
      return false
    end
  end

end