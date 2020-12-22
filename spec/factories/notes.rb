FactoryBot.define do
  factory :note do
    message {"My important project"}
    association :project
    user { project.owner }
  end
end
