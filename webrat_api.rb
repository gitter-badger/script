#!/usr/bin/ruby -w
# canvas_webrat.rb
# Author: Andy Bettisworth
# Description: Canvas webrat gem

:current_url

:within

## Method:
#  @custom_headers[key] = value
:header

## Method:
#  header('Accept', Webrat::MIME.mime_type(mime_type))
:http_accept

## Method:
#  encoded_login = ["#{user}:#{pass}"].pack("m*").gsub(/\n/, '')
#  header('HTTP_AUTHORIZATION', "Basic #{encoded_login}")
:basic_auth

:save_and_open_page

:request_page

:current_dom

:response_body

## Issues a GET request for a page, follows any redirects, and verifies the final page load was successful.
:visit
#   visit "/"

## Reloads the last page requested. This will resubmit forms and their data.
:reload

:fill_in
#   fill_in "Email", with: "user@example.com"
#   fill_in "user[email]", with: "user@example.com"

:check
#   check 'Remember Me'

:uncheck
#   uncheck 'Remember Me'

:choose
#   choose 'First Option'

:select
#   select "January"
#   select "February", from: "event_month"
#   select "February", from: "Event Month"

:unselect
#   unselect "January"
#   unselect "February", from: "event_month"
#   unselect "February", from: "Event Month"

:attach_file
#   attach_file "Resume", "/path/to/the/resume.txt"
#   attach_file "Photo", "/path/to/the/image.png", "image/png"

:click_link
#   click_link "Sign up"
#   click_link "Sign up", javascript: false
#   click_link "Sign up", method: :put

:click_area
#   click_area 'Australia'

:click_button,
#   click_button "Login"
#   click_button

:click_link_within
#   click_link_within "#user_12", "Vote"

## Verify that a field is pre-filled with the correct value.
:field_labeled
#   field_labeled("First name").value.should == "Bryan"

:set_hidden_field
#   set_hidden_field 'user_id', to: 1

:submit_form
#   submit_form 'login'

:select_date
#   select_date "January 23, 2004"
#   select_date "April 26, 1982", from: "Birthday"
#   select_date Date.parse("December 25, 2000"), from: "Event"
#   select_date "April 26, 1982", id_prefix: 'birthday'

:select_time
#   select_time "9:30"
#   select_date "3:30PM", from: "Party Time"
#   select_date Time.parse("10:00PM"), from: "Event"
#   select_date "10:30AM", id_prefix: 'meeting'

:select_datetime
#   select_datetime "January 23, 2004 10:30AM"
#   select_datetime "April 26, 1982 7:00PM", from: "Birthday"
#   select_datetime Time.parse("December 25, 2000 15:30"), from: "Event"
#   select_datetime "April 26, 1982 5:50PM", id_prefix: 'birthday'

## Redirects to the address given at headers["Location"].
:follow_redirect!
#   click_button "Save"
#   follow_redirect!
