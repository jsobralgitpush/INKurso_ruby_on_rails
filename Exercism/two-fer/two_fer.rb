module TwoFer
  def self.two_fer(options=nil)
    if options == nil
      return "One for you, one for me."
    else 
      return "One for #{options}, one for me."
    end
  end
end
