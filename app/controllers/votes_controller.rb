class VotesController < ApplicationController

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = current_user.boards.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def vote_params
    params.require(:vote).permit(:status).merge(user_id: current_user.id)
  end
end
