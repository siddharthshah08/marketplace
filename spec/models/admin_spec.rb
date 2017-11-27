require 'rails_helper'

RSpec.describe Admin, type: :model do
   
  it { should validate_presence_of(:uname) }
  it { should validate_uniqueness_of(:uname).case_insensitive }
  it { should validate_presence_of(:password) }
end
