require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  before(:each) do
    person.phone_numbers.create(number: "555-1234")
    person.phone_numbers.create(number: "555-5678")
    visit person_path(person)
  end

  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it 'has a link to add a new phone number' do
    expect(page).to have_link('Add Phone Number', href: new_phone_number_path(person_id: person.id))
  end

  it 'has a link to delete a phone number' do 
    expect(page).to have_link('Delete')
  end

  it 'adds a new phone number' do 
    page.click_on('Add Phone Number')
    page.fill_in('Number', with: '555-8888')
    page.click_on('Create Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('555-8888')
  end

end

