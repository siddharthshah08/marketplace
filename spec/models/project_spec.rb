require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should belong_to(:seller) }
  it { should have_many(:bids).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:starts_at)}
  it {should validate_presence_of(:ends_at)}

  it {should validate_presence_of(:accepting_bids_till)}


end
