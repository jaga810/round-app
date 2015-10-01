module RoundsHelper

  def man_rane (rane)
    for i in 1..rane do
      choose_person(i, @m_list,"same")
    end
  end

  def mix_rane (rane)
    for i in @man_rane+1..@man_rane+@mix_rane do
      choose_person(i,@f_list, "opposite" )
    end
  end

  def play(rane, list)
    list.each do |player|
      if @now_players.include?(player)
      else
        eval("#{player}.play")
      end
    end
    for i in 1..rane do

      s1 = ""
      s2 = ""

      eval("s1 = @player_#{i}a")
      eval("s2 = @player_#{i}b")


      n = 1
      n = 4 if i > @m_rane

      if s1.blank? || s2.nil?
        next
      end
      eval("#{s1}.play('#{s2}',#{n})")
      eval("#{s2}.play('#{s1}',#{n})")
    end
  end

  def choose_person (rane, list, sex)

    st1 = "@player_#{rane}a"
    st2 = "@player_#{rane}b"

    #一人目
    c_list = choose_new($m_list)
    c_list = choose_least(c_list, sex)
    eval("#{st1} = choose_dur(c_list)")

    #二人目
    c_list = choose_new(list)
    eval("c_list = played_with(c_list, #{st1})")
    c_list = choose_least(c_list,"same")
    eval("#{st2} = choose_dur(c_list)")

  end

  def played_with(list , player1)
    w_list = Array.new
    list.each do |player|
      tof = true
      eval("tof = false if #{player}.played_player.include?(player1)")
      if tof
        w_list.push(player)
      end
    end
    return w_list
  end


  #配列もらって人を返す
  def choose_dur(list)
    d_list = Array.new
    long_dur = 0
    can = String.new

    list.each do |player|
      tof = false
      eval("tof = true if #{player}.duration > long_dur")

      if tof
        eval("long_dur = #{player}.duration")
      end

    end

    list.each do |player|
      tof = false
      eval("tof = true if #{player}.duration == long_dur")

      if tof
        d_list.push(player)
      end
    end

    if d_list.empty?
      can = list[rand(list.length)]
    else
      can = d_list[rand(d_list.length)]
    end

    @now_players.push(can)
    return can

  end

  def choose_new(list)
    n_list = Array.new
   list.each do |player|
       tof = true
       tof = false if @now_players.include?(player)
      if tof
        n_list.push(player)
      end
   end
   return n_list
  end

  #配列を受け取って配列を返す
  def choose_least(list, sex)
    l_list = Array.new
    least_time = 100

    list.each do |player|

      tof = false
      if sex == "same"
        eval("tof = true if #{player}.played_time < least_time")
      else
        eval("tof = true if #{player}.f_time < least_time")
      end
      if tof
        if sex == "same"
        eval("least_time = #{player}.played_time")
        else
          eval("least_time = #{player}.f_time")
        end
      end
    end

    list.each do |player|

      tof = false
      if sex == "same"
      eval("tof = true if #{player}.played_time == least_time")
      else
        eval("tof = true if #{player}.f_time == least_time")
      end

      if tof
        l_list.push(player)
      end
    end

    return l_list
  end
end
