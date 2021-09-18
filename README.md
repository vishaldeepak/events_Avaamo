# README

Project has been worked according to the given requirements in the PDF File

Main Takeaways are
- Project is built to process lots of csvs
- Project expect csv to be proper, errors are not recorded and are skipped
- Use ActiveRecord-Import gem to accelerate the insertion process. We minimise the number of hits to database as much as possible
- Find the actual code that processes csvs in  `ProcessCsv::Users` and `ProcessCsv::Events`
- To make csv load faster one of the main conditions `A user can choose to attend an event, in such case, if there is another overlapping event for the same user, it should automatically update the rsvp as 'no'`. For this we switch to triggers instead of the rails model callbacks. Trigger is found at `db/migrate/20210917050119_create_rsvp_trigger.rb` The idea of trigger is to set any other user clashing event to 'no' before insertion of new row. We might eventually want to move this logic to Rails model to have better control.
- **Another big change** is that enddate for all_day events are **not** set as nil. Instead on ruby we calculate what the enddate would have been. This will makes things a lot easier for processing collissions.
- Everything else should be fairly straightforward. We use boostrap for design.
- Model handle a lot of logic required per requirement
- `_slot_availability.html.erb` peforms slots processing.
- Applied required indexes

Running Project
- Similar to any other rails project
- Run bundle
- Run `db:create` and `db:migrate`
- Run `db:seed` to load the csv files given for the assignment
- The run your own csv file from `rails console` run `ProcessCsv::Users.new(file_path: 'location')` for Users. `ProcessCsv::Events.new(file_path: 'location')` for Events

Assumptions
- CSV are fairly correct. No errors shown
- We show UI in UTC time.
- User 2 hour sloted shown for full 24 hours.
- Pagination not considered due to timimg constraints