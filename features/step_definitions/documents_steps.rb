Given(/^the follow documents exist:$/) do |table|
  table.hashes.each do |hash|
    project = Document.create(hash)
    project.save
  end
end
