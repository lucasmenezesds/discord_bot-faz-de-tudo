module TibiaUtilsLootDataFixtures
  def self.loot_message_2_players # OK
    "Session data: From 2020-08-14, 21:13:51 to 2020-08-14, 22:38:39
Session: 01:24h
Loot Type: Leader
Loot: 200,000
Supplies: 150,000
Balance: 50,000
Player 1
    Loot: 200,000
    Supplies: 50,000
    Balance: 150,000
    Damage: 244,803
    Healing: 5,842
Player 2 (Leader)
    Loot: 0
    Supplies: 100,000
    Balance: -100,000
    Damage: 368,298
    Healing: 409,857"
  end

  def self.parsed_loot_message_2_players
    { "hunt_info" => { "Session data" => "From 2020-08-14 21:13:51 to 2020-08-14 22:38:39",
                       "Session" => "01:24h",
                       "Loot Type" => "Leader",
                       "Loot" => "200000",
                       "Supplies" => "150000",
                       "Balance" => "50000" },
      "players_balance" => [
        { "Balance" => "150000", "Damage" => "244803", "Healing" => "5842", "Loot" => "200000", "Supplies" => "50000", "name" => "Player 1" },
        { "Balance" => "-100000", "Damage" => "368298", "Healing" => "409857", "Loot" => "0", "Supplies" => "100000", "name" => "Player 2 (Leader)" },
      ]
    }
  end

  def self.final_balance_for_2_players
    {
      "hunt_session" => "From 2020-08-14 21:13:51 to 2020-08-14 22:38:39",
      "share_per_player" => '25,000',
      "number_of_players" => 2,
      "amount_to_transfer" => {
        "Player 2 (Leader)" => 125000,
      },
      "centralizing_payments" => []
    }
  end

  def self.loot_message_3_players
    "Session data: From 2020-08-14, 21:13:51 to 2020-08-14, 22:38:39
Session: 01:24h
Loot Type: Leader
Loot: 253,772
Supplies: 269,082
Balance: -15,310
Player 1
    Loot: 253,772
    Supplies: 47,804
    Balance: 205,968
    Damage: 244,803
    Healing: 5,842
Player 2 (Leader)
    Loot: 0
    Supplies: 178,982
    Balance: -178,982
    Damage: 368,298
    Healing: 409,857
Player 3
    Loot: 0
    Supplies: 42,296
    Balance: -42,296
    Damage: 259,886
    Healing: 19,483"
  end

  def self.parsed_loot_message_3_players
    { "hunt_info" => { "Session data" => "From 2020-08-14 21:13:51 to 2020-08-14 22:38:39",
                       "Session" => "01:24h",
                       "Loot Type" => "Leader",
                       "Loot" => "253772",
                       "Supplies" => "269082",
                       "Balance" => "-15310" },
      "players_balance" => [
        { "Balance" => "205968", "Damage" => "244803", "Healing" => "5842", "Loot" => "253772", "Supplies" => "47804", "name" => "Player 1" },
        { "Balance" => "-178982", "Damage" => "368298", "Healing" => "409857", "Loot" => "0", "Supplies" => "178982", "name" => "Player 2 (Leader)" },
        { "Balance" => "-42296", "Damage" => "259886", "Healing" => "19483", "Loot" => "0", "Supplies" => "42296", "name" => "Player 3" }
      ]
    }
  end

  def self.final_balance_for_3_players
    {
      "hunt_session" => "From 2020-08-14 21:13:51 to 2020-08-14 22:38:39",
      "share_per_player" => '-5,104',
      "number_of_players" => 3,
      "amount_to_transfer" => {
        "Player 2 (Leader)" => 173878,
        "Player 3" => 37192
      },
      "centralizing_payments" => []
    }
  end

  def self.loot_message_4_players # OK
    "Session data: From 2020-08-12, 08:27:28 to 2020-08-12, 10:58:09
Session: 02:30h
Loot Type: Leader
Loot: 1,592,476
Supplies: 1,112,891
Balance: 479,585
Player 1
    Loot: 15,350
    Supplies: 236,009
    Balance: -220,659
    Damage: 1,628,052
    Healing: 46,777
Player 2
    Loot: 1,576,326
    Supplies: 223,958
    Balance: 1,352,368
    Damage: 2,500,986
    Healing: 189,477
Player 3 (Leader)
    Loot: 800
    Supplies: 512,573
    Balance: -511,773
    Damage: 2,004,618
    Healing: 1,384,333
