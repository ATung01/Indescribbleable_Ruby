class MatchesController < ApplicationController


  def create
    Match.all.each do |m|
      if ((Time.now - m.created_at)/60) > 30
        m.destroy
      end
    end
    r_code = params[:roomCode]
    nick = params[:nickname]
    current_match = Match.find_or_create_by(room_code: r_code)
    if current_match.started == "t"
    render json: {error: "That game has already started!"} and return
    elsif current_match.users.find_by(nickname: nick)
      render json: {error: "That name is taken!"} and return
    elsif current_match.users.length < 6
      current_user = current_match.users.create(nickname: nick)
    else
      render json: {error: "That room is full!"} and return
    end
    status = {
      roomCode: r_code,
      users: current_match.users,
      current_user: current_user
    }

    render json: status
  end




end
