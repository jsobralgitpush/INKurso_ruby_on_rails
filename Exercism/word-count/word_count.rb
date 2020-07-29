class Phrase
  def initialize(word)
    @word = word
  end

  def word_count
    array_word = @word.split(' ')
    count_word = {}

    array_word_real = []

    for i in array_word
    end
      

    for i in array_word
      if count_word[i] == nil
        count_word[i] = 1
      else
        count_word[i] +=1
      end
    end

    return count_word

  end


end