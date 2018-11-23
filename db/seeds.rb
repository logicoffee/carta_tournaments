kyoto = Team.create!(
  name: "京大かるた会",
  leader: "京大太郎",
  email: "taro@example.com",
  password: "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now
)

shiga = Tournament.create!(
  name: "滋賀県大会",
  schedule: Time.zone.local(2019, 3, 21),
  venue: "近江勧学館"
)