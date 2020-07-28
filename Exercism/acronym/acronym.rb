module Acronym
  def self.abbreviate(acronym=nil)
    short_word = ""
    for i in acronym.split(' ')
      for j in i.split('-')
        short_word += j[0].capitalize()
      end
    end

    return short_word
  end
end
