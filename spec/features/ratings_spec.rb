require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  #let!(:rating) {FactoryGirl.create :rating, beer_id: 1, score:15}
  #let!(:rating) {FactoryGirl.create :rating, beer_id: 1, score:20}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  #it "when adding ratings, number of ratings matches" do
  #  visit ratings_path
  #  except(page).to have_content("Number of ratings 2")
  #end


  #Jostain syystä select... kaatuu ajonaikaisesti
  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    page.select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

   expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

end