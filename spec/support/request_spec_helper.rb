module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
     #puts "response.body : #{response.body.inspect}"
     return false if !response.body.present? or response.body.nil? or response.body == "null"
     a = JSON.parse(response.body) 
     #puts "a : #{a.inspect}"
     return a
  end
end