Player 4
    Loot: 0
    Supplies: 140,351
    Balance: -140,351
    Damage: 1,416,410
    Healing: 154,936"
  end

  def self.parsed_loot_message_4_players
    { "hunt_info" =>
        { "Balance" => "479585",
          "Loot" => "1592476",
          "Loot Type" => "Leader",
          "Session" => "02:30h",
          "Session data" => "From 2020-08-12 08:27:28 to 2020-08-12 10:58:09",
          "Supplies" => "1112891"
        },
      "players_balance" => [
        { "Balance" => "-220659", "Damage" => "1628052", "Healing" => "46777", "Loot" => "15350", "Supplies" => "236009", "name" => "Player 1" },
        { "Balance" => "1352368", "Damage" => "2500986", "Healing" => "189477", "Loot" => "1576326", "Supplies" => "223958", "name" => "Player 2" },
        { "Balance" => "-511773", "Damage" => "2004618", "Healing" => "1384333", "Loot" => "800", "Supplies" => "512573", "name" => "Player 3 (Leader)" },
        { "Balance" => "-140351", "Damage" => "1416410", "Healing" => "154936", "Loot" => "0", "Supplies" => "140351", "name" => "Player 4" }
      ]
    }
  end

  def self.final_balance_for_4_players
    {
      "hunt_session" => "From 2020-08-12 08:27:28 to 2020-08-12 10:58:09",
      "share_per_player" => '119,896',
      "number_of_players" => 4,
      "amount_to_transfer" => {
        "Player 1" => 340555,
        "Player 3 (Leader)" => 631669,
        "Player 4" => 260247
      },
      "centralizing_payments" => []
    }
  end

  def self.parsed_loot_message_3_players_with_multiple_payments
    { "hunt_info" =>
        { "Balance" => "90000",
          "Loot" => "300000",
          "Loot Type" => "Leader",
          "Session" => "02:30h",
          "Session data" => "From 2020-08-12 08:27:28 to 2020-08-12 10:58:09",
          "Supplies" => "1112891"
        },
      "players_balance" => [
        { "Balance" => "80000", "Loot" => "100000", "Supplies" => "10000", "name" => "Player 1", "Damage" => "0", "Healing" => "0" },
        { "Balance" => "180000", "Loot" => "200000", "Supplies" => "20000", "name" => "Player 2", "Damage" => "0", "Healing" => "0" },
        { "Balance" => "-170000", "Loot" => "0", "Supplies" => "170000", "name" => "Player 3 (Leader)", "Damage" => "0", "Healing" => "0" },
      ]
    }
  end

  def self.final_balance_for_3_players_with_multiple_payments
    {
      "hunt_session" => "From 2020-08-12 08:27:28 to 2020-08-12 10:58:09",
      "share_per_player" => '30,000',
      "number_of_players" => 3,
      "amount_to_transfer" => {
        "Player 3 (Leader)" => 200000,
      },
      "centralizing_payments" => [
        {
          "from" => "Player 1",
          "to" => "Player 2",
          "amount" => 50000
        }
      ]
    }
  end

  def self.parsed_loot_message_4_players_with_multiple_payments
    { "hunt_info" =>
        { "Balance" => "120000",
          "Loot" => "400000",
          "Loot Type" => "Leader",
          "Session" => "02:30h",
          "Session data" => "From 2020-08-12 08:27:28 to 2020-08-12 10:58:09",
          "Supplies" => "1112891"
        },
      "players_balance" => [
        { "Balance" => "80000", "Loot" => "100000", "Supplies" => "20000", "name" => "Player 1", "Damage" => "0", "Healing" => "0" },
        { "Balance" => "80000", "Loot" => "100000", "Supplies" => "20000", "name" => "Player 2", "Damage" => "0", "Healing" => "0" },
        { "Balance" => "-220000", "Loot" => "0", "Supplies" => "220000", "name" => "Player 3 (Leader)", "Damage" => "0", "Healing" => "0" },
        { "Balance" => "180000", "Loot" => "200000", "Supplies" => "20000", "name" => "Player 4", "Damage" => "0", "Healing" => "0" },
      ]
    }
  end

  def self.final_balance_for_4_players_with_multiple_payments
    {
      "hunt_session" => "From 2020-08-12 08:27:28 to 2020-08-12 10:58:09",
      "share_per_player" => '30,000',
      "number_of_players" => 4,
      "amount_to_transfer" => {
        "Player 3 (Leader)" => 250000,
      },
      "centralizing_payments" => [
        {
          "from" => "Player 1",
          "to" => "Player 4",
          "amount" => 50000
        },
        {
          "from" => "Player 2",
          "to" => "Player 4",
          "amount" => 50000
        }
      ]
    }
  end

  def self.invalid_parsed_loot_message_players_balance
    { "hunt_info" => { "Session data" => "From 2020-08-14 21:13:51 to 2020-08-14 22:38:39",
                       "Session" => "01:24h",
                       "Loot Type" => "Leader",
                       "Loot" => "253772",
                       "Supplies" => "269082",
                       "Balance" => "-15310" },
      "players_balance" => [
        { "Balance" => "205968", "Damage" => "244803", "Healing" => "5842", "Loot" => "253772", "Supplies" => "47804", "name" => "Player 1" },
        { "Balance" => "-178982", "Damage" => "368298", "Healing" => "409857", "Loot" => "0", "Supplies" => "178982", "name" => "Player 2 (Leader)" },
        { "Balance1" => "-42296", "Damage" => "259886", "Healing" => "19483", "Loot" => "0", "Supplies" => "42296", "name" => "Player 3" }
      ]
    }
  end

  def self.invalid_parsed_loot_message_hunt_info
    { "hunt_info" => { "Session data" => "From 2020-08-14 21:13:51 to 2020-08-14 22:38:39",
                       "Session" => "01:24h",
                       "Loot Type" => "Leader",
                       "Loot" => "253772",
                       "Balance" => "-15310" },
      "players_balance" => [
        { "Balance" => "205968", "Damage" => "244803", "Healing" => "5842", "Loot" => "253772", "Supplies" => "47804", "name" => "Player 1" },
        { "Balance" => "-178982", "Damage" => "368298", "Healing" => "409857", "Loot" => "0", "Supplies" => "178982", "name" => "Player 2 (Leader)" },
        { "Balance" => "-42296", "Damage" => "259886", "Healing" => "19483", "Loot" => "0", "Supplies" => "42296", "name" => "Player 3" }
      ]
    }
  end


  def self.loot_message_4_v2_players
    "Session data: From 2020-10-10, 06:00:44 to 2020-10-10, 07:23:18
