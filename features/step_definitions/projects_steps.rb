Then(/^I should see a "([^"]*)" table$/) do |legend|
  within('table#projects') do
    page.should have_css('legend', :text => legend)
  end
end

When(/^I should see column "([^"]*)"$/) do |column|
  within('table#projects thead') do
    page.should have_css('th', :text => column)
  end
end

When(/^There are projects in the database$/) do
  #TODO Y use factoryGirl
  Project.create(title: "Title 1", description: "Description 1", status: "Status 1")
  Project.create(title: "Title 2", description: "Description 2", status: "Status 2")
end


Given(/^the follow projects exist:$/) do |table|
  table.hashes.each do |hash|
    project = Project.create(hash)
    project.save
  end
end

Then /^I should see a form for "([^"]*)"$/ do |form_purpose|
  #TODO YA check if capybara has form lookup method
  case form_purpose
    when 'creating a new project'
      page.should have_text form_purpose
      page.should have_css('form#new_project')
    else
      puts 'OOPS YOU MESSED UP!!!'
      save_and_open_page
  end
end


Then(/^the "(.*?)" button works for "(.*?)"$/) do |button, project_title|
  id = Project.find_by_title(project_title).id
  within("tr##{id}") do
    debugger
    expect { click_link button }.to change(Project, :count).by(-1)
  end
end