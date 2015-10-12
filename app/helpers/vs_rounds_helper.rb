module VsRoundsHelper

  def play(rane, list)
    list.each do |player|
      if @now_players.include?(player.id)
        player.play
      else
        player.not_play
      end
    end
    #誰と対戦したかの記録
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

  def man_rane (rane)
    for i in 1..rane do
      choose_person(i, @m_list,"man")
    end
  end

  def mix_rane (rane)
    for i in @man_rane+1..@man_rane+@mix_rane do
      choose_person(i,@f_list, "mix" )
    end
  end

  def choose_person (rane, list, sex)
    #一人目 （ストローク）
    c_list = choose_new(@m_list)
    c_list = choose_least(c_list, sex)
    player1 = choose_dur(c_list)
    player1 ||= @com

    @now_players.push(player1.id)

    #二人目　（ボレー）
    c_list = choose_new(list)
    c_list = played_with(c_list, player1)
    c_list = choose_least(c_list,sex, "v")
    player2 = choose_dur(c_list)
    player2 ||= @com

    @now_players.push(player2.id)

    #playerが自分のカラムを書き換えるためのmethodデータ
    method = sex == "mix" ? "mix" : "stroke"
    player1.update_attribute(:method, method) if !player1.com
    player2.update_attribute(:method, "volley") if !player2.com
  end

  #roundに入っていない人を選定
  def choose_new(list)
    n_list = Array.new
   list.each do |player|
       tof = @now_players.include?(player.id) ? false : true
      if tof
        n_list.push(player)
      end
   end
   return n_list
  end

  #対戦していないか
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
      tof = false
      # eval("tof = true if #{player}.duration > long_dur")
        long_dur = player.duration if player.duration > long_dur
    end

    list.each do |player|
      tof = false
      # eval("tof = true if #{player}.duration == long_dur")
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

  #入った回数が一番少ない人
  def choose_least(list, sex , vos=nil)
    l_list = Array.new
    least_time = 100

    list.each do |player|
      if vos == "v" && sex =="man"
        least_time = player.v_time < least_time ? player.v_time : least_time
      elsif sex == "mix"&& player.gender == "male"
        least_time = player.o_time < least_time ? player.o_time : least_time
      else
        least_time = player.time < least_time ? player.time : least_time
      end
    end
    #list
    list.each do |player|
      if sex == "man" && vos == "v"
        l_list.push(player) if player.v_time == least_time
      elsif sex == "mix"&& player.gender == "male"
        l_list.push(player) if player.o_time == least_time
      else
        l_list.push(player) if player.time == least_time
      end
    end
    return l_list
  end
end
