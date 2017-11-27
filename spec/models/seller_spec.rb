require 'rails_helper'

RSpec.describe Seller, type: :model do  
  it { should have_many(:projects).dependent(:destroy) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:uname) }
  it { should validate_uniqueness_of(:uname).case_insensitive }
end
