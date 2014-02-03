require 'spec_helper'

describe Beer do
  it "has name and style set" do
  beer = Beer.create name:"Testikalja", style:"Testimaku"

  expect(beer).to be_valid
  end

end
