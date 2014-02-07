require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating) {FactoryGirl.create :rating, beer:beer2, score:15, user: user}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when adding ratings, number of ratings matches" do
    visit ratings_path
    expect(page).to have_content("Number of ratings 1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    page.select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    beer = Beer.find_by name:"iso 3"

    expect{
      click_button "Create Rating"
    }.to change{beer.ratings.count}.from(0).to(1)

   expect(user.ratings.count).to eq(2)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

end