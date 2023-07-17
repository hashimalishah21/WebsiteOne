require 'spec_helper'

describe 'devise/registrations/edit.html.erb' do
  before(:each) do
    #stubbing out devise methods
<<<<<<< HEAD
    view.stub(:resource).and_return(User.new)
    view.stub(:resource_name).and_return('user')
    view.stub(:devise_mapping).and_return(Devise.mappings[:user])
=======
    view.should_receive(:resource).at_least(1).times.and_return(User.new)
    view.should_receive(:resource_name).at_least(1).times.and_return('user')
    view.should_receive(:devise_mapping).and_return(Devise.mappings[:user])
>>>>>>> 044c5d98f53862a24029637539776e284fa990b4
  end

  it 'shows required labels' do
    render
    expect(rendered).to have_text('Edit your user details:')
<<<<<<< HEAD
    expect(rendered).to have_text('First name')
    expect(rendered).to have_text('Last name')
=======
>>>>>>> 044c5d98f53862a24029637539776e284fa990b4
    expect(rendered).to have_text('Email')
    expect(rendered).to have_text('Password')
    expect(rendered).to have_text('Password confirmation')
    expect(rendered).to have_text('Current password')
    expect(rendered).to have_text('Unhappy?')
  end
<<<<<<< HEAD
=======

  it 'shows required user fields' do
    render
    expect(rendered).to have_field('Email')
    expect(rendered).to have_field('Password')
    expect(rendered).to have_field('Password confirmation')
    expect(rendered).to have_field('Current password')
  end

  it 'shows avatar image' do
    view.stub(:gravatar_for).and_return('img_link')
    render
    expect(rendered).to have_css('img')
    expect(rendered).to have_xpath("//img[contains(@src, 'img_link')]")
  end
>>>>>>> 044c5d98f53862a24029637539776e284fa990b4

  it 'shows required user fields' do
    render
    expect(rendered).to have_field('First name')
    expect(rendered).to have_field('Last name')
    expect(rendered).to have_field('Email')
    expect(rendered).to have_field('Password')
    expect(rendered).to have_field('Password confirmation')
    expect(rendered).to have_field('Current password')
  end

<<<<<<< HEAD
  it 'shows avatar image' do
    view.stub(:gravatar_for).and_return('img_link')
    render
    expect(rendered).to have_css('img')
    expect(rendered).to have_xpath("//img[contains(@src, 'img_link')]")
  end


  it 'shows Update button' do
    render
    expect(rendered).to have_button('Update')

  end

  it 'shows Cancel my account button' do
    render
    expect(rendered).to have_button('Cancel my account')
  end

=======
  it 'shows Update button' do
    render
    expect(rendered).to have_button('Update')

  end

  it 'shows Cancel my account button' do
    render
    expect(rendered).to have_button('Cancel my account')
  end

>>>>>>> 044c5d98f53862a24029637539776e284fa990b4
  it 'shows Back button' do
    render
    expect(rendered).to have_link('Back')
  end
<<<<<<< HEAD

  it '#devise_error_messages_flash shows error messages ' do
    user = User.new
    user.password = ''
    user.save

    view.stub(:resource).and_return(user)

    render
    expect(rendered).to have_text("Password can't be blank")
  end
=======
>>>>>>> 044c5d98f53862a24029637539776e284fa990b4

end



