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
      choose_person(i, @m_list,@m_list,"man")
    end
  end

  def mix_rane (rane)
    for i in @man_rane+1..@man_rane+@mix_rane do
      choose_person(i,@m_list,@f_list, "mix" )
    end
  end

  def female_rane (rane)
    for i in @man_rane+ @mix_rane +1 .. @man_rane+@mix_rane+@female_rane do
      choose_person(i,@f_list,@f_list,"same")
    end
  end

  def choose_roop(rane, list1, list2, sex)
    # 変数の初期化
    @min_time1 = 100
    @min_time2 = 100
    @flag = true
    while(@flag)

      # グループ１のリスティング
      min_time = 100
      list1.each do |player|
        time = player.sum_time
        if(time < min_time && time <= @min_time1)
          #最小値の更新。ただし前回の最小値以下のものは採用しない
          min_time = time
        end
      end
      # これ以上候補がいない場合
      if(@min_time1 == min_time)
        @flag = false
        break
      end
      @min_time1 = min_time
      new_list1 = list1.where("sum_time=#{min_time}")


      # グループ2のリスティング
      min_time = 100
      list2.each do |player|
        time = player.sum_time
        if(time < min_time && time <= @min_time2)
          min_time = time
        end
      end
      # これ以上候補がいない場合
      if(@min_time2 == min_time)
        @flag = false
        break
      end
      @min_time2 = min_time
      new_list2 = list2.where("sum_time=#{min_time}")

      choose_person(rane, new_list1,new_list2, sex)
    end
  end

  def choose_person (rane, list1, list2, sex)
    #一人目 （ストローク）
    c_list = choose_new(list1)
    c_list = choose_stroker(c_list) if sex != "mix"
    c_list = choose_least(c_list, sex)
    player1 = choose_dur(c_list)
    player1 ||= @com

    @now_players.push(player1.id)

    #二人目　（ボレー）
    c_list = choose_new(list2)
    c_list = played_with(c_list, player1)
    c_list = choose_least(c_list,sex, "v")
    player2 = choose_dur(c_list)
    player2 ||= @com

    @now_players.push(player2.id)

    #playerが自分のカラムを書き換えるためのmethodデータ
    method = sex == "mix" ? "mix" : "stroke"
    player1.update_attribute(:method, method) if !player1.com
    if sex == "mix"
      player2.update_attribute(:method, "mix") if !player2.com
    else
      player2.update_attribute(:method, "volley") if !player2.com
    end
    #ループ続けるかどうか
    if(player1 == @com || player2 == @com)
      @flag = true
    else
      @flag = false
    end
  end

  #roundに入っていない人を選定
  def choose_new(list)
    n_list = Array.new
   list.each do |player|
       tof = @now_players.include?(player.id) ? false : true
       tof = false if @now_players.include?(player.forbidden.to_i)
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
      if sex =="mix"
        least_time = player.o_time < least_time ? player.o_time : least_time
      elsif vos == "v"
        least_time = player.v_time < least_time ? player.v_time : least_time
      else
        least_time = player.time < least_time ? player.time : least_time
      end
    end
    #list
    list.each do |player|
      if sex == "mix"
        l_list.push(player) if player.o_time == least_time
      elsif vos == "v"
        l_list.push(player) if player.v_time == least_time
      else
        l_list.push(player) if player.time == least_time
      end
    end
    return l_list
  end
  #volleyに入れていない人をstrokeの候補から除外する
  def choose_stroker (list)
    val = Array.new
    #平均のvolley回数の導出
    avg_time = 0
    num = list.length
    list.each do |player|
      avg_time += player.v_time
      puts player.v_time
    end
    avg_time /= num
    puts avg_time
    list.each do |player|
      unless(player.v_time < avg_time)
        val.push(player)
      end
    end
  end
end
