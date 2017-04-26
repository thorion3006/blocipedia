require 'random_data'

FactoryGirl.define do
  factory :user do
    email RandomData.random_email
    password RandomData.random_sentence
  end
end
