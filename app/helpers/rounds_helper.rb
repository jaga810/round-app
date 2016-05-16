module RoundsHelper
  def man_rane (rane)
    for i in 1..rane do
      choose_person(i, @m_list, @m_list,"same")
    end
  end
  def mix_rane (rane)
    for i in @man_rane+1..@man_rane + @mix_rane do
      choose_person(i,@m_list, @f_list, "opposite" )
    end
  end

  def female_rane(rane)
    for i in @man_rane + @mix_rane + 1..@man_rane+@mix_rane+@female_rane do
      choose_person(i, @f_list, @f_list, "same")
    end
  end

  def play(rane, list)
    list.each do |player|
      if @now_players.include?(player.id)
        player.play
      else
        player.not_play
      end
    end

    #対戦相手の記録
    for num in 0..rane-1 do
      player1 = Player.find(@now_players[num * 2])
      player2 = Player.find(@now_players[num * 2 + 1])

      next if player1.com || player2.com

      list1 = player1.played_player.split(" ")
      list2 = player2.played_player.split(" ")

      list1.push(player2.id)
      list2.push(player1.id)

      player1.update_attribute(:played_player, list1.join(" "))
      player2.update_attribute(:played_player, list2.join(" "))
    end
  end

  def choose_person (rane, list1, list2, sex)

    #一人目
    c_list = choose_new(list1)
    c_list = choose_least(c_list, sex)
    player1 = choose_dur(c_list)
    player1 ||= @com

    @now_players.push(player1.id)

    #二人目
    c_list = choose_new(list2)
    c_list = played_with(c_list, player1)
    c_list = choose_least(c_list,sex)
    player2 = choose_dur(c_list)
    player2 ||= @com

    @now_players.push(player2.id)

    #playerが自分のカラムを書き換えるためのmethodデータ
    method = sex == "opposite" ? "mix" : "man"
    player1.update_attribute(:method, method) if !player1.com
    player2.update_attribute(:method, method) if !player2.com
  end

  def played_with(list , player1)
    w_list = Array.new
    list.each do |player|
      play_list = player.played_player.split(" ")

      tof = play_list.include?(player1.id.to_s) ? false : true
      if tof
        w_list.push(player)
      end
    end
    return w_list
  end


  #durationにより人を選定
  def choose_dur(list)
    d_list = Array.new
    long_dur = 0
    can = String.new

    list.each do |player|
      long_dur = player.duration if player.duration > long_dur
    end

    list.each do |player|
      tof = false
      tof = true if player.duration == long_dur
      if tof
        d_list.push(player)
      end
    end

    if d_list.empty?
      can = list[rand(list.length)]
    else
      can = d_list[rand(d_list.length)]
    end
    return can
  end

  #roundに入っていない人を選定
  def choose_new(list)
    n_list = Array.new
   list.each do |player|
       tof = true
       tof = false if @now_players.include?(player.id)
       tof = false if @now_players.include?(player.forbidden.to_i)
      #  puts "tof:" + tof.to_s
      #  puts "player:" + player.id.to_s
      #  puts "f player:" + player.forbidden
      #  puts "nowplayer" + @now_players.to_s
      if tof
        n_list.push(player)
      end
   end
   return n_list
  end

  #roundに入った回数が少ない人を選定
  def choose_least(list, sex)
    l_list = Array.new
    least_time = 100

    list.each do |player|
      if sex == "same"
        least_time = player.time < least_time ? player.time : least_time
      else
        least_time = player.o_time < least_time ? player.o_time : least_time
      end
    end

    list.each do |player|
      tof = false
      if sex == "same"
        tof = player.time == least_time ? true : false
      else
        tof = player.o_time == least_time ? true : false
      end

      if tof
        l_list.push(player)
      end
    end
    return l_list
  end

  def com(player)
    player = @com if player.blank?
    # puts "com"
    # puts player
  end
end
