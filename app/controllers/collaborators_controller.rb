class CollaboratorsController < ApplicationController
  def index
    users = User.where.not(uname: current_user.uname)
    @users = users.where.not(role: 'admin')
    @wiki = Wiki.find(params[:format])
    @collaborators = @wiki.collaborators
  end

  def cryuauauu
  end
end
