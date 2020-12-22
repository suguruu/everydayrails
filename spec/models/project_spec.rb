require 'rails_helper'

RSpec.describe Project, type: :model do

  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "jot",
      last_name: "jojo",
      email: "tes@example.com",
      password: "passwoedd"
    )

    user.projects.create(
      name: "test project"
    )

    new_project = user.projects.build(
      name: "test project"
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows two users to share a project name" do
    user = User.create(
      first_name: "jojo",
      last_name: "jo",
      email: "example@exampkdajf",
      password: "passwowowo"
    )

    user.projects.create(
      name: "test pro"
    )

    other_user = User.create(
      first_name: "jo",
      last_name: "jojo",
      email: "jap@ca.com",
      password: "apadfajsdf"
    )

    other_project = other_user.projects.create(
      name: "test pro"
    )

    expect(other_project).to be_valid
  end

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end
end
