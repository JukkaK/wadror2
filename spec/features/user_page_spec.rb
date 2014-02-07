require 'spec_helper'

include OwnTestHelper

describe "User page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:toinenuser) { FactoryGirl.create :user2 }
  let!(:rating) {FactoryGirl.create :rating, beer:beer1, score:15, user: user}
  let!(:toinenrating) {FactoryGirl.create :rating, beer:beer2, score:15, user: toinenuser}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "should only show this users ratings" do
    visit user_path(user)
    expect(page).to have_content 'has made 1 rating'
  end

  it "should be able to delete rating" do
    expect(user.ratings.count).to equal(1)
    visit user_path(user)
    click_on("delete")
    #page.driver.browser.switch_to.alert.accept
    expect(user.ratings.count).to equal(0)
    expect(page).to have_content 'has not yet made ratings'
  end



end