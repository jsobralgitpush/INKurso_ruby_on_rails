module ResistorColorDuo
  def self.value(options = [])
    num_string = ""

    for i in options
      if i == "black" 
        num_string += "0"
      elsif i == "brown" 
        num_string +="1"
      elsif i == "red" 
        num_string +="2"
      elsif i == "orange" 
        num_string +="3"
      elsif i == "yellow" 
        num_string +="4"
      elsif i == "green" 
        num_string +="5"
      elsif i == "blue" 
        num_string +="6"
      elsif i == "violet" 
        num_string +="7"
      elsif i == "grey" 
        num_string +="8"
      elsif i == "white" 
        num_string +="9"
      end
      
      if num_string.length() == 2
        return num_string.to_i
      end
    
    end  

  end
end
