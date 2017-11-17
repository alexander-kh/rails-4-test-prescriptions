require 'rails_helper'

describe "projects/index" do
  let(:user) { User.create!(email: "rspec@example.com", password: "password") }
  let(:on_schedule) { user.projects.create!(due_date: 1.year.from_now,
    name: "On Schedule") }
  let(:behind_schedule) { user.projects.create!(due_date: 1.day.from_now,
    name: "Behind Schedule") }
  
  before(:example) do
    on_schedule.tasks.create!(completed_at: 1.day.ago, size: 1, user_id: user.id)
    behind_schedule.tasks.create!(size: 1, user_id: user.id)
  end
  
  it "renders the index page with correct dom elements" do
    @projects = [on_schedule, behind_schedule]
    render
    expect(rendered).to have_selector(
      "#project_#{on_schedule.id} .on_schedule")
    expect(rendered).to have_selector(
      "#project_#{behind_schedule.id} .behind_schedule")
  end
end