Given(/^a project$/) do
  user = User.create(email: "user@example.com", password: "password", 
    admin: true)
  log_in_as(user)
  @project = Project.create(name: "Bluebook")
  @project.tasks.create(title: "Hunt the Aliens", size: 1, project_order: 1,
    user_id: user.id)
  @project.tasks.create(title: "Write a Book", size: 1, project_order: 2,
    user_id: user.id)
end

def log_in_as(user)
  visit new_user_session_path
  fill_in("user_email", with: user.email)
  fill_in("user_password", with: user.password)
  click_button("Log in")
end

When(/^I visit the project page$/) do
  visit project_path(@project)
end

When(/^I complete the new task form$/) do
  fill_in "Task", with: "Find UFOs"
  select "2", from: "Size"
  click_on "Add Task"
end

Then(/^I am back on the project page$/) do
  expect(current_path).to eq(project_path(@project))
end

Then(/^I see the new task is last in the list$/) do
  @added_task = @project.tasks.last
  within("#task_#{@added_task.id}") do
    expect(page).to have_selector(".name", text: "Find UFOs")
    expect(page).to have_selector(".size", text: "2")
    expect(page).to have_no_selector("a", text: "Down")
  end
end

When(/^I click to move the new task up$/) do
  within("#task_#{@added_task.id}") do
    click_on("Up")
  end
end

Then(/^the new task is in the middle of the list$/) do
  expect(page).to have_selector("tbody:nth-child(2) .name", text: "Find UFOs")
end