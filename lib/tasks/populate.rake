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
  User.create!(username:              "drrajshah",
               email:                 "raj@mathplusacademy.com",
               password:              "mathplus",
               password_confirmation: "mathplus",
               admin:                 true)

  User.create!(         username:             "shefali",
                        email:                "rajandshefali@gmail.com",
                        password:             "helium44",
                        password_confirmation:"helium44")

end

def make_students
  Student.create!(username:              "jadenshah",
                  email:                 "jadenrshah@gmail.com",
                  user_id:               "1", 
                  xp_gained:             "0",
                  xp_used:               "0",
                  xp_current:            "0",
                  password:              "jadenshah",
                  password_confirmation: "jadenshah")

  Student.create!(username:              "rianshah",
                  email:                 "rianrshah@gmail.com",
                  user_id:               "1", 
                  xp_gained:             "0",
                  xp_used:               "0",
                  xp_current:            "0",
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
  Reward.create!(name:            "Extra Video Game Time",
                   description:     "15 minute bonus time",
                   xp_cost:         "10",
                   active:          true)
end
