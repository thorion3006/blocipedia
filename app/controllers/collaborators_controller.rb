class CollaboratorsController < ApplicationController
  def index
    @users = User.where.not(uname: current_user.uname).where.not(role: 'admin')
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
  end
end
