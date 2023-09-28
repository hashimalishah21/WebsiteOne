Then /^I should see hangout button$/ do
  src = page.find(:css,'#liveHOA-placeholder iframe')['src']
  expect(src).to match /talkgadget.google.com/
end

Then /^the hangout button should( not)? be visible$/ do |negative|
  placeholder = page.find(:css,'#liveHOA-placeholder')
  if negative
    expect(placeholder['display']).to eq('none')
  else
    expect(placeholder['display']).to eq('block')
  end
end

Then /^I should see link "([^"]*)" with "([^"]*)"$/ do |link, url|
  expect(page).to have_link(link, href: url)
end

Given /^the Hangout for event "([^"]*)" has been started with details:$/ do |event_name, table|
  ho_details = table.transpose.hashes
  hangout = ho_details[0]
  event = Event.find_by_name(event_name)
  #event.hangout_url.should_receive(present?).and_return(TRUE)
  ho = Hangout.create(event_id: event.id.to_s,
               hangout_url: hangout['Hangout link'])
  event.url = ho.hangout_url if ho.hangout_url.present?
end

Then /^I should see restart button$/ do
  src = page.find(:css,'#liveHOA-placeholder iframe')['src']
  expect(src).to match /talkgadget.google.com/
end


And(/^I should( not)? see Hangouts_Details_Section$/) do |negative|
  if negative
    expect(page).not_to have_css('#hangout_details')
  else
    expect(page).to have_css('#hangout_details')
  end
end