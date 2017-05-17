class WikisController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @wikis = Wiki.view(current_user)
    if params[:free].present?
      view = params[:free]
      @wikis = view.to_i == 1 ? @wikis.free : @wikis.paid
      respond_to do |format|
        format.html { render js: index.js.erb }
      end
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = 'Wiki saved successfully.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving your wiki. Please try again.'
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if params[:users].present?
      admins = User.admin.pluck(:id)
      @wiki.collaborators.where.not(user_id: admins).destroy_all
      # @wiki.collaborators.destroy_all
      # User.admin.each do |user|
      # => @wiki.collaborators.build(user_id: user.id)
      # end
      users = params[:users]
      users.each do |user|
        @wiki.collaborators.build(user_id: user.to_i)
      end
    end
    if params[:wiki].present?
      @wiki.assign_attributes(wiki_params)
    end

    if @wiki.save
      flash[:notice] = 'Wiki updated successfully.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error updating your wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error deleting the wiki. Please try again'
      render :show
    end
  end

  def view
    @view = params[:paid]
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def user_not_authorized
    if current_user.account_active?
      flash[:alert] = 'You are not authorized to do this - go back from whence you came.'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Your account is not activated yet and only has limited access. Complete the payment to activate it.'
      redirect_to new_charge_path
    end
  end
end
