#Giving

[![Code Climate](https://codeclimate.com/github/drueck/giving.png)](https://codeclimate.com/github/drueck/giving)

Giving is a web application designed for churches or other non-profits who need a very
simple way to track contributions and generate annual giving statements.

The 0.1.0 release ran on Rails 3 but I have since then updated it for Rails 4. It's
in a pretty messy state right now, but I hope to tag another release when I have had the
chance to improve the test coverage and refactor some ugly parts.

Anyway, feel free to grab it and try it out if you're interested. If you have come across
it and think it might be useful for your church or organization but need some help getting
it installed somewhere, feel free to hit me up on twitter [@davidrueck](https://twitter.com/davidrueck).

I haven't gotten around to writing up any installation instructions, but here's a simple
guide on how to actually use it. Not that it's complex enough really to necessitate a guide!


##User Guide

###Editing Organization Information
- Click Organization
- Fill out the name, address and phone number for your organization
- Click Save. This data will be used on statements, so be sure to do this when you first
  set up the app.

###Adding a Batch of Contributions
- Click on New Batch from the main menu, or Contributions, New Batch from the top menu.
  This will bring you to a screen where you can enter a name for the batch or leave it blank
  to just use the batch number. Click Begin to start adding contributions.
- Add each contribution using the form at the top of the page, following the
  instructions in Adding a Contribution below.
- When you have added all of the contributions you want to include in your batch you
  have the option of generating a PDF report of the batch by clicking Batch Report PDF,
  which you and save or print as needed.
- You can create and switch between as many batches as you need and can re-open a batch at
  any time and add, edit or delete contributions from it.

###Adding a Contribution
- Select the Contributor by beginning to type in their name. Matches should start
  popping up. Select the correct contributor when they show up in the list.
  If the contributor does not show up, you will need to add them to the Contributors
  list by following the instructions in Adding a Contributor below.
- Select the contribution date using the calendar control, or by typing it in in MM/DD/YYYY format.
- Enter the amount, select the payment type, and optionally enter a reference, such as a check number.
- Hit <ENTER> or click Add to add the contribution to the batch.

###Adding a Contributor
- Click Contributors on the top menu.
- Click New Contributor at the bottom of that screen.
- Fill in at least the name field and optionally the rest.
- Click Save.

###Working with Previously Created Batches
- Click on Contributions, All Batches from the top menu to list all previously
  created batches. Click on one of them to open it again and view/edit/delete contributions
  and/or generate a Batch Report PDF.

###Editing Contributor Details or Contributions
- Click on Contributors on the top menu. To find a contributor without scrolling through
  all of them, you can use the search field at the top of that screen. You can enter the
  contributor's first name, last name or full name and hit enter or click Search to filter
  the list. (Note: If you click search with no name in the search box, it will show all
  contributors again). Once you have found the contributor you're looking for, click on
  their name. This will bring you to a screen where you can edit their information, view their
  contributions and if necessary correct a contribution.

###Managing Individual Contributions
- If you need to post an individual contribution outside of a batch (though that is not
  preferred) or edit one that you recently posted and that was incorrect, you can do both
  of those things by going to Contributions, All Posted Contributions from the main menu.

###Generating Annual Statments
- Click on Statements on the top menu
- Select the Year
- Enter in a message to the contributor that will be displayed at bottom of each statement.
  For example, you might want to thank them for their contributions and provide your
  organization's federal tax id number, etc.
- Click Submit, which will generate a PDF of the statements for all contributors for the
  selected year. Use the tools your browser provides to save and/or print the statements,
  then use your browser's back button to go back to the app if desired.
- Note: The return address and phone number on the statements is taken from the
  Organization information which can be accessed/edited by clicking Organization on the
  top menu.


##Contributing (code, ideas, etc)

I'd welcome any contributions if you feel so inclined. :)
