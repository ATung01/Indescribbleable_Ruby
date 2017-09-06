class MatchesController < ApplicationController


  def create
    r_code = params[:roomCode]
    nick = params[:nickname]
    current_match = Match.find_or_create_by(room_code: r_code)
    if current_match.users.find_by(nickname: nick)
      render json: {error: "that name is taken"} and return
    elsif current_match.users.length < 6
      current_user = current_match.users.create(nickname: nick)
    else
      render json: {error: "that room is full"} and return
    end
    status = {
      roomCode: r_code,
      users: current_match.users,
      current_user: current_user
    }
    render json: status
  end

  def show
    current_match = Match.find_by(id: params[:id])
    status = {
      users: current_match.users,
      started: current_match.started,
      sketch: current_match.sketch ? current_match.sketch : ""
    }
    render json: status
  end


  def update
    current_match = Match.find_by(id: params[:id])
    current_match.started = true
    current_match.save

    render json: current_match

  end

  def turn_end
    #called at end of turn, makes has_gone true, makes someone else the current user

  end



end
