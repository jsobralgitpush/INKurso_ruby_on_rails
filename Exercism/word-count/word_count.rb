class Phrase
  def initialize(word)
    @word = word
  end

  def word_count
    array_word = @word.split(' ')
    count_word = {}
    
    array_word_1 = []
    array_word_final = []

    #Make all strings go downcase
    for i in array_word
      array_word_1.append(i.downcase)
    end

    #Remove ','
    if array_word_1.length() == 1
      array_word_1 = array_word_1[0].split(',')
    end


    #Remove '.' ':' '!' "'"
    for i in array_word_1

      no_point = i.split('.')[0]
      no_two_points = no_point.split(':')[0]
      no_exclamation = no_two_points.split('!')[0]
      
      if no_exclamation[0] == "'"
        no_quotation = no_exclamation.split("'")[1]
        array_word_final.append(no_quotation)
      else
        array_word_final.append(no_exclamation)
      end 

    end

    array_word_final.each_with_index do |value, index|
      array_word_final[index] = value.split(',')[0]
    end


    for i in array_word_final
      if count_word[i] == nil
        count_word[i] = 1
      else
        count_word[i] +=1
      end
    end

    return count_word

  end


end