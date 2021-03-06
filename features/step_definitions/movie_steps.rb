# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie["title"], :rating => movie["rating"], :release_date => movie["release_date"])  
  end
#flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should (not )?see "(.*)" before "(.*)"/ do |i_should_not_see, e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  puts e1 + " " + page.body.index(e1).inspect + " " + e2 + " " + page.body.index(e2).inspect
  puts (i_should_not_see && (page.body.index(e1) > page.body.index(e2))).inspect
  i_should_not_see ? page.body.index(e1).should > page.body.index(e2) : page.body.index(e1).should < page.body.index(e2) 
# flunk "Unimplemented"
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list = rating_list.split(',')
  rating_list.each do |rating|
    field_name = "ratings_" + rating.lstrip
    uncheck ? uncheck(field_name) : check(field_name)
  end
end
  
Then /I should see all of the movies/ do 
  rows = page.all("table#movies tr").count
  rows.should == Movie.count(:title) + 1
end

