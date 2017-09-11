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

  # def show
  #   current_match = Match.find_by(id: params[:id])
  #   if current_match.users.find_by(your_turn?:true)
  #     my_turn = true
  #   else
  #     my_turn = false
  #   end
  #   status = {
  #     users: current_match.users,
  #     started: current_match.started,
  #     sketch: current_match.sketch ? current_match.sketch : "",
  #     current_turn: current_match.users.find_by(your_turn?: true)
  #   }
  #
  #   render json: status
  # end


  def update
    # #starts the match
    # current_match = Match.find_by(id: params[:id])
    # current_match.started = true
    # current_match.gen_answer
    # current_match.save
    # current_user = current_match.users.find_by(id: params[:currentUserID])
    # current_user[:your_turn?] = true
    # current_user.save
    #
    # render json: current_match
  end

  def turn_end
    # current_user = User.find_by(id: params[:currentUserID])
    # next_user = current_user.end_turn
    #
    # render json: next_user
  end

  def handle_guess
    current_match = Match.find_by(id: params[:id])
    guess = params[:guess]


  end



end