Session: 01:22h
Loot Type: Leader
Loot: 816,876
Supplies: 376,078
Balance: 440,798
Player 1
    Loot: 523,273
    Supplies: 58,599
    Balance: 464,674
    Damage: 480,353
    Healing: 12,415
Player 2
    Loot: 158,735
    Supplies: 108,077
    Balance: 50,658
    Damage: 902,383
    Healing: 172,778
Player 3 (Leader)
    Loot: 1,300
    Supplies: 136,131
    Balance: -134,831
    Damage: 662,365
    Healing: 405,165
Player 4
    Loot: 133,568
    Supplies: 73,271
    Balance: 60,297
    Damage: 795,768
    Healing: 210,770"
  end

  def self.parsed_loot_message_4_v2_players
    { "hunt_info" =>
        { "Balance" => "440798",
          "Loot" => "816876",
          "Loot Type" => "Leader",
          "Session" => "01:22h",
          "Session data" => "From 2020-10-10 06:00:44 to 2020-10-10 07:23:18",
          "Supplies" => "376078"
        },
      "players_balance" => [
        { "Balance" => "464674", "Damage" => "480353", "Healing" => "12415", "Loot" => "523273", "Supplies" => "58599", "name" => "Player 1" },
        { "Balance" => "50658", "Damage" => "902383", "Healing" => "172778", "Loot" => "158735", "Supplies" => "108077", "name" => "Player 2" },
        { "Balance" => "-134831", "Damage" => "662365", "Healing" => "405165", "Loot" => "1300", "Supplies" => "136131", "name" => "Player 3 (Leader)" },
        { "Balance" => "60297", "Damage" => "795768", "Healing" => "210770", "Loot" => "133568", "Supplies" => "73271", "name" => "Player 4" }
      ]
    }
  end

  def self.final_balance_for_4_v2_players
    {
      "hunt_session" => "From 2020-10-10 06:00:44 to 2020-10-10 07:23:18",
      "share_per_player" => '110,199',
      "number_of_players" => 4,
      "amount_to_transfer" => {
        "Player 2" => 59541,
        "Player 3 (Leader)" => 245030,
        "Player 4" => 49902
      },
      "centralizing_payments" => []
    }
  end
end