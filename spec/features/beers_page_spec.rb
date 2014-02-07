require 'spec_helper'

include OwnTestHelper

describe "Beers page" do
  let!(:user){ FactoryGirl.create(:user) }
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "should not have any before been created" do
    visit beers_path
    expect(page).to have_content 'List'
  end

  it "should be able to add beer with valid name" do
    #sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    #puts page.html
    fill_in('beer[name]', with:'Yksikkotestikalja')
    page.select('Lager', :from => 'beer[style]')
    page.select('Koff', :from => 'beer[brewery_id]')

    #puts page.html

    expect{
          click_button "Create Beer"
        }.to change{Beer.count}.from(1).to(2)
  end

  it "should not be able to add beer with an invalid name" do
    visit new_beer_path
    fill_in('beer[name]', with:'')
    page.select('Lager', :from => 'beer[style]')
    page.select('Koff', :from => 'beer[brewery_id]')

    #puts page.html

    click_button "Create Beer"
    expect(page).to have_content 'blank'
    expect(Beer.count).to equal(1)


  end


end