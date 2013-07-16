namespace :db do
  desc "Fill database with initial data"
  task populate: :environment do
    make_users
    make_students
    make_activities
    make_rewards
  end
end

def make_users
  admin = User.create!(username:              "drrajshah",
                       email:                 "raj@mathplusacademy.com",
                       password:              "mathplus",
                       password_confirmation: "mathplus")
  admin.toggle!(:admin)

  User.create!(         first_name:           "shefali",
                        email:                "rajandshefali@gmail.com",
                        password:             "helium44",
                        password_confirmation:"helium44")

end

def make_students
  student1 = Student.create!(username:        "jadenshah",
                       email:                 "jadenrshah@gmail.com",
                       xp_gained:             "0"
                       xp_spent:              "0"
                       xp_current:            "0"
                       password:              "jadenshah",
                       password_confirmation: "jadenshah")

  student1 = Student.create!(username:        "rianshah",
                       email:                 "rianrshah@gmail.com",
                       xp_gained:             "0"
                       xp_spent:              "0"
                       xp_current:            "0"
                       password:              "rianshah",
                       password_confirmation: "rianshah")
end

def make_activities
  Activity.create!(name:            "Made Bed",
                   description:     "Made my bed before starting my day",
                   category:        "Expectations",
                   activity_xp:     "10",
                   active:          true)
end

def make_rewards
  Activity.create!(name:            "Extra Video Game Time",
                   description:     "15 minute bonus time",
                   xp_cost:         "10",
                   active:          true)
end
