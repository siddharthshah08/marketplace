require 'rails_helper'

RSpec.describe Bid, type: :model do
   
  it { should belong_to(:project) }   
  it { should belong_to(:buyer) }
  it { should validate_presence_of(:rate)}

end
