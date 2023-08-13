Then(/^I(?:| should) see a navigation header$/) do
  page.should have_selector('header.masthead')
end

Then(/^I should see a main content area$/) do
  page.should have_selector('section#main')
end

Then(/^I should see a footer area$/) do
  page.should have_selector('section#footer')
end

Then(/^I should see a navigation bar$/) do
    find ('div.navbar')
end
When(/^I should see "([^"]*)" in footer$/) do |string|
  within('section#footer') do
    page.should have_text string
  end
end

Then /^I should see link$/ do |table|
  table.rows.flatten.each do |link|
    page.should have_link link
  end
end

When(/^the page should include ([^"]*) for ([^"]*)$/) do |tag, content|
  case tag
    when 'script'then
      case content
        when 'Google Analytics' then page.should have_xpath("//script[text()[contains(.,'UA-xxxxxx-x')]]", visible: false)
      end
    when 'css' then page.should have_xpath("//link[contains(@href, '#{content}')]", visible: false)
    when 'js' then page.should have_xpath("//script[contains(@src, '#{content}')]", visible: false)

  end
end

Given /^(.*)? in production mode$/ do |s|
  dummy = Object.new
  Rails.any_instance.should_receive(:env).and_return(dummy)
  dummy.should_receive(:production?).and_return(true)
  step s
end

When /^I go home$/ do
  #visit('http://localhost:3000')
  visit('http://mighty-fortress-9827.herokuapp.com/')
end

Then /^I should see the tracking code$/ do
  page.should have_xpath("//script[text()[contains(.,#{GA.tracker})]]", visible: false)

  #page.body.should match /UA-47795185-1/
end

#Then(/^I should not see a modal$/) do
#  page.should not have_selector('#modal-window', :visible => false)
#end

#Then(/^I should see a modal$/) do
#  page.should have_content('#modal-window', visible => false)
#end

#within(#loginModal) do
#    page.should have_content('a_modal_content_here') # async
#end

Then(/^I should see a modal window with a form "([^"]*)"$/) do |arg|
  sleep 1
  page.should have_content("myModalLabel", visible: true)
end