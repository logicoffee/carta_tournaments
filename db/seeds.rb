kyoto = Team.create!(
  name: "京大かるた会",
  leader: "京大太郎",
  email: "taro@example.com",
  password: "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now
)

tournament = Tournament.create!(
  name: ENV["TOURNAMENT_NAME"],
  schedule: ENV["TOURNAMENT_SCHEDULE"],
  venue: ENV["TOURNAMENT_VENUE"]
)

initial_admin = tournament.admins.create!(
  name: ENV["ADMIN_NAME"],
  email: ENV["ADMIN_EMAIL"],
  password: "password",
  password_confirmation: "password"
)