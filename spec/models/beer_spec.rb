require 'spec_helper'

describe Beer do
  it "has name and style set" do
  beer = Beer.create name:"Testikalja", style:"Testimaku"

  expect(beer).to be_valid
  end

  it "does not have a name" do
    beer = Beer.create style:"Testimaku"

    expect(beer).not_to be_valid
  end

  it "does not have a style" do
    beer = Beer.create name:"Testikalja"

    expect(beer).not_to be_valid
  end




end
