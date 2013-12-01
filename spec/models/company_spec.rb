require 'spec_helper'

describe Company do
  let(:basedirectory) { Company.create(name: "BaseDirectory.com") }

  it "is valid" do
    expect(basedirectory).to be_valid
  end

  it "is invalid without a name" do 
    basedirectory.name = nil
    expect(basedirectory).not_to be_valid
  end

  it "responds with its phone numbers after they're created" do
    phone_number = basedirectory.phone_numbers.build(number: "333-4444")
    expect(phone_number.number).to eq('333-4444')
  end

end
