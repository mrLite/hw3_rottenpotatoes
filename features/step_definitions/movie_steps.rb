# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    # unless Movie.find_by_title(movie[:title])
    #   Movie.create(movie)
    # else
    #   movie[:title].should be Movie.find_by_title(movie[:title])
    # end
  end
  #assert false, "Unimplmemented"
end

Then /I should see all of the movies/ do
  rows.should == 10
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  regexp = Regexp.new ".*#{e1}.*#{e2}"
  page.body.should =~ regexp
  # assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split
  When %Q{I #{uncheck}check "ratings_#{ratings.slice!(0)}"}
  ratings.each do |rating|
    And %Q{I #{uncheck}check "ratings_#{rating}"}
  end
end
