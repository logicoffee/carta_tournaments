kyoto = Team.create!(
  name: "京大かるた会",
  leader: "京大太郎",
  email: "taro@example.com",
  password: "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now
)